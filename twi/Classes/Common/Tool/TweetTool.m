//
//  StatusTool.m
//  微博
//
//  Created by zerd on 14-10-20.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "TweetTool.h"
#import "TweetModel.h"
#import "CommentModel.h"
#import "HttpTool.h"
#import "WeiboAccountTool.h"
#import "NSString+ZDURLEncoding.h"

@implementation TweetTool

#pragma mark- 发微博

+ (void)postTweetWithContent:(NSString *)status success:(SuccessBlock)success failure:(FailureBlock)failure{
    [HttpTool postWithPath:@"2/statuses/update.json"
                    params:@{@"status":status}
              successBlock:^(id JSON) {
                  MyLog(@"success from TweetTool");
                  if (success == nil) return ;
                  success(nil);
              } failureBlock:^(NSError *error) {
                  MyLog(@"failure from TweetTool");
                  if (failure == nil) return ;
                  failure(error);
              }];
}

#pragma mark- 获取微博
+ (void)getTweetsWithPage:(int)page success:(SuccessBlock)success failure:(FailureBlock)failure{
    [HttpTool getWithPath:@"2/statuses/home_timeline.json"
                   params:@{@"page":@(page)}
             successBlock:^(id JSON) {
                 if (success == nil) return ;
                 NSMutableArray *array = [[NSMutableArray alloc]init];
                 NSArray *statuses = JSON[@"statuses"];
                 for (NSDictionary *dict in statuses) {
                     TweetModel *status = [[TweetModel alloc]initWithDict:dict];
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
                     TweetModel *status = [[TweetModel alloc]initWithDict:dict];
                     [array addObject:status];
                 }
                 success(array);
             } failureBlock:^(NSError *error) {
                 if (failure == nil) return ;
                 failure(error);
             }
     ];
}

+ (void)getTweetsWithUid:(NSString *)uid page:(int)page success:(SuccessBlock)success failuer:(FailureBlock)failure{
    if (uid == nil) {
        return;
    }
    [HttpTool getWithPath:@"2/statuses/user_timeline.json"
                   params:@{@"uid":uid}
             successBlock:^(id JSON) {
                 if (success == nil) return ;
                 NSMutableArray *array = [[NSMutableArray alloc]init];
                 NSArray *statuses = JSON[@"statuses"];
                 for (NSDictionary *dict in statuses) {
                     TweetModel *status = [[TweetModel alloc]initWithDict:dict];
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
