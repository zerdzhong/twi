//
//  StatusModel.h
//  微博
//
//  Created by zerd on 14-10-20.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface TweetModel : NSObject

@property (nonatomic, copy) NSString *text;             //微博内容
@property (nonatomic, strong) UserModel *user;          //微博作者
@property (nonatomic, strong) NSArray *picURLs;         //微博配图
@property (nonatomic, strong) TweetModel *reStatus;    //转发的微博
@property (nonatomic, assign) int64_t ID;

@property (nonatomic, copy) NSString* createdTime;       //创建时间

@property (nonatomic, assign) int repostsCount;         //转发数
@property (nonatomic, assign) int commentsCount;        //评论数
@property (nonatomic, assign) int attitudesCount;       //表态数
@property (nonatomic, copy) NSString* source;           //来源

- (id)initWithDict:(NSDictionary *)dict;

@end
