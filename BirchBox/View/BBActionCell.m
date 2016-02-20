//
//  BBActionCell.m
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "BBActionCell.h"
#import "Birchbox.h"

static NSString *const kCellReuseID = @"ActionCell";

@interface BBActionCell ()

@property (copy, nonatomic) BBVoidBlock block;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

- (IBAction)actionButtonTouched:(id)sender;

@end


@implementation BBActionCell

#pragma mark - Cycle

- (void)awakeFromNib {
    self.titleLabel.text = @"";
    self.reviewCountLabel.text = @"";
    self.priceLabel.text = @"";
    [self.actionButton setTitle:@"" forState:UIControlStateNormal];
}

#pragma mark - Public Methods

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    BBActionCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID];
    
    if ([cell isKindOfClass:[BBActionCell class]]) {
        return cell;
    } else {
        return nil;
    }
}

- (void)configureWithProduct:(BBProduct *)product {
    self.titleLabel.text = product.name;

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    self.priceLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:product.price]];

    if (product.reviewCount > 1) {
        self.reviewCountLabel.text = [NSString stringWithFormat:@"%lu Reviews", (unsigned long)product.reviewCount];
    } else {
        self.reviewCountLabel.text = [NSString stringWithFormat:@"%lu Review", (unsigned long)product.reviewCount];
    }
    
    if ([product.pageButtonType isEqualToString:kValuePageButtonTypeAdd]) {
        self.actionButton.hidden = NO;
        [self.actionButton setTitle:kTitleAddToCart forState:UIControlStateNormal];
        [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.actionButton.backgroundColor = [UIColor blackColor];

    } else if ([product.pageButtonType isEqualToString:kValuePageButtonTypeWaitlist]) {
        self.actionButton.hidden = NO;
        [self.actionButton setTitle:kTitleOutOfStock forState:UIControlStateNormal];
        [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.actionButton.backgroundColor = BBHexColor(0x999999);

    } else {
        self.actionButton.hidden = YES;
    }
}

- (void)handleButtonTouched:(BBVoidBlock)block {
    self.block = block;
}


#pragma mark - UI Action

- (IBAction)actionButtonTouched:(id)sender {
    if (self.block) {
        self.block();
    }
}
@end
