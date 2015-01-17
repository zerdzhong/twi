//
//  StatusTool.m
//  微博
//
//  Created by zerd on 14-10-20.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "StatusTool.h"
#import "StatusModel.h"
#import "CommentModel.h"
#import "HttpTool.h"
#import "WeiboAccountTool.h"

@implementation StatusTool

+ (void)getStatusesWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure{

    [HttpTool getWithPath:@"2/statuses/home_timeline.json" params:nil
             successBlock:^(id JSON) {
                 if (success == nil) return ;
                 NSMutableArray *array = [[NSMutableArray alloc]init];
                 NSArray *statuses = JSON[@"statuses"];
                 for (NSDictionary *dict in statuses) {
                     StatusModel *status = [[StatusModel alloc]initWithDict:dict];
                     [array addObject:status];
                 }
                 success(array);
             } failureBlock:^(NSError *error) {
                 if (failure == nil) return ;
                 failure(error);
             }
     ];
}

+ (void)getComments:(int64_t )ID success:(SuccessBlock)success failuer:(FailureBlock)failure{
    [HttpTool getWithPath:@"2/comments/show.json"
                   params:@{@"id":@(ID)}
             successBlock:^(id JSON) {
                 if (success == nil) return ;
                 NSMutableArray *array = [[NSMutableArray alloc]init];
                 NSArray *statuses = JSON[@"comments"];
                 for (NSDictionary *dict in statuses) {
                     CommentModel *comment = [[CommentModel alloc]initWithDict:dict];
                     [array addObject:comment];
                 }
                 success(array);
             }
             failureBlock:^(NSError *error) {
                 if (failure == nil) return ;
                 failure(error);
             }];
}

@end
