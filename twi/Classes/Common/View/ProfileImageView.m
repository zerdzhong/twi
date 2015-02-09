//
//  ProfileImageView.m
//  微博
//
//  Created by zerd on 14-10-25.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "ProfileImageView.h"
#import "HttpTool.h"

@interface ProfileImageView ()

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIImageView *vertifyImageView;
@property (nonatomic, strong) NSString *placeholder;

@end

@implementation ProfileImageView

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

-(void)awakeFromNib{
    //用户头像
    _profileImageView = [[UIImageView alloc]init];
    [self addSubview:_profileImageView];
    //认证图标
    _vertifyImageView = [[UIImageView alloc]init];
    [self addSubview:_vertifyImageView];
}

#pragma mark- 设置 tap block

- (void)setTapBlock:(void (^)(id objc))tapBlock{
    _tapBlock = tapBlock;
    if (![_profileImageView gestureRecognizers]) {
        _profileImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_profileImageView addGestureRecognizer:tap];
    }
}

- (void)tap{
    if (self.tapBlock) {
        self.tapBlock(self);
    }
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
    [HttpTool loadImageView:_profileImageView withUrl:[NSURL URLWithString:_user.profileImageURL] place:[UIImage imageNamed:_placeholder] completed:^(UIImage *image, NSError *error) {
        _profileImageView.image = [self getEllipseImageWithImage:image];
    }];
    
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

#pragma mark- test

-(UIImage *)getEllipseImageWithImage:( UIImage *)originImage
{
    
    UIColor * epsBackColor = [UIColor lightGrayColor]; // 边框的背景色
    
    int boundPadding = 1;
    int padding = boundPadding + 1;
    
    CGSize originsize = originImage.size ;
    
    CGRect originRect = CGRectMake( 0 , 0 , originsize. width , originsize. height );
    
    UIGraphicsBeginImageContext (originsize);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext ();
    
    // 目标区域。
    CGRect desRect =  CGRectMake (padding, padding,originsize. width - (2 * padding) , originsize. height - (2 * padding));
    CGRect boundRect =  CGRectMake (boundPadding, boundPadding,originsize. width - (2 * boundPadding) , originsize. height - (2 * boundPadding));
    
    
    // 设置填充背景色。
    
    CGContextAddEllipseInRect (ctx,boundRect);
    
    CGContextClip (ctx); // 截取椭圆区域。
    
    CGContextSetFillColorWithColor (ctx, epsBackColor. CGColor );
    
    UIRectFill (boundRect); // 真正的填充
    
    // 设置椭圆变形区域。
    
    CGContextAddEllipseInRect (ctx,desRect);
    
    CGContextClip (ctx); // 截取椭圆区域。
    
    [originImage drawInRect :originRect]; // 将图像画在目标区域。
    
    UIImage * desImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    //    UIGraphicsPushContext(ctx);
    
    return desImage;
    
}

@end
