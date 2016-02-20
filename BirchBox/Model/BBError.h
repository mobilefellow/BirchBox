//
//  BBError.h
//  BirchBox
//
//  Created by Steven on 2/20/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBError : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *title;

@end
