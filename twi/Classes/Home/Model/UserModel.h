//
//  UserModel.h
//  微博
//
//  Created by zerd on 14-10-20.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kVerifiedTypeNone = - 1,        // 没有认证
    kVerifiedTypePersonal = 0,      // 个人认证
    kVerifiedTypeOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    kVerifiedTypeOrgMedia = 3,      // 媒体官方：程序员杂志、苹果汇
    kVerifiedTypeOrgWebsite = 5,    // 网站官方：猫扑
    kVerifiedTypeDaren = 220        // 微博达人
} VerifiedType;

typedef enum {
    kMBTypeNone = 0,    // 没有
    kMBTypeNormal,      // 普通
    kMBTypeYear         // 年费
} MBType;

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *screenName;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *profileImageURL;      //头像
@property (nonatomic, assign) BOOL verified;                //是否认证
@property (nonatomic, assign) int verifiedType;             //认证类型
@property (nonatomic, assign) int memberRank;               //会员等级
@property (nonatomic, assign) MBType memberType;            //会员类型

@property (nonatomic, copy) NSString *coverImageURL;


- (id)initWithDict:(NSDictionary *)dict;

@end
