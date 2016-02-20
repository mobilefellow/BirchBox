//
//  BBManager.h
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBConstants.h"

@class BBProduct;

@interface BBManager : NSObject

+ (instancetype)sharedInstance;

- (void)fetchProduct:(NSString*)productId withCompletion:(BBIdResultBlock)completion;

@end
