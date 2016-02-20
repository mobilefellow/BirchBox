//
//  BBUtility.m
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "BBUtility.h"
#import "BBConstants.h"

@implementation BBUtility

#pragma mark - UI
+ (void)showHintToView:(UIView *)view message:(NSString *)msg {
    [self showHintToView:view message:msg displayTime:2];
}

+ (void)showHintToView:(UIView*)view message:(NSString*)msg displayTime:(NSUInteger)interval {
    if ([BBUtility isBlankString:msg]) {
        NSLog(@"%s: msg == nil", __func__);
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    
    CGSize msgSize = [msg sizeWithAttributes:@{NSFontAttributeName: hud.labelFont}];
    if (msgSize.width > (kUISizeScreenWidthToMargin - 48)) {
        hud.detailsLabelText = msg;
    } else {
        hud.labelText = msg;
    }
    
    [hud hide:YES afterDelay:interval];
}

#pragma mark - String
+ (BOOL)isBlankString:(NSString*)str {
    BOOL res;
    if((str != nil)
       && (![str isEqualToString:@""])
       && (str.length != 0)) {
        res = false;
    } else {
        res = true;
    }
    return res;
}

+ (NSString*)joinStringWithFirst:(NSString*)first second:(NSString*)second joiner:(NSString *)joiner {
    if (!first && !second) {
        NSLog(@"%s: Both string is nil!", __func__);
        return @"";
    }
    
    NSMutableString *newStr = [[NSMutableString alloc]init];
    if (first) {
        [newStr appendString:first];
    }
    
    if (second) {
        if (newStr.length > 0) {
            [newStr appendFormat:@"%@%@", joiner, second];
        } else {
            [newStr appendString:second];
        }
    }
    
    return newStr;
}

@end
