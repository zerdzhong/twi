//
//  StatusOptionBar.m
//  微博
//
//  Created by zerd on 14-11-18.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "StatusOptionBar.h"
#import "UIImage+ZD.h"
#import "NSString+ZD.h"


@interface StatusOptionBar ()

@property (nonatomic, strong) UIButton *retweet;
@property (nonatomic, strong) UIButton *comment;
@property (nonatomic, strong) UIButton *upvote;

@end



@implementation StatusOptionBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self ) {
        
        //设备背景
//        [self setImage:[UIImage resizedImage:@"timeline_card_bottom.png"]];
//        [self setBackgroundColor:[UIColor whiteColor]];
        self.userInteractionEnabled = YES;
        
        //添加三个按钮
        self.retweet = [self addButton:@"转发" icon:@"timeline_icon_retweet.png" bg:@"timeline_card_leftbottom.png" index:0];
        self.comment = [self addButton:@"评论" icon:@"timeline_icon_comment.png" bg:@"timeline_card_middlebottom.png" index:1];
        self.upvote = [self addButton:@"赞" icon:@"timeline_icon_unlike.png" bg:@"timeline_card_rightbottom.png" index:2];
    }
    
    return self;
}

- (UIButton *)addButton:(NSString *)title icon:(NSString *)icon bg:(NSString *)bg index:(int)index{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kColor(188, 188, 188) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage resizedImage:bg] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage resizedImage:[bg fileAppend:@"_highlighted"]] forState:UIControlStateHighlighted];
    CGFloat width = self.frame.size.width / 3;
    btn.frame = CGRectMake(index * width, 0, width, kOptionBarHeight);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:btn];
    
    if (index != 0) {
        //添加分割线
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line.png"]];
        imageView.center = CGPointMake(btn.frame.origin.x, kOptionBarHeight * 0.5);
        [self addSubview:imageView];
    }
    
    return btn;
}

- (void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 2*kTableBorderWidth;
    frame.size.height = kOptionBarHeight;
    [super setFrame:frame];
}

-(void)setTweet:(StatusModel *)tweet{
    _tweet = tweet;
    //转发

    NSString *retweetTitle = _tweet.repostsCount ? [self simpleStringWithCount:_tweet.repostsCount]:@"转发";
    [_retweet setTitle:retweetTitle forState:UIControlStateNormal];

    //评论
    NSString *commentTitle = _tweet.commentsCount ? [self simpleStringWithCount:_tweet.commentsCount]:@"评论";
    [_comment setTitle:commentTitle forState:UIControlStateNormal];
    
    //赞
    NSString *upvoteTitle = _tweet.attitudesCount ? [self simpleStringWithCount:_tweet.attitudesCount]:@"赞";
    [_upvote setTitle:upvoteTitle forState:UIControlStateNormal];
}

- (NSString *)simpleStringWithCount:(int)count{
    NSString *reslut = nil;
    if (count >= 10000) {   //上万 保留小数点后一位
        Float32 temp = count / 10000.0;
        reslut = [NSString stringWithFormat:@"%.1f万",temp];
        //不要.0
        reslut = [reslut stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if (count > 0){
        reslut = [NSString stringWithFormat:@"%d",count];
    }
    
    return reslut;
}

@end
