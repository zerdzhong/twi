//
//  StatusOptionBar.h
//  微博
//
//  Created by zerd on 14-11-18.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  微博底部操作条

#import <UIKit/UIKit.h>
#import "TweetModel.h"

@interface StatusOptionBar : UIImageView

@property (nonatomic, strong) TweetModel *tweet;

@property (nonatomic, copy) void(^retweetBlock)();
@property (nonatomic, copy) void(^commentBlock)();
@property (nonatomic, copy) void(^upvoteBlock)();

@end
