//
//  ProfileContentControllerViewController.m
//  twi_iOS
//
//  Created by zerd on 15-1-20.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "ProfileContentController.h"
#import "ProfileUserController.h"
#import "ProfileTweetController.h"

@interface ProfileContentController ()

@end

@implementation ProfileContentController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.buttonBarView.selectedBar setBackgroundColor:[UIColor orangeColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 2/statuses/user_timeline.json 获取用户微博

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    
    ProfileTweetController *child1 = [[ProfileTweetController alloc]init];
    child1.title = @"微博";
    child1.scrollTopBlock = self.scrollTopBlock;
    child1.scrollDownBlock = self.scrollDownBlock;

    ProfileUserController *child2 = [[ProfileUserController alloc]init];
    child2.title = @"关注";
    child2.type = kFriend;
    child2.scrollTopBlock = self.scrollTopBlock;
    child2.scrollDownBlock = self.scrollDownBlock;
    
    
    ProfileUserController *child3 = [[ProfileUserController alloc]init];
    child3.type = kFollower;
    child3.scrollDownBlock = self.scrollDownBlock;
    child3.scrollTopBlock = self.scrollTopBlock;
    child3.title = @"粉丝";

    return @[child1,child2,child3];
    
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
