//
//  WeiboAccount.h
//  微博
//
//  Created by zerd on 14-10-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboAccount : NSObject <NSCoding>

@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *accessToken;

@end
