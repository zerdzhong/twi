//
//  NewFeatureController.m
//  微博
//
//  Created by zerd on 14-10-13.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "NewFeatureController.h"
#import "OauthController.h"
#import "UIImage+ZD.h"

#define kCount 4

@interface NewFeatureController ()

@end

@implementation NewFeatureController

#pragma mark- 自定义 view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加 scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    CGSize size = scrollView.frame.size;
    scrollView.contentSize = CGSizeMake(kCount * size.width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO; //隐藏水平滚动条
    [self.view addSubview:scrollView];
    
    //添加图片
    for (int i = 0; i < kCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        //显示图片
        NSString *imageName = [NSString stringWithFormat:@"new_features_%d.jpg",i];
        imageView.image = [UIImage fullScreenImage:imageName];
        //设置 frame
        imageView.frame = CGRectMake(i*size.width, 0, size.width, size.height);
        
        [scrollView addSubview:imageView];
        
        if (i == kCount - 1) {
            //立即体验按钮（进入主页）
            UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *startNormal = [UIImage imageNamed:@"new_feature_finish_button.png"];
            [startBtn setBackgroundImage:startNormal forState:UIControlStateNormal];
            
            [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted.png"] forState:UIControlStateHighlighted];
            startBtn.center = CGPointMake(size.width * 0.5, size.height * 0.8);
            startBtn.bounds = (CGRect){CGPointZero,startNormal.size};
            [startBtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:startBtn];
            
            //分享按钮
            UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //普通状态显示的图片
            UIImage *shareNormal = [UIImage imageNamed:@"new_feature_share_false.png"];
            [shareBtn setBackgroundImage:shareNormal forState:UIControlStateNormal];
            
            //选中状态显示的图片
            [shareBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];
            //默认选中状态
            shareBtn.selected = YES;
            shareBtn.adjustsImageWhenHighlighted = NO;
            shareBtn.center = CGPointMake(startBtn.center.x, startBtn.center.y - 50);
            shareBtn.bounds = (CGRect){CGPointZero,shareNormal.size};
            [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:shareBtn];
            
            imageView.userInteractionEnabled = YES;
        }
        
    }
    
    
}

#pragma mark- 按钮监听
#pragma mark- 开始按钮
- (void)start:(UIButton *) button{
    MyLog(@"开始微博");
    //设置 window 的 rootViewController 为主页，
    [UIApplication sharedApplication].statusBarHidden = NO;
    //跳转到获取授权页面
    self.view.window.rootViewController = [[OauthController alloc]init];
}
#pragma mark- 分享按钮
- (void)share:(UIButton *) button{
    [button setSelected:!button.selected];
}

- (void)dealloc{
//    MyLog(@"销毁 New Feature");
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
