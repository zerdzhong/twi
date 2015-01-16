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
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@implementation HttpTool

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
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kBaseURL]];
    
    NSMutableDictionary *allParams = [[NSMutableDictionary alloc]init];
    if (params != nil) {
        [allParams setDictionary:params];
    }
    NSString *access_token = [WeiboAccountTool sharedWeiboAccountTool].currentCount.accessToken;
    if (access_token != nil) {
        [allParams setObject:access_token forKey:@"access_token"];
    }
    
    NSURLRequest *request = [client requestWithMethod:method path:path parameters:allParams];
    
    //创建 AFOperation 对象
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             if (success == nil) return ;
                                             success(JSON);
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             if (failure == nil) return ;
                                             failure(error);
                                         }];
    //发送请求
    [operation start];
    
}

@end
