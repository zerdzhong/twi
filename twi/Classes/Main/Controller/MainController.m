//
//  HomeController.m
//  微博
//
//  Created by zerd on 14-10-13.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  

#import "MainController.h"
#import "TabBar.h"
#import "HomeController.h"
#import "MoreController.h"
#import "ProfilePageController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化所有自控制器
    [self addAllChildController];
    //添加 tabbar
    [self addTabBar];
}

#pragma mark- 初始化子控制器
- (void)addAllChildController{
    //1首页
    HomeController *homeVC = [[HomeController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:homeVC];
    [self addChildViewController:nav1];
    //2消息
    UIViewController *messageVC = [[UIViewController alloc]init];
    messageVC.view.backgroundColor = [UIColor yellowColor];
    messageVC.title = @"消息";
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:messageVC];
    [self addChildViewController:nav2];
    //3我
    ProfilePageController *meVC = [[ProfilePageController alloc]init];
//    meVC.view.backgroundColor = [UIColor whiteColor];
    meVC.title = @"我";
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:meVC];
    [self addChildViewController:nav3];
    //4广场
    UIViewController *squareVC = [[UIViewController alloc]init];
    squareVC.view.backgroundColor = [UIColor greenColor];
    squareVC.title = @"广场";
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:squareVC];
    [self addChildViewController:nav4];
    //5更多
    MoreController *moreVC = [[MoreController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:moreVC];
    [self addChildViewController:nav5];
}

#pragma mark- 初始化 TabBar
- (void)addTabBar{
    
    
    //2.往 tabbar 中添加内容
    [self.tabBar addItemWithIcon:@"tabbar_home.png" selectedIcon:@"tabbar_home_selected.png" title:@"首页"];
    [self.tabBar addItemWithIcon:@"tabbar_message_center.png" selectedIcon:@"tabbar_message_center_selected.png" title:@"消息"];
    [self.tabBar addItemWithIcon:@"tabbar_profile.png" selectedIcon:@"tabbar_profile_selected.png" title:@"我"];
    [self.tabBar addItemWithIcon:@"tabbar_discover.png" selectedIcon:@"tabbar_discover_selected.png" title:@"广场"];
    [self.tabBar addItemWithIcon:@"tabbar_more.png" selectedIcon:@"tabbar_more_selcted.png" title:@"更多"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
