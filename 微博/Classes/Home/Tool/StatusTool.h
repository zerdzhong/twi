//
//  StatusTool.h
//  微博
//
//  Created by zerd on 14-10-20.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>

//传回微博数组
typedef void (^StatusSuccessBlock)(NSArray *statusArray);
typedef void (^StatusFailureBlock)(NSError *error);

@interface StatusTool : NSObject

+ (void)getStatusesWithSuccess:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;

@end
