//
//  BBProductViewController.m
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "BBProductViewController.h"
#import "Birchbox.h"
#import "BBImagesCell.h"
#import "BBActionCell.h"
#import "BBTextCell.h"
#import <UIScrollView+SVPullToRefresh.h>
#import <UIScrollView+EmptyDataSet.h>

static NSString *const kCellImages = @"CellImages";
static NSString *const kCellAction = @"CellAction";
static NSString *const kCellBirchbox = @"CellBirchbox";
static NSString *const kCellHowToUse = @"CellHowToUse";
static NSString *const kCellIngredients = @"CellIngredients";
static NSString *const kCellBrand = @"CellBrand";

@interface BBProductViewController ()<
UITableViewDataSource, UITableViewDelegate,
DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic, copy) NSArray *rowTypes;
@property(nonatomic, strong) BBProduct *product;
@property(nonatomic, strong) BBError *productError;
@property(nonatomic, strong) NSError *networkError;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BBProductViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureData];
    [self configureTableView];
}

#pragma mark - Public Methods

- (void)configureWithProductId:(NSString *)productId {
    self.productId = productId;
}

#pragma mark - Private Methods

- (void)configureData {
    self.rowTypes = @[
                      kCellImages,
                      kCellAction,
                      kCellBirchbox,
                      kCellHowToUse,
                      kCellIngredients,
                      kCellBrand];
}

- (void)configureTableView {
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;

    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf fetchAndReloadProductRows];
    }];
    
    
    if (self.product == 0) {
        [self.tableView triggerPullToRefresh];
    }
}

#pragma mark - Fetch And Reload
///Hide loading animation at the top
- (void)hideTopLoading {
    [self.tableView.pullToRefreshView stopAnimating];
}

- (void)fetchAndReloadProductRows {
    if ([BBUtility isBlankString:self.productId]) {
        return;
    }

    BBManager *manager = [BBManager sharedInstance];
    [manager fetchProduct:self.productId withCompletion:^(id object, NSError *error) {
        if ([object isKindOfClass:[BBProduct class]]) {
            self.product = (BBProduct*)object;
            self.productError = nil;
            self.networkError = nil;
        } else if ([object isKindOfClass:[BBError class]]) {
            self.product = nil;
            self.productError = (BBError*)object;
            self.networkError = nil;
        } else {
            self.product = nil;
            self.productError = nil;
            self.networkError = error;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideTopLoading];
            [self.tableView reloadData];
        });
    }];
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number;
    if (self.product) {
        number = self.rowTypes.count;
    } else {
        number = 0;
    }
    
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    NSString *rowType = self.rowTypes[indexPath.row];
    if ([rowType isEqualToString:kCellImages]) {
        cell = [self imagesCellForRowAtIndexPath:indexPath];
        
    } else if ([rowType isEqualToString:kCellAction]) {
        cell = [self actionCellForRowAtIndexPath:indexPath];
        
    } else {
        cell = [self textCellForRowAtIndexPath:indexPath rowType:rowType];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell*)imagesCellForRowAtIndexPath:(NSIndexPath*)indexPath {
    BBImagesCell * cell = [BBImagesCell cellWithTableView:self.tableView];
    
    [cell configureWithImageUrls:self.product.images];
    
    return cell;
}

- (UITableViewCell*)actionCellForRowAtIndexPath:(NSIndexPath*)indexPath {
    BBActionCell * cell = [BBActionCell cellWithTableView:self.tableView];
    
    [cell configureWithProduct:self.product];
    [cell handleButtonTouched:^{
        [BBUtility showHintToView:self.view message:@"Button is touched"];
    }];
    
    return cell;
}

- (UITableViewCell*)textCellForRowAtIndexPath:(NSIndexPath*)indexPath rowType:(NSString*)rowType {
    BBTextCell * cell = [BBTextCell cellWithTableView:self.tableView];
    
    NSString *title, *body;
    if ([rowType isEqualToString:kCellBirchbox]) {
        title = kTitleBirchboxBreakdown;
        body = self.product.productDescription;
        
    } else if ([rowType isEqualToString:kCellHowToUse]) {
        title = kTitleHowToUse;
        body = self.product.howToUse;
        
    } else if ([rowType isEqualToString:kCellIngredients]) {
        title = kTitleIngredients;
        body = self.product.ingredients;
        
    } else if ([rowType isEqualToString:kCellBrand]) {
        title = [BBUtility joinStringWithFirst:kTitleBrandName second:self.product.brand joiner:@": "];
        body = nil;
        
    }
    
    BOOL isLastCell = (indexPath.row == (self.rowTypes.count - 1));
    [cell configureWithTitle:title body:body isLastCell:isLastCell];
    
    return cell;
}


#pragma mark - DZNEmptyDataSet
/**
 *  Show empty row hint only if no data is fetching.
 */
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    BOOL shouldDisplay;
    
    if (self.productError || self.networkError) {
        shouldDisplay = YES;
    } else {
        shouldDisplay = NO;
    }
    
    return shouldDisplay;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text;
    
    if (self.productError) {
        text = self.productError.title;
    } else if (self.networkError) {
        text = kTitleUnknownError;
    } else {
        return nil;
    }

    UIFont *font = [UIFont boldSystemFontOfSize:30];
    UIColor *textColor = [UIColor darkGrayColor];
    NSDictionary *dic = @{NSFontAttributeName: font,
                          NSForegroundColorAttributeName: textColor};

    
    return [[NSAttributedString alloc]initWithString:text attributes:dic];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text;
    
    if (self.productError) {
        text = self.productError.message;
    } else {
        return nil;
    }

    UIFont *font = [UIFont boldSystemFontOfSize:30];
    UIColor *textColor = [UIColor darkGrayColor];
    NSDictionary *dic = @{NSFontAttributeName: font,
                          NSForegroundColorAttributeName: textColor};
    
    
    return [[NSAttributedString alloc]initWithString:text attributes:dic];
}

@end
