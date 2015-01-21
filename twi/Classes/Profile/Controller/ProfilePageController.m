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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewTopConstraint;

@property (nonatomic, strong)UserModel *currentUser;

@property (nonatomic, copy) void(^scrollTopBlock)();
@property (nonatomic, copy) void(^scrollDownBlock)();

@end

@implementation ProfilePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _headView.currentUser = _currentUser;
    __unsafe_unretained ProfilePageController *weakSelf = self;
    
    [ProfileTool getProfileWithUid:[WeiboAccountTool sharedWeiboAccountTool].currentCount.uid
                           success:^(UserModel *user) {
                               weakSelf.currentUser = user;
                               weakSelf.headView.currentUser = _currentUser;
                           } failure:^(NSError *error) {
                               MyLog(@"failure:%@",error.description);
                           }];
    
    [self setupBlocks];
    [self addContainer];
}

- (void)setupBlocks{
    __unsafe_unretained ProfilePageController *weakSelf = self;
    self.scrollDownBlock = ^(){
        if (weakSelf.containerViewTopConstraint.constant == 0) {
            
            weakSelf.containerViewTopConstraint.constant = -weakSelf.headView.frame.size.height;
            [weakSelf.containerView setNeedsUpdateConstraints];
            
            // update constraints now so we can animate the change
            [weakSelf.containerView updateConstraintsIfNeeded];
            
            [UIView animateWithDuration:0.4 animations:^{
                [weakSelf.containerView layoutIfNeeded];
            }];
        }
    };
    
    self.scrollTopBlock = ^(){
        if (weakSelf.containerViewTopConstraint.constant != 0) {
            
            weakSelf.containerViewTopConstraint.constant = 0;
            [weakSelf.containerView setNeedsUpdateConstraints];
            
            // update constraints now so we can animate the change
            [weakSelf.containerView updateConstraintsIfNeeded];
            
            [UIView animateWithDuration:0.4 animations:^{
                [weakSelf.containerView layoutIfNeeded];
            }];
        }
    };
}

#pragma mark- 添加底部tabController
- (void)addContainer{
    UIStoryboard *profileStoryBoard = [UIStoryboard storyboardWithName:@"ProfileContent" bundle:nil];
    ProfileContentController *contentController = [profileStoryBoard instantiateViewControllerWithIdentifier:@"ProfileContent"];
    
    contentController.scrollDownBlock = self.scrollDownBlock;
    contentController.scrollTopBlock = self.scrollTopBlock;
    
    [contentController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addChildViewController:contentController];
    [self.containerView addSubview:contentController.view];
    
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:contentController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:contentController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:contentController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:contentController.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
}

@end
