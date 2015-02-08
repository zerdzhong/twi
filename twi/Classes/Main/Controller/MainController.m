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
#import "SquareController.h"
#import "NewTweetController.h"

@interface MainController (){
    NSString *mString;
}

@property (nonatomic, strong) UIView *composeView;
@property (nonatomic, copy) void(^showTabBarBlock)();
@property (nonatomic, copy) void(^hideTabBarBlock)();

@end

@implementation MainController

__weak id reference = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __unsafe_unretained MainController *weakSelf = self;
    self.showTabBarBlock = ^(){
        [weakSelf setTabBarHidden:NO animated:YES];
    };
    
    self.hideTabBarBlock = ^(){
        [weakSelf setTabBarHidden:YES animated:YES];
    };
    
    //初始化所有自控制器
    [self addAllChildController];
    //添加 tabbar
    [self addTabBar];
    
}


#pragma mark- 初始化子控制器
- (void)addAllChildController{
    //1首页
    HomeController *homeVC = [[HomeController alloc]init];
    homeVC.showTabBarBlock = _showTabBarBlock;
    homeVC.hideTabBarBlock = _hideTabBarBlock;
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:homeVC];
    [self addChildViewController:nav1];
    //2消息
    UIViewController *messageVC = [[UIViewController alloc]init];
    messageVC.view.backgroundColor = [UIColor yellowColor];
    messageVC.title = @"消息";
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:messageVC];
    [self addChildViewController:nav2];
    
    UIViewController *composeVC = [[UIViewController alloc]init];
    composeVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:composeVC];
    
    //4广场
    SquareController *squareVC = [[SquareController alloc]init];
    squareVC.view.backgroundColor = [UIColor greenColor];
    squareVC.title = @"发现";
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:squareVC];
    [self addChildViewController:nav4];
    
    //3我
    ProfilePageController *meVC = [[ProfilePageController alloc]init];
    //    meVC.view.backgroundColor = [UIColor whiteColor];
    meVC.title = @"我";
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:meVC];
    [self addChildViewController:nav3];
    
    //5更多
    MoreController *moreVC = [[MoreController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:moreVC];
    [self addChildViewController:nav5];
}

- (void)addComposeView{
    self.composeView = [UIView new];
    self.composeView.backgroundColor = [UIColor whiteColor];
    self.composeView.alpha = 0.97;
    [self.composeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.composeView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.composeView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.composeView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.composeView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.composeView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close@2x.png"] forState:UIControlStateNormal];
    [close setTranslatesAutoresizingMaskIntoConstraints:NO];
    [close addTarget:self action:@selector(closeCompose) forControlEvents:UIControlEventTouchUpInside];
    [self.composeView addSubview:close];
    
    [self.composeView addConstraint:[NSLayoutConstraint constraintWithItem:close attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.composeView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.composeView addConstraint:[NSLayoutConstraint constraintWithItem:close attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.composeView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20]];
}

- (void) showCompose{
    
    //添加compose蒙层
    [self addComposeView];
//    self.composeView.hidden = NO;
    
    int count = 6;
    int numsProcolumn = 3;
    CGFloat viewWH = 80;
    for (int i = 0; i < count; i ++) {
        
        int posY = 150;
        int row = i / numsProcolumn;
        int col = i % numsProcolumn;
        CGFloat margin = (self.view.frame.size.width - viewWH*numsProcolumn)/(numsProcolumn+1);
        UIImageView *image = [[UIImageView alloc]init];
        image.tag = i;
        image.userInteractionEnabled = YES;
        [image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onComposeClicked:)]];
        
        image.image = [UIImage imageNamed:[ NSString stringWithFormat:@"tabbar_compose_%d",i ]];
        image.backgroundColor = [UIColor clearColor];
        image.bounds = CGRectMake(0, 0, 50, 50);
        image.center = CGPointMake( col * 70, row *70);
        image.frame = CGRectMake(margin + (margin+viewWH)*col, posY+(margin+viewWH)*row, viewWH, viewWH);
        [self.composeView addSubview:image];
        
        //设置初始y方向偏移
        CGAffineTransform trans = CGAffineTransformTranslate  (image.transform,  0, (400 + row *viewWH));
        image.transform = trans;
        
        //每列delay相同
        int colum = i % numsProcolumn;
        
        //清空偏移量的动画
        [UIView animateWithDuration:0.25 delay:colum/10.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            //清空偏移量
            image.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //抖动动画
            CAKeyframeAnimation *shakeAnim = [CAKeyframeAnimation animation];
            shakeAnim.keyPath = @"transform.translation.y";
            shakeAnim.duration = 0.15;
            CGFloat delta = 5;
            shakeAnim.values = @[@0, @(-delta), @(delta), @0];
//            shakeAnim.values = @[@(delta), @0];
            shakeAnim.repeatCount = 1;
            [image.layer addAnimation:shakeAnim forKey:nil];
            
        }];
    }

}

- (void)closeCompose{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.composeView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.composeView removeFromSuperview];
        //    _composeView.hidden = YES;
        
        //移除控件
        for ( UIView *view in self.composeView.subviews) {
            if ([view isKindOfClass:[UIImageView class]])  {
                [view removeFromSuperview];
            }
        }
    }];

}

- (void)onComposeClicked:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 0:{
            NewTweetController *newTweetVC = [[NewTweetController alloc]init];
            newTweetVC.closeBlock = ^(){
                [self dismissViewControllerAnimated:YES completion:nil];
                [self closeCompose];
            };
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:newTweetVC];
            [self presentViewController:nav animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}


#pragma mark- 初始化 TabBar
- (void)addTabBar{
    
    
    //2.往 tabbar 中添加内容
    [self.tabBar addItemWithIcon:@"tabbar_home.png" selectedIcon:@"tabbar_home_selected.png" title:@"首页"];
    [self.tabBar addItemWithIcon:@"tabbar_message_center.png" selectedIcon:@"tabbar_message_center_selected.png" title:@"消息"];
   
    __unsafe_unretained MainController *weakSelf = self;
    [self.tabBar addComposeItemWithIcon:@"tabbar_compose_icon_add.png" tapBlock:^(id objc) {
        MyLog(@"clicked");
        [weakSelf showCompose];
    }];
    [self.tabBar addItemWithIcon:@"tabbar_discover.png" selectedIcon:@"tabbar_discover_selected.png" title:@"发现"];
    [self.tabBar addItemWithIcon:@"tabbar_profile.png" selectedIcon:@"tabbar_profile_selected.png" title:@"我"];
//    [self.tabBar addItemWithIcon:@"tabbar_more.png" selectedIcon:@"tabbar_more_selcted.png" title:@"更多"];
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
