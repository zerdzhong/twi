//
//  ProfileTool.m
//  twi_iOS
//
//  Created by zerd on 15-1-19.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "ProfileTool.h"
#import "HttpTool.h"

@implementation ProfileTool

+ (void)getProfileWithUid:(NSString *)uid success:(void(^)(UserModel *user))success failure:(FailureBlock)failure{
    
    NSDictionary *param = [NSDictionary dictionaryWithObject:uid forKey:@"uid"];
    
    [HttpTool getWithPath:@"2/users/show.json" params:param
             successBlock:^(id JSON) {
                 if (success == nil) return ;
                 UserModel *user = [[UserModel alloc]initWithDict:JSON];
                 success(user);
             } failureBlock:^(NSError *error) {
                 if (failure == nil) return ;
                 failure(error);
             }
     ];
}

+ (void)getFollowerWithUid:(NSString *)uid success:(void(^)(NSArray *resultArray))success failure:(FailureBlock)failure{
    if (uid == nil) {
        return;
    }
    NSDictionary *param = [NSDictionary dictionaryWithObject:uid forKey:@"uid"];
    
    [HttpTool getWithPath:@"2/friendships/followers.json" params:param
             successBlock:^(id JSON) {
                 if (success == nil) return ;
                 
                 NSMutableArray *array = [[NSMutableArray alloc]init];
                 NSArray *statuses = JSON[@"users"];
                 for (NSDictionary *dict in statuses) {
                     UserModel *user = [[UserModel alloc]initWithDict:dict];
                     [array addObject:user];
                 }
                 success(array);
             } failureBlock:^(NSError *error) {
                 if (failure == nil) return ;
                 failure(error);
             }
     ];
}

+ (void)getFriendWithUid:(NSString *)uid success:(void(^)(NSArray *resultArray))success failure:(FailureBlock)failure{

    if (uid == nil) {
        return;
    }
    NSDictionary *param = [NSDictionary dictionaryWithObject:uid forKey:@"uid"];
    [HttpTool getWithPath:@"2/friendships/friends.json" params:param
             successBlock:^(id JSON) {
                 if (success == nil) return ;
                 
                 NSMutableArray *array = [[NSMutableArray alloc]init];
                 NSArray *statuses = JSON[@"users"];
                 for (NSDictionary *dict in statuses) {
                     UserModel *user = [[UserModel alloc]initWithDict:dict];
                     [array addObject:user];
                 }
                 success(array);
             } failureBlock:^(NSError *error) {
                 if (failure == nil) return ;
                 failure(error);
             }
     ];

}

@end
