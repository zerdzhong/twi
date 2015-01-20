//
//  ProfileContentControllerViewController.m
//  twi_iOS
//
//  Created by zerd on 15-1-20.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "ProfileContentController.h"
#import "ProfileChildTableController.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    ProfileChildTableController *child1 = [[ProfileChildTableController alloc]init];
    child1.title = @"child1";
    ProfileChildTableController *child2 = [[ProfileChildTableController alloc]init];
    child2.title = @"child2";
    ProfileChildTableController *child3 = [[ProfileChildTableController alloc]init];
    child3.title = @"child3";
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
