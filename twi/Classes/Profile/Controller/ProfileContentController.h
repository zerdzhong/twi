//
//  ProfileContentControllerViewController.h
//  twi_iOS
//
//  Created by zerd on 15-1-20.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "XLButtonBarPagerTabStripViewController.h"

@interface ProfileContentController : XLButtonBarPagerTabStripViewController

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) void(^scrollTopBlock)();
@property (nonatomic, copy) void(^scrollDownBlock)();

@end
