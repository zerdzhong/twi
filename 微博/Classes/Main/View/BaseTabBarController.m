//
//  BaseTabBarController.m
//  微博
//
//  Created by zerd on 14-10-18.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "BaseTabBarController.h"

#define kTabBarHeight 44

@interface BaseTabBarController () <TabBarDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad{
    //1.添加 tabbar
    self.tabBar = [[TabBar alloc]init];
    self.tabBar.delegate = self;
    self.tabBar.frame = CGRectMake(0, self.view.frame.size.height - kTabBarHeight, self.view.frame.size.width, kTabBarHeight);
    [self.view addSubview:self.tabBar];
}

#pragma mark- TabBar代理协议

- (void)TabBar:(TabBar *)tabBar itemSelectedFrom:(int)from to:(int)to{
    MyLog(@"from:%d to :%d",from,to);
    if (to < 0 || to >= self.childViewControllers.count) {
        return;
    }
    
    //1.移除旧控制器
    UIViewController *oldViewController = self.childViewControllers[from];
    [oldViewController.view removeFromSuperview];
    
    //1.取出即将显示的控制器
    UIViewController *newViewController = [self.childViewControllers objectAtIndex:to];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - kTabBarHeight;
    newViewController.view.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:newViewController.view];
}

@end
