//
//  PictureListView.m
//  微博
//
//  Created by zerd on 14-10-27.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  配图 1- 9

#import "PictureListView.h"
#import "PictureListItem.h"
#import "MJPhotoBrowser.h"

#define kPicCount 9

#define kOneWidth 120
#define kOneHeight 120

#define kMutilWidth 80
#define kMutilHeight 80

#define kMargin 10

@interface PictureListView ()

@property (nonatomic, strong) NSMutableArray *largePictures;
@property (nonatomic, strong) NSMutableArray *photos;

@end

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
    _largePictures = [NSMutableArray array];
    for (int i = 0; i < kPicCount; i++) {
        //取出对应位置的ImageView
        PictureListItem *childView = [self subviews][i];
        //判断是否需要显示
        if (i < _picUrlArray.count) {
            childView.hidden = NO;
            //设置图片
            childView.url = _picUrlArray[i][@"thumbnail_pic"];
            //设置大图URL
            NSMutableString *thumbUrl = [[NSMutableString alloc]initWithString:childView.url];
            NSRange range = [thumbUrl rangeOfString:@"thumbnail"];
            if (range.length != 0) {
                [thumbUrl replaceCharactersInRange:range withString:@"large"];
                [_largePictures addObject:thumbUrl];
            }
            //设置点击时间
            __unsafe_unretained PictureListView *weakself = self;
            __unsafe_unretained PictureListItem *weakPicture = childView;
            [childView addTapBlock:^(PictureListItem *pic) {
                [weakself browsePicturesIndex:i srcImageView:weakPicture];
            }];
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

- (void)browsePicturesIndex:(int)index srcImageView:(UIImageView *)imageView{
    //        显示大图
    int count = (int)_largePictures.count;
    _photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:[_largePictures objectAtIndex:i]]; // 图片路径
        photo.srcImageView = imageView; // 来源于哪个UIImageView
        [_photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index; // 弹出相册时显示的第一张图片是？
    browser.photos = _photos; // 设置所有的图片
    [browser show];
}

@end
