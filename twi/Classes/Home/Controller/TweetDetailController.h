//
//  TweetDetailController.h
//  twi_iOS
//
//  Created by zerd on 15-1-16.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusModel.h"

@interface TweetDetailController : UITableViewController

@property (nonatomic, strong) StatusModel *currentStatus;

@end
