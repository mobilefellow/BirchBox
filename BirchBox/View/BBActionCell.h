//
//  BBActionCell.h
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "BBBaseTableViewCell.h"
#import "BBConstants.h"

@class BBProduct;

@interface BBActionCell : BBBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView*)tableView;
- (void)configureWithProduct:(BBProduct*)product;
- (void)handleButtonTouched:(BBVoidBlock)block;

@end
