//
//  TabBar.h
//  微博
//
//  Created by zerd on 14-10-16.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  底部的 TabBar 选项条

#import <UIKit/UIKit.h>

@class TabBar;

@protocol TabBarDelegate <NSObject>

@optional
- (void)TabBar:(TabBar *)tabBar itemSelectedFrom:(int)from to:(int)to;

@end

@interface TabBar : UIImageView

@property (nonatomic,weak)id<TabBarDelegate> delegate;

//添加一个选项卡
- (void)addItemWithIcon:(NSString *)imageName selectedIcon:(NSString *)selectedName title:(NSString *)title;

//添加发微博按钮
- (void)addComposeItemWithIcon:(NSString *)imageName tapBlock:(void(^)(id objc))tapBlock;

@end
