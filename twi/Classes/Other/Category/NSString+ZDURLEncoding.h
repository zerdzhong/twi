//
//  NSString+ZDURLEncoding.h
//  twi_iOS
//
//  Created by zerd on 15-2-4.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZDURLEncoding)

- (NSString *)URLEncodedString;

- (NSString*)URLDecodedString;

@end
