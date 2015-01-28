//
//  BaseTabBarController.h
//  微博
//
//  Created by zerd on 14-10-18.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBar.h"

@interface BaseTabBarController : UIViewController

@property (nonatomic,strong)TabBar *tabBar;

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
