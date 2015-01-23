//
//  BaseTweetTableController.h
//  twi_iOS
//
//  Created by zerd on 15-1-23.
//  Copyright (c) 2015年 zerd. All rights reserved.
//  微博列表 BaseController 继承这个类实现**方法就可以显示微博列表

#import <UIKit/UIKit.h>

@interface BaseTweetTableController : UITableViewController

@property (nonatomic, strong) NSMutableArray *statusFrameArray;

@end
