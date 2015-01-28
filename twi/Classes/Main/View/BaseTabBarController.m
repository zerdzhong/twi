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

@property (nonatomic, assign) BOOL tabBarHidden;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation BaseTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
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
    self.contentView = newViewController.view;
    [self.view addSubview:newViewController.view];
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    _tabBarHidden = hidden;
    
    __weak BaseTabBarController *weakSelf = self;
    
    void (^block)() = ^{
        CGSize viewSize = weakSelf.view.bounds.size;
        CGFloat tabBarStartingY = viewSize.height;
        CGFloat contentViewHeight = viewSize.height;
        CGFloat tabBarHeight = CGRectGetHeight([[weakSelf tabBar] frame]);
        if (!tabBarHeight) {
            tabBarHeight = 49;
        }
        
        if (!hidden) {
            tabBarStartingY = viewSize.height - tabBarHeight;
            contentViewHeight -= kTabBarHeight;
            [[weakSelf tabBar] setHidden:NO];
        }
        
        [[weakSelf tabBar] setFrame:CGRectMake(0, tabBarStartingY, viewSize.width, tabBarHeight)];
        [[weakSelf contentView] setFrame:CGRectMake(0, 0, viewSize.width, contentViewHeight)];
    };
    
    void (^completion)(BOOL) = ^(BOOL finished){
        if (hidden) {
            [[weakSelf tabBar] setHidden:YES];
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.10 animations:block completion:completion];
    } else {
        block();
        completion(YES);
    }
}

- (void)setTabBarHidden:(BOOL)hidden {
    [self setTabBarHidden:hidden animated:NO];
}

@end
