//
//  HomeController.h
//  微博
//
//  Created by zerd on 14-10-17.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTweetTableController.h"

@interface HomeController : BaseTweetTableController

@property (nonatomic, copy) void(^showTabBarBlock)();
@property (nonatomic, copy) void(^hideTabBarBlock)();

@end
