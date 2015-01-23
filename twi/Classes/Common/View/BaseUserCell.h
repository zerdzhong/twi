//
//  BaseUserCell.h
//  twi_iOS
//
//  Created by zerd on 15-1-23.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;

@interface BaseUserCell : UITableViewCell

@property (nonatomic, strong) UserModel *user;

@end
