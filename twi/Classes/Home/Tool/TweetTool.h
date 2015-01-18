//
//  StatusTool.h
//  微博
//
//  Created by zerd on 14-10-20.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>

//传回微博数组
typedef void (^SuccessBlock)(NSArray *resultArray);
typedef void (^FailureBlock)(NSError *error);

@interface TweetTool : NSObject

+ (void)getTweetsWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure;
+ (void)getTweetsWithPage:(int)page success:(SuccessBlock)success failure:(FailureBlock)failure;
+ (void)getCommentsWithID:(int64_t )ID page:(int)page  success:(SuccessBlock)success failuer:(FailureBlock)failure;

@end
