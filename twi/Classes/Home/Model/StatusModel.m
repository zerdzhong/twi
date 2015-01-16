//
//  StatusModel.m
//  微博
//
//  Created by zerd on 14-10-20.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "StatusModel.h"

@implementation StatusModel

- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.text = dict[@"text"];
        self.picURLs = dict[@"pic_urls"];
        self.user = [[UserModel alloc]initWithDict:dict[@"user"]];
        //如果有转发
        if (dict[@"retweeted_status"] != nil) {
            self.reStatus = [[StatusModel alloc]initWithDict:dict[@"retweeted_status"]];
        }
        
        self.createdTime = dict[@"created_at"];       //创建时间
        
        self.repostsCount =  [dict[@"reposts_count"] intValue];         //转发数
        self.commentsCount = [dict[@"comments_count"] intValue];        //评论数
        self.attitudesCount = [dict[@"attitudes_count"] intValue];       //表态数
        self.source = dict[@"source"];
        
    }

    return self;
}

- (NSString *)createdTime{
    //Sun Oct 26 20:24:13 +0800 2014
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_createdTime];
    
    //将date与当前时间比较
    NSDate *now = [NSDate date];
    NSTimeInterval second = [now timeIntervalSinceDate:date];
    
    if (second < 60) {  //一分钟以内
        return @"刚刚";
    } else if (second <= 60*60){
        //一小时以内
        return [NSString stringWithFormat:@"%.f分钟前",(second / 60)];
    } else if (second <= 60*60*24){
        //一天内
        return [NSString stringWithFormat:@"%.f小时前",(second / 60 / 60)];
    }else{
        //
        //10-26 20:24:13
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
}

- (void)setSource:(NSString *)source{
    // <a href="http://weibo.com/" rel="nofollow">能吸雾霾的iPhone 6 Plus</a>
    
    unsigned long beg = [source rangeOfString:@">"].location + 1;
    unsigned long int end = [source rangeOfString:@"</"].location;
    
    _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:NSMakeRange(beg, end - beg)]];

}
@end
