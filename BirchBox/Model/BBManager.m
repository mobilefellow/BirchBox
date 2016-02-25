//
//  BBManager.m
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "Birchbox.h"
#import <AFNetworking.h>

@implementation BBManager

+ (instancetype)sharedInstance {
    static BBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BBManager alloc]init];
    });
    return manager;
}

- (void)fetchProduct:(NSString *)productId withCompletion:(BBIdResultBlock)completion {
    NSString *string = [NSString stringWithFormat:@"%@%@", kValueProductBaseUrl, productId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setValidatesDomainName:NO];
    [policy setAllowInvalidCertificates:NO];
    manager.securityPolicy = policy;
    
    [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = responseObject;
        if ([resultDic.allKeys containsObject:kKeyError]) {
            BBError *error = [[BBError alloc]init];
            error.message = resultDic[kKeyMessage];
            error.title = resultDic[kKeyTitle];
            if (completion) {
                completion(error, nil);
            }
        } else {
            BBProduct *product = [[BBProduct alloc]init];
            product.productId = productId;
            product.name = resultDic[kKeyName];
            product.reviewCount = [resultDic[kKeyReviewCount] unsignedIntegerValue];
            product.productDescription = resultDic[kKeyDescription];
            product.howToUse = resultDic[kKeyHowToUse];
            product.ingredients = resultDic[kKeyIngredients];
            product.brand = [resultDic[kKeyBrand] isKindOfClass:[NSNull class]] ? nil : resultDic[kKeyBrand];
            product.pageButtonType = resultDic[kKeyPageButtonType];
            
            NSDictionary *priceDic = resultDic[kKeyPrice];
            if (priceDic) {
                product.price = [priceDic[kKeyAmount] floatValue];
            }
            NSMutableArray *images = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in resultDic[kKeyImages]) {
                [images addObject:dic[kKeyUrl]];
            }
            product.images = images;
            if (completion) {
                completion(product, nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}


@end
