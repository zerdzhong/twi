//
//  ProfileImageView.h
//  微博
//
//  Created by zerd on 14-10-25.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  用户头像

#import <UIKit/UIKit.h>
#import "UserModel.h"

#define kProfileSmallWidth 34
#define kProfileSmallHeight 34

#define kProfileDefaultWidth 50
#define kProfileDefaultHeight 50

#define kProfileBigWidth 85
#define kProfileBigHeight 85

#define kVertifyWidth 18
#define kVertifyHeight 18

typedef enum{
    kProfileTypeSmall,
    kProfileTypeDefault,
    kProfileTypeBig
} ProfileType;

@interface ProfileImageView : UIView

@property (nonatomic, strong, readonly) UserModel *user;
@property (nonatomic, assign, readonly) ProfileType profileType;

- (void)setUser:(UserModel *)user type:(ProfileType)type;

@end
