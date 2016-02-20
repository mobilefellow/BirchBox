//
//  BBTextCell.m
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "BBTextCell.h"
#import "Birchbox.h"

static NSString *const kCellReuseID = @"TextCell";
static CGFloat const kEdgeTopBodyLabel = 15;

@interface BBTextCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bodyLabelTopConstraint;

@end


@implementation BBTextCell
#pragma mark - Cycle

- (void)awakeFromNib {
    self.titleLabel.text = @"";
    self.bodyLabel.text = @"";
}

#pragma mark - Public Methods

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    BBTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID];
    
    if ([cell isKindOfClass:[BBTextCell class]]) {
        return cell;
    } else {
        return nil;
    }
}

- (void)configureWithTitle:(NSString *)title body:(NSString *)body isLastCell:(BOOL)isLastCell {
    self.titleLabel.text = title;
    self.bodyLabel.text = body;
    
    if ([BBUtility isBlankString:body]
        && !isLastCell) {
        self.bodyLabelTopConstraint.constant = 0;
    } else {
        self.bodyLabelTopConstraint.constant = kEdgeTopBodyLabel;
    }
}

@end
