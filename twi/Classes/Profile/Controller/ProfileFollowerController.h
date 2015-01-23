//
//  ProfileChildTableController.h
//  twi_iOS
//
//  Created by zerd on 15-1-20.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUserTableController.h"
#import "XLPagerTabStripViewController.h"

@interface ProfileFollowerController : BaseUserTableController <XLPagerTabStripChildItem>

@property (nonatomic, copy) void(^scrollTopBlock)();
@property (nonatomic, copy) void(^scrollDownBlock)();

@end
