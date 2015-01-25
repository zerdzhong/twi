//
//  StatusCell.h
//  微博
//
//  Created by zerd on 14-10-23.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusCellFrame.h"

@interface StatusCell : UITableViewCell

@property (nonatomic, copy) void(^tapBlock)(id objc);
@property (nonatomic, strong) StatusCellFrame *statusCellFrame;

@end
