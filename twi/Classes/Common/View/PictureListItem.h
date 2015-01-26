//
//  PictureListItem.h
//  微博
//
//  Created by zerd on 14-11-11.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(id obj);

@interface PictureListItem : UIImageView

@property (nonatomic, copy) NSString *url;

- (void)addTapBlock:(TapBlock)tapBlcok;

@end
