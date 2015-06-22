//
//  HttpTool.m
//  微博
//
//  Created by zerd on 14-10-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "HttpTool.h"
#import "WeiboConfig.h"
#import "WeiboAccountTool.h"
#import "UIImageView+WebCache.h"
#import <AFNetworking.h>

@implementation HttpTool

//加载图片
+ (void)loadImageView:(UIImageView *)imageView withUrl:(NSURL *)url place:(UIImage *)placeImage completed:(LoadImageCompletBlock)completed{
    [imageView sd_setImageWithURL:url
                 placeholderImage:placeImage
                          options:SDWebImageRetryFailed | SDWebImageLowPriority
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            completed(image,error);
                        }];
}

//加载图片
+ (void)loadImageView:(UIImageView *)imageView withUrl:(NSURL *)url place:(UIImage *)placeImage;{
    [imageView sd_setImageWithURL:url
            placeholderImage:placeImage
                     options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

//post请求
+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params successBlock:(HttpSuccessBlock)success failureBlock:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params successBlock:success failureBlock:failure method:@"POST"];
}

//get请求
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params successBlock:(HttpSuccessBlock)success failureBlock:(HttpFailureBlock)failure {
    [self requestWithPath:path params:params successBlock:success failureBlock:failure method:@"GET"];
}

+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params successBlock:(HttpSuccessBlock)success failureBlock:(HttpFailureBlock)failure method:(NSString *)method{
    //创建请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", nil];
    
    NSMutableDictionary *allParams = [[NSMutableDictionary alloc]init];
    if (params != nil) {
        [allParams setDictionary:params];
    }
    NSString *access_token = [WeiboAccountTool sharedWeiboAccountTool].currentCount.accessToken;
    if (access_token != nil) {
        [allParams setObject:access_token forKey:@"access_token"];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",kBaseURL,path];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSURLRequest *request = [serializer requestWithMethod:method URLString:urlString parameters:allParams error:nil];
    
    //创建 AFOperation 对象
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return ;
        failure(error);
    }];
    
    //发送请求
    [operation start];
    
}

@end
