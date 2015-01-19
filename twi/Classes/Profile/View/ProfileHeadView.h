//
//  ProfileHeaderView.h
//  twi_iOS
//
//  Created by zerd on 15-1-19.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface ProfileHeadView : UIView

@property (nonatomic, strong) UserModel *currentUser;

+ (instancetype)ProfileHeadView;

@end
