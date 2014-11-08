//
//  ProfileImageView.m
//  微博
//
//  Created by zerd on 14-10-25.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "ProfileView.h"
#import "UIImageView+WebCache.h"

@interface ProfileView ()

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIImageView *vertifyImageView;
@property (nonatomic, strong) NSString *placeholder;

@end

@implementation ProfileView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //用户头像
        _profileImageView = [[UIImageView alloc]init];
        [self addSubview:_profileImageView];
        //认证图标
        _vertifyImageView = [[UIImageView alloc]init];
        [self addSubview:_vertifyImageView];
    }
    
    return self;
}

#pragma mark- 同时设置用户和类型

- (void)setUser:(UserModel *)user type:(ProfileType)type{
    [self setProfileType:type];
    [self setUser:user];
}

#pragma mark- 设置用户模型
//用户的set方法
- (void)setUser:(UserModel *)user{
    _user = user;
    
    //设置用户头像
    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:_user.profileImageURL] placeholderImage:[UIImage imageNamed:_placeholder] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    //设置认证图标
    UIImage *vertifyImage = nil ;
    switch (_user.verifiedType) {
        case kVerifiedTypeNone:     //没有认证
            break;
        case kVerifiedTypeDaren:    //微博达人
            vertifyImage = [UIImage imageNamed:@"avatar_grassroot.png"];
            break;
        case kVerifiedTypePersonal: //个人认证
            vertifyImage = [UIImage imageNamed:@"avatar_vip.png"];
            break;
        default:    //企业认证
            vertifyImage = [UIImage imageNamed:@"avatar_enterprise_vip.png"];
            break;
    }
    
    if (_user.verified && vertifyImage != nil) {
        _vertifyImageView.hidden = NO;
        _vertifyImageView.image = vertifyImage;
    }else {
        _vertifyImageView.hidden = YES;
    }
    
}

#pragma mark- 设置图标的类型
- (void)setProfileType:(ProfileType)profileType{
    _profileType = profileType;
    
    CGSize profileSize;
    
    //判断类型
    switch (profileType) {
        case kProfileTypeSmall: //小图标
            profileSize = CGSizeMake(kProfileSmallWidth, kProfileSmallHeight);
            _placeholder = @"avatar_default_small.png";
            break;
        case kProfileTypeDefault:
            profileSize = CGSizeMake(kProfileDefaultWidth, kProfileDefaultHeight);
            _placeholder = @"avatar_default.png";
            break;
        case kProfileTypeBig:
            profileSize = CGSizeMake(kProfileBigWidth, kProfileBigHeight);
            _placeholder = @"avatar_default_big.png";
            break;
        default:
            break;
    }
    
    //设置frame
    _profileImageView.frame = (CGRect){{0,0},profileSize};
    _vertifyImageView.bounds = CGRectMake(0, 0, kVertifyWidth, kVertifyHeight);
    _vertifyImageView.center = CGPointMake(profileSize.width, profileSize.height);
    
    //设置整个view的大小 宽高为头像的宽高加上认证图标宽高的一半
    
    CGFloat width = profileSize.width + 0.5 * kVertifyWidth;
    CGFloat height = profileSize.height + 0.5 * kVertifyHeight;
    
    self.bounds = CGRectMake(0, 0, width, height);
    
}

#pragma mark- 重写父类方法
- (void)setFrame:(CGRect)frame{
    frame.size =  self.bounds.size;
    
    [super setFrame:frame];
}

@end
