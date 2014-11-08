//
//  WeiboAccountTool.h
//  微博
//
//  Created by zerd on 14-10-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  管理帐号信息

#import <Foundation/Foundation.h>
#import "WeiboAccount.h"
#import "Singleton.h"

@interface WeiboAccountTool : NSObject

singleton_interface(WeiboAccountTool)

- (void)saveWeiboAccount:(WeiboAccount *)account;

@property (nonatomic,readonly) WeiboAccount *currentCount;


@end
