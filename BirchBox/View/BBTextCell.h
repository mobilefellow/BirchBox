//
//  BBTextCell.h
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "BBBaseTableViewCell.h"

@interface BBTextCell : BBBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView*)tableView;
- (void)configureWithTitle:(NSString*)title body:(NSString*)body isLastCell:(BOOL)isLastCell;

@end
