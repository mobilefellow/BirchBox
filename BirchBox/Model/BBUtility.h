//
//  BBUtility.h
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

@interface BBUtility : NSObject

#pragma mark - UI
+ (void)showHintToView:(UIView*)view message:(NSString*)msg;
+ (void)showHintToView:(UIView*)view message:(NSString*)msg displayTime:(NSUInteger)interval;

#pragma mark - String
+ (BOOL)isBlankString:(NSString*)str;
+ (NSString*)joinStringWithFirst:(NSString*)first second:(NSString*)second joiner:(NSString*)joiner;

@end
