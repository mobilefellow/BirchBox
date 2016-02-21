//
//  BBProduct.h
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBPrice;

@interface BBProduct : NSObject

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger reviewCount;
@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *productDescription;
@property (nonatomic, copy) NSString *howToUse;
@property (nonatomic, copy) NSString *ingredients;
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *pageButtonType;
@property (nonatomic, copy) NSArray *images;

@end
