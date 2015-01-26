//
//  PictureListView.h
//  微博
//
//  Created by zerd on 14-10-27.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  配图 1-9

#import <UIKit/UIKit.h>

@interface PictureListView : UIView

//配图的数组
@property (nonatomic, strong) NSArray *picUrlArray;

+ (CGSize)pictureListSize:(int)count;


@end
