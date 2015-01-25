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

@property (nonatomic, strong) ProfileTweetController *child1;
@property (nonatomic, strong) ProfileUserController *child2;
@property (nonatomic, strong) ProfileUserController *child3;

@end

@implementation ProfileContentController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _child1 = [[ProfileTweetController alloc]init];
        _child2 = [[ProfileUserController alloc]init];
        _child3 = [[ProfileUserController alloc]init];
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

- (void)setUid:(NSString *)uid{
    _uid = uid;
    _child1.uid = _uid;
    _child2.uid = _uid;
    _child3.uid = _uid;
}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    
    _child1.title = @"微博";
    _child1.scrollTopBlock = self.scrollTopBlock;
    _child1.scrollDownBlock = self.scrollDownBlock;
    
    _child2.title = @"关注";
    _child2.type = kFriend;
    _child2.scrollTopBlock = self.scrollTopBlock;
    _child2.scrollDownBlock = self.scrollDownBlock;
    
    _child3.type = kFollower;
    _child3.scrollDownBlock = self.scrollDownBlock;
    _child3.scrollTopBlock = self.scrollTopBlock;
    _child3.title = @"粉丝";

    return @[_child1,_child2,_child3];
    
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
