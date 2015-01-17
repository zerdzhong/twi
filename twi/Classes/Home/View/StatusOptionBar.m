//
//  StatusOptionBar.m
//  微博
//
//  Created by zerd on 14-11-18.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "StatusOptionBar.h"
#import "UIImage+ZD.h"
#import "NSString+ZD.h"

@implementation StatusOptionBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self ) {
        
        //设备背景
//        [self setImage:[UIImage resizedImage:@"timeline_card_bottom.png"]];
//        [self setBackgroundColor:[UIColor whiteColor]];
        self.userInteractionEnabled = YES;
        
        //添加三个按钮
        [self addButton:@"转发" icon:@"timeline_icon_retweet.png" bg:@"timeline_card_leftbottom.png" index:0];
        [self addButton:@"评论" icon:@"timeline_icon_comment.png" bg:@"timeline_card_middlebottom.png" index:1];
        [self addButton:@"赞" icon:@"timeline_icon_unlike.png" bg:@"timeline_card_rightbottom.png" index:2];
    }
    
    return self;
}

- (void)addButton:(NSString *)title icon:(NSString *)icon bg:(NSString *)bg index:(int)index{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kColor(188, 188, 188) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage resizedImage:bg] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage resizedImage:[bg fileAppend:@"_highlighted"]] forState:UIControlStateHighlighted];
    CGFloat width = self.frame.size.width / 3;
    btn.frame = CGRectMake(index * width, 0, width, kOptionBarHeight);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:btn];
    
    if (index != 0) {
        //添加分割线
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line.png"]];
        imageView.center = CGPointMake(btn.frame.origin.x, kOptionBarHeight * 0.5);
        [self addSubview:imageView];
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 2*kTableBorderWidth;
    frame.size.height = kOptionBarHeight;
    [super setFrame:frame];
}

@end
