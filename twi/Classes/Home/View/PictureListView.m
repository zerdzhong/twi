//
//  PictureListView.m
//  微博
//
//  Created by zerd on 14-10-27.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  配图 1- 9

#import "PictureListView.h"
#import "PictureListItem.h"

#define kPicCount 9

#define kOneWidth 120
#define kOneHeight 120

#define kMutilWidth 80
#define kMutilHeight 80

#define kMargin 10

@implementation PictureListView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //先把有可能显示的控件加到view上
        
        for (int i = 0; i < kPicCount; i++) {
            PictureListItem *image = [[PictureListItem alloc]init];
            [self addSubview:image];
        }
        
    }

    return self;
}

//set方法
- (void)setPicUrlArray:(NSArray *)picUrlArray{
    _picUrlArray = picUrlArray;

    for (int i = 0; i < kPicCount; i++) {
        //取出对应位置的ImageView
        PictureListItem *childView = [self subviews][i];
        //判断是否需要显示
        if (i < _picUrlArray.count) {
            childView.hidden = NO;
            //设置图片
            childView.url = _picUrlArray[i][@"thumbnail_pic"];
            //设置frame
            if (_picUrlArray.count == 1) {
                //只有一张
                childView.contentMode = UIViewContentModeScaleAspectFit;
                childView.frame = CGRectMake(0, 0, kOneWidth, kOneHeight);
            } else {
                //多张
                CGFloat x = (kMutilWidth + kMargin) * (i % 3);
                CGFloat y = (kMutilHeight + kMargin) * (i /3);
                childView.frame = CGRectMake(x, y, kMutilWidth, kMutilHeight);
                childView.clipsToBounds = YES;
                childView.contentMode = UIViewContentModeScaleAspectFill;
            }
            
            
        }else {
            childView.hidden = YES;
        }
    }
}

+ (CGSize)pictureListSize:(int)count{
    if (count == 1) {
        return CGSizeMake(kOneWidth, kOneHeight);
    }else{
        
        //列数
        int rowCount = (count >= 3)?3:2;
        //行数
        int lintCount = (count + 3 -1) / 3;
        
        CGFloat width = kMutilWidth * rowCount + kMargin * (rowCount - 1);
        CGFloat height = kMutilHeight * lintCount + kMargin * (lintCount - 1);
        return CGSizeMake(width, height);
    }
}

@end
