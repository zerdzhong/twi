//
//  HttpTool.h
//  微博
//
//  Created by zerd on 14-10-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  封装网络请求和SDWebImage

#import <Foundation/Foundation.h>

typedef void (^HttpSuccessBlock)(id JSON) ;
typedef void (^HttpFailureBlock)(NSError *error) ;

typedef void (^LoadImageCompletBlock)(UIImage *image, NSError *error);

@interface HttpTool : NSObject

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params successBlock:(HttpSuccessBlock)success failureBlock:(HttpFailureBlock)failure ;

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params successBlock:(HttpSuccessBlock)success failureBlock:(HttpFailureBlock)failure ;

+ (void)loadImageView:(UIImageView *)imageView withUrl:(NSURL *)url place:(UIImage *)placeImage;

+ (void)loadImageView:(UIImageView *)imageView withUrl:(NSURL *)url place:(UIImage *)placeImage completed:(LoadImageCompletBlock)completed;

@end
