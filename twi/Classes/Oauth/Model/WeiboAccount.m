//
//  WeiboAccount.m
//  微博
//
//  Created by zerd on 14-10-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "WeiboAccount.h"

@implementation WeiboAccount

#pragma mark- 归档

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_accessToken forKey:@"accessToken"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}

@end
