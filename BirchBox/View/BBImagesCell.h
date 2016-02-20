//
//  BBImageCell.h
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "BBBaseTableViewCell.h"

@interface BBImagesCell : BBBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView*)tableView;
- (void)configureWithImageUrls:(NSArray*)imageUrls;

@end
