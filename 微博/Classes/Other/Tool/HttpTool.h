//
//  HttpTool.h
//  微博
//
//  Created by zerd on 14-10-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpSuccessBlock)(id JSON) ;
typedef void (^HttpFailureBlock)(NSError *error) ;

@interface HttpTool : NSObject

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params successBlock:(HttpSuccessBlock)success failureBlock:(HttpFailureBlock)failure ;

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params successBlock:(HttpSuccessBlock)success failureBlock:(HttpFailureBlock)failure ;

@end
