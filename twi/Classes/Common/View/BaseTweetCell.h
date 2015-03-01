//
//  StatusCell.h
//  微博
//
//  Created by zerd on 14-10-23.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCellFrame.h"

@interface BaseTweetCell : UITableViewCell

@property (nonatomic, copy) void(^tapBlock)(id objc);
@property (nonatomic, strong) TweetCellFrame *statusCellFrame;

@property (nonatomic, copy) void(^retweetBlock)(TweetModel *);
@property (nonatomic, copy) void(^commentBlock)(TweetModel *);
@property (nonatomic, copy) void(^upvoteBlock)(TweetModel *);


@end
