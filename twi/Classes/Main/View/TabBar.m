//
//  TabBar.m
//  微博
//
//  Created by zerd on 14-10-16.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  底部选项条

#import "TabBar.h"
#import "TabBarItem.h"

#define kTabBackground @"tabbar_background.png"

@interface TabBar ()

@property(nonatomic,strong) TabBarItem *selectedItem;

@end

@implementation TabBar

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kTabBackground]];
        self.image = [UIImage imageNamed:kTabBackground];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

#pragma mark- 添加一个选项卡
- (void)addItemWithIcon:(NSString *)imageName selectedIcon:(NSString *)selectedName title:(NSString *)title{
    
    //创建 item
    TabBarItem *item = [[TabBarItem alloc]init];
    [item setTitle:title forState:UIControlStateNormal];        //文字
    [item setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];   //图标
    [item setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
    
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    //添加 item
    [self addSubview:item];
    
    if (self.subviews.count == 1) {
        //选中首页
        [self itemClick:self.subviews[0]];
    }
    
    //调整 item 位置
    CGFloat width = self.frame.size.width / [self.subviews count];  //宽度
    CGFloat height = self.frame.size.height;    //高度
    for (int i = 0; i < self.subviews.count; i++) {
        TabBarItem *tabItem = self.subviews[i];
        tabItem.tag = i;
        tabItem.frame = CGRectMake(width * i, 0, width, height);
    }
}

#pragma mark- 监听点击事件
- (void)itemClick:(TabBarItem *)item{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(TabBar: itemSelectedFrom: to:)]) {
        [self.delegate TabBar:self itemSelectedFrom:(int)self.selectedItem.tag to:(int)item.tag];
    }

    //取消之前的选中
    [self.selectedItem setSelected:NO];
    //当前选中
    [item setSelected:YES];
    //记录
    self.selectedItem = item;
}

@end