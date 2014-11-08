//
//  TabBarItem.m
//  微博
//
//  Created by zerd on 14-10-16.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "TabBarItem.h"

#define kTitleRatio 0.3
#define kImageWidth 30
#define kImageHeight 30
#define kTextNormalColor [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]
#define kTextSelectedColor [UIColor colorWithRed:255/255.0 green:128/255.0 blue:45/255.0 alpha:1.0]

@implementation TabBarItem

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //title文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //title 文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        //title 文字颜色
        [self setTitleColor:kTextNormalColor forState:UIControlStateNormal];
        [self setTitleColor:kTextSelectedColor  forState:UIControlStateSelected];
        //imageview 图片模式
        self.imageView.contentMode = UIViewContentModeCenter;
        //item 背景
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider.png"] forState:UIControlStateSelected];
    }
    
    return self;
}

#pragma mark- 覆盖父类在 Highlighted 的所有操作
- (void)setHighlighted:(BOOL)highlighted{}

#pragma mark- 调整内部 imageView 位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = (contentRect.size.width - kImageWidth)/2 ;
    CGFloat imageY = 0;
    CGFloat imageWidth = kImageWidth;
    CGFloat imageHeight = kImageHeight;
    
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark- 调整内部 label 位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = kImageHeight;
    CGFloat titleHeight = contentRect.size.height - kImageHeight;
    CGFloat titleWidth = contentRect.size.width;
    
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end
