//
//  BBConstants.h
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef BBConstants_h
#define BBConstants_h

@class BBProduct;

#pragma mark - Default Values
static NSString *const kKeyName = @"name";
static NSString *const kKeyReviewCount = @"review_count";
static NSString *const kKeyAmount = @"amount";
static NSString *const kKeyCurrency = @"currency";
static NSString *const kKeyPrice = @"price";
static NSString *const kKeyDescription = @"description";
static NSString *const kKeyHowToUse = @"how_to_use";
static NSString *const kKeyIngredients = @"ingredients";
static NSString *const kKeyBrand = @"brand";
static NSString *const kKeyPageButtonType = @"page_button_type";
static NSString *const kKeyImages = @"images";
static NSString *const kKeyUrl = @"url";
static NSString *const kKeyError = @"error";
static NSString *const kKeyMessage = @"message";
static NSString *const kKeyTitle = @"title";
static NSString *const kValueProductBaseUrl = @"https://api.birchbox.com/products/";
static NSString *const kValuePageButtonTypeAdd = @"add";
static NSString *const kValuePageButtonTypeWaitlist = @"waitlist";
static NSString *const kValuePageButtonTypeNone = @"none";

#pragma mark - UI Title
static NSString *const kTitleAddToCart = @"Add To Cart";
static NSString *const kTitleOutOfStock = @"Out Of Stock";
static NSString *const kTitleBirchboxBreakdown = @"Birchbox Breakdown";
static NSString *const kTitleHowToUse = @"How To Use";
static NSString *const kTitleIngredients = @"Ingredients";
static NSString *const kTitleBrandName = @"Brand Name";

#pragma mark - Storyboard
static NSString *const kStoryboardControllerProduct = @"ProductViewController";

#pragma mark - Color
#define BBHexColor(a) [UIColor colorWithRed:(a>>16)/255.0 green:(a>>8&0xff)/255.0 blue:(a&0xff)/255.0 alpha:1]

#pragma mark - UI Size
static const float kUISizeMarginX = 14;
static const float kUISizeMarginY = 7;

#define kUISizeScreenWidthToMargin   kUISizeScreenWidth - 2*kUISizeMarginX
#define kUISizeScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kUISizeScreenHeight  [UIScreen mainScreen].bounds.size.height

#pragma mark - Block
typedef void (^BBVoidBlock)(void);
typedef void (^BBIdResultBlock)(id object, NSError *error);


#endif /* BBConstants_h */
