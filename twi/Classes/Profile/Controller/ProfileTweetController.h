//
//  ProfileTweetController.h
//  twi_iOS
//
//  Created by zerd on 15-1-23.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "BaseTweetTableController.h"
#import "XLPagerTabStripViewController.h"

@interface ProfileTweetController : BaseTweetTableController <XLPagerTabStripChildItem>

@property (nonatomic, copy) void(^scrollTopBlock)();
@property (nonatomic, copy) void(^scrollDownBlock)();

@property (nonatomic, copy) NSString *uid;

@end
