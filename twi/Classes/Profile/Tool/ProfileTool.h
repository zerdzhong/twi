//
//  ProfileTool.h
//  twi_iOS
//
//  Created by zerd on 15-1-19.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

//typedef void(^SuccessBlock)(UserModel *user);
typedef void(^FailureBlock)(NSError *error);


@interface ProfileTool : NSObject

//根据用户ID获取信息 uid 为0是获取登录用户信息
+ (void)getProfileWithUid:(NSString *)uid success:(void(^)(UserModel *user))success failure:(FailureBlock)failure;

+ (void)getFollowerWithUid:(NSString *)uid success:(void(^)(NSArray *resultArray))success failure:(FailureBlock)failure;

@end
