//
//  UserModel.m
//  微博
//
//  Created by zerd on 14-10-20.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.screenName = dict[@"screen_name"];
        self.profileImageURL = dict[@"avatar_hd"];
        self.verified = [dict[@"verified"] boolValue];
        self.verifiedType = [dict[@"verified_ype"] intValue];
        self.memberRank = [dict[@"mbrank"] intValue];
        self.memberType = [dict[@"mbtype"] intValue];
        self.coverImageURL = dict[@"cover_image_phone"];
        self.desc = dict[@"description"];
    }
    
    return self;
}


@end
