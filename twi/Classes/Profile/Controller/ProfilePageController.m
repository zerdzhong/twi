//
//  ProfilePageController.m
//  twi_iOS
//
//  Created by zerd on 15-1-19.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "ProfilePageController.h"
#import "ProfileTool.h"
#import "WeiboAccountTool.h"
#import "MJRefresh.h"
#import "ProfileHeadView.h"
#import "ProfileContentController.h"

@interface ProfilePageController ()

@property (weak, nonatomic) IBOutlet ProfileHeadView *headView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong)UserModel *currentUser;

@end

@implementation ProfilePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __unsafe_unretained ProfilePageController *weakSelf = self;
    
    [ProfileTool getProfileWithUid:[WeiboAccountTool sharedWeiboAccountTool].currentCount.uid
                           success:^(UserModel *user) {
                               weakSelf.currentUser = user;
                               weakSelf.headView.currentUser = _currentUser;
                           } failure:^(NSError *error) {
                               MyLog(@"failure:%@",error.description);
                           }];
    
    UIStoryboard *profileStoryBoard = [UIStoryboard storyboardWithName:@"ProfileContent" bundle:nil];
    ProfileContentController *contentController = [profileStoryBoard instantiateViewControllerWithIdentifier:@"ProfileContent"];
    [contentController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addChildViewController:contentController];
    [self.containerView addSubview:contentController.view];
    
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:contentController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:contentController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:contentController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:contentController.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
}

- (void)awakeFromNib{
    _headView.currentUser = _currentUser;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
