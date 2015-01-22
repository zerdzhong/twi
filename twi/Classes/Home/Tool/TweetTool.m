//
//  StatusTool.m
//  微博
//
//  Created by zerd on 14-10-20.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "TweetTool.h"
#import "StatusModel.h"
#import "CommentModel.h"
#import "HttpTool.h"
#import "WeiboAccountTool.h"

@implementation TweetTool

#pragma mark- 获取微博
+ (void)getTweetsWithPage:(int)page success:(SuccessBlock)success failure:(FailureBlock)failure{
    [HttpTool getWithPath:@"2/statuses/home_timeline.json"
                   params:@{@"page":@(page)}
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

+ (void)getPublicTweetsWithCount:(int)count success:(SuccessBlock)success failure:(FailureBlock)failure{
    [HttpTool getWithPath:@"2/statuses/public_timeline.json"
                   params:@{@"count":@(count)}
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
#pragma mark- 获取评论
+ (void)getCommentsWithID:(int64_t )ID page:(int)page success:(SuccessBlock)success failuer:(FailureBlock)failure{
    [HttpTool getWithPath:@"2/comments/show.json"
                   params:@{@"id":@(ID),@"page":@(page),@"count":@(20)}
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
