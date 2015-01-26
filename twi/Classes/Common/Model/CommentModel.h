//
//  CommentModel.h
//  twi_iOS
//
//  Created by zerd on 15-1-17.
//  Copyright (c) 2015年 zerd. All rights reserved.
//  评论

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString *text;             //评论内容
@property (nonatomic, strong) UserModel *user;          //评论作者

- (id)initWithDict:(NSDictionary *)dict;

@end
