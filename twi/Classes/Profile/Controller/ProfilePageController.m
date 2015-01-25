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
#import "MBProgressHUD.h"

@interface ProfilePageController ()

@property (weak, nonatomic) IBOutlet ProfileHeadView *headView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewTopConstraint;

@property (nonatomic, strong) ProfileContentController *contentController;
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) void(^scrollTopBlock)();
@property (nonatomic, copy) void(^scrollDownBlock)();

@end

@implementation ProfilePageController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIStoryboard *profileStoryBoard = [UIStoryboard storyboardWithName:@"ProfileContent" bundle:nil];
        _contentController = [profileStoryBoard instantiateViewControllerWithIdentifier:@"ProfileContent"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_currentUser != nil) {
        _headView.currentUser = _currentUser;
        self.uid = [NSString stringWithFormat:@"%lld", _currentUser.ID];
    }else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __unsafe_unretained ProfilePageController *weakSelf = self;
        
        [ProfileTool getProfileWithUid:[WeiboAccountTool sharedWeiboAccountTool].currentCount.uid
                               success:^(UserModel *user) {
                                   weakSelf.currentUser = user;
                                   weakSelf.headView.currentUser = user;
                                   weakSelf.uid = [NSString stringWithFormat:@"%lld", user.ID];
                                   [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                               } failure:^(NSError *error) {
                                   MyLog(@"failure:%@",error.description);
                                   [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                               }];
    }
    
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

- (void)setUid:(NSString *)uid{
    _uid = uid;
    _contentController.uid = _uid;
}

#pragma mark- 添加底部tabController
- (void)addContainer{

    _contentController.scrollDownBlock = self.scrollDownBlock;
    _contentController.scrollTopBlock = self.scrollTopBlock;
    
    [_contentController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addChildViewController:_contentController];
    [self.containerView addSubview:_contentController.view];
    
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:_contentController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:_contentController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:_contentController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:_contentController.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
}

@end
