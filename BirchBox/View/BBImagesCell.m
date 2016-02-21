//
//  BBImageCell.m
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "BBImagesCell.h"
#import <UIImageView+AFNetworking.h>

static NSString *const kCellReuseID = @"ImagesCell";

@interface BBImagesCell ()

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation BBImagesCell


#pragma mark - Public Methods

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    BBImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID];
    
    if ([cell isKindOfClass:[BBImagesCell class]]) {
        return cell;
    } else {
        return nil;
    }
}

- (void)configureWithImageUrls:(NSArray *)imageUrls {
    NSString *string = imageUrls.firstObject;
    NSURL *url = [NSURL URLWithString:string];
    [self.productImageView setImageWithURL:url
                          placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)configureWithPid:(NSString *)pId {
    self.label.text = pId;
}

@end
