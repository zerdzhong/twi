//
//  ProfilePageController.h
//  twi_iOS
//
//  Created by zerd on 15-1-19.
//  Copyright (c) 2015年 zerd. All rights reserved.
//  用户信息页

#import <UIKit/UIKit.h>

@class UserModel;

@interface ProfilePageController : UIViewController

@property (nonatomic, strong)UserModel *currentUser;

@end
