//
//  ProfileHeaderView.m
//  twi_iOS
//
//  Created by zerd on 15-1-19.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "ProfileHeadView.h"
#import "HttpTool.h"

@interface ProfileHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenName;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@end

@implementation ProfileHeadView

+ (instancetype)ProfileHeadView{
    return [[NSBundle mainBundle]loadNibNamed:@"ProfileHeadView" owner:nil options:nil][0];
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        UIView *containerView = [[NSBundle mainBundle]loadNibNamed:@"ProfileHeadView" owner:self options:nil][0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

- (void)setCurrentUser:(UserModel *)currentUser{
    _currentUser = currentUser;
    
    [HttpTool loadImageView:_profileImageView withUrl:[NSURL URLWithString:_currentUser.profileImageURL] place:nil completed:^(UIImage *image, NSError *error) {
        _profileImageView.image = [self getEllipseImageWithImage:image];
    }];
    
    [HttpTool loadImageView:_backgroundImageView withUrl:[NSURL URLWithString:_currentUser.coverImageURL] place:nil];
    _screenName.text = _currentUser.screenName;
}

#pragma mark- 过会放到category里去
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
