//
//  CommentModel.m
//  twi_iOS
//
//  Created by zerd on 15-1-17.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.text = dict[@"text"];
        self.user = [[UserModel alloc]initWithDict:dict[@"user"]];
    }
    
    return self;
}

@end
