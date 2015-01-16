//
//  WeiboAccountTool.m
//  微博
//
//  Created by zerd on 14-10-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  

#import "WeiboAccountTool.h"

#define kFilePath  [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"account.data"]

@implementation WeiboAccountTool

static WeiboAccountTool *_instance;

singleton_implementation(WeiboAccountTool)

-(instancetype)init{
    if (self = [super init]){
        _currentCount = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    }
    
    return self;
}

- (void)saveWeiboAccount:(WeiboAccount *)account{
    _currentCount = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFilePath];
}

@end
