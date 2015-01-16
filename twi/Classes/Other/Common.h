//
//  Common.h
//  微博
//
//  Created by zerd on 14-10-16.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#ifndef ___Common_h
#define ___Common_h


//1.判断是否为 iPhone5
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)

#define kColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//表格背景色
#define kGlobalTableBG kColor(237,237,237)

//表格间距
#define kTableBorderWidth 10

//操作条高度
#define kOptionBarHeight 35

//cell之间的间距
#define kCellMargin 8

#define kCellBorder 10
#define kProfile    50
#define kMargin     10

#define kScreenNameFont [UIFont systemFontOfSize:17]
#define kTimeFont   [UIFont systemFontOfSize:13]
#define kSourceFont [UIFont systemFontOfSize:13]
#define kTextFont   [UIFont systemFontOfSize:15]

#define kRetweetScreenNameFont [UIFont systemFontOfSize:16]
#define kRetweetTextFont [UIFont systemFontOfSize:16]

#define kRetweetScreenNameColor kColor(63,104,161)

//2.日志输出宏定义
#ifdef DEBUG
//调试状态
#define MyLog(...) NSLog(__VA_ARGS__)

#else
//发布状态
#define MyLog(...)

#endif

#endif
