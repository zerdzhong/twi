//
//  StatusCellFrame.h
//  微博
//
//  Created by zerd on 14-10-23.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  描述一个StatusCell所有子控件的frame

#import <Foundation/Foundation.h>
#import "StatusModel.h"

@interface StatusCellFrame : NSObject

@property (nonatomic, strong) StatusModel *status;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, assign, readonly) CGRect profileImageFrame;       //头像
@property (nonatomic, assign, readonly) CGRect screenNameFrame;         //昵称
@property (nonatomic, assign, readonly) CGRect memberImageFrame;        //会员头像
@property (nonatomic, assign, readonly) CGRect timeFrame;               //时间
@property (nonatomic, assign, readonly) CGRect sourceFrame;             //来源
@property (nonatomic, assign, readonly) CGRect textFrame;               //内容
@property (nonatomic, assign, readonly) CGRect pictureFrame;            //配图

@property (nonatomic, assign, readonly) CGRect retweetedViewFrame;          //转发微博的父控件
@property (nonatomic, assign, readonly) CGRect retweetedScreenNameFrame;    //转发微博的作者昵称
@property (nonatomic, assign, readonly) CGRect retweetedTextFrame;          //转发微博的内容
@property (nonatomic, assign, readonly) CGRect retweetedPictureFrame;       //转发微博的配图

@end
