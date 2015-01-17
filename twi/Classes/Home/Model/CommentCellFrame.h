//
//  CommentCellFrame.h
//  twi_iOS
//
//  Created by zerd on 15-1-17.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@interface CommentCellFrame : NSObject

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, assign, readonly) CGRect profileImageFrame;       //头像
@property (nonatomic, assign, readonly) CGRect screenNameFrame;         //昵称
@property (nonatomic, assign, readonly) CGRect textFrame;               //内容

@property (nonatomic, strong) CommentModel *comment;

@end
