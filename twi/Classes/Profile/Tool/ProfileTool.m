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

+ (void)getProfileWithUid:(NSString *)uid success:(SuccessBlock)success failure:(FailureBlock)failure{
    
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

@end
