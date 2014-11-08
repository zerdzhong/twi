//
//  StatusCell.m
//  微博
//
//  Created by zerd on 14-10-23.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  展示一条微博

#import "StatusCell.h"
#import "ProfileView.h"
#import "PictureListView.h"
#import "UIImage+ZD.h"

//会员昵称颜色
#define kMBScreenNameColor
//普通会员颜色
#define kScreenNameColor

@interface StatusCell ()

@property (nonatomic, strong) ProfileView *profileImage;    //头像
@property (nonatomic, strong) UILabel *screenName;          //昵称
@property (nonatomic, strong) UIImageView *memberImage;     //会员图标
@property (nonatomic, strong) UILabel *time;                //时间
@property (nonatomic, strong) UILabel *source;              //来源
@property (nonatomic, strong) UILabel *text;                //内容
@property (nonatomic, strong) PictureListView *picture;         //配图

@property (nonatomic, strong) UIImageView *retweetedView;        //转发微博的父控件
@property (nonatomic, strong) UILabel *retweetedScreenName; //转发微博的作者昵称
@property (nonatomic, strong) UILabel *retweetedText;       //转发微博的内容
@property (nonatomic, strong) PictureListView *retweetedPicture;//转发微博的配图

@end

@implementation StatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self ) {
        //1.添加微博本身子控件
        [self addAllSubviews];
        //2.添加被转发微博的子控件
        [self addRetweetedAllSubViews];
    }
    
    return self;
}

#pragma mark- 初始化界面
- (void)addAllSubviews{
    //头像
    _profileImage = [[ProfileView alloc]init];
    [self.contentView addSubview:_profileImage];

    //昵称
    _screenName = [[UILabel alloc]init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    //会员图标
    _memberImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    [self.contentView addSubview:_memberImage];
    
    //时间
    _time = [[UILabel alloc]init];
    _time.font = kTimeFont;
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];

    //来源
    _source = [[UILabel alloc]init];
    _source.font = kSourceFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    //内容
    _text = [[UILabel alloc]init];
    _text.numberOfLines = 0;
    _text.font = kTextFont;
    _text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_text];
    
    //配图
    _picture = [[PictureListView alloc]init];
    [self.contentView addSubview:_picture];

}

- (void)addRetweetedAllSubViews{
    
    //转发微博试图
    _retweetedView = [[UIImageView alloc]init];
    _retweetedView.image = [UIImage resizedImage:@"timeline_retweet_background.png" xPos:0.9 yPos:0.5];
    [self.contentView addSubview:_retweetedView];
    
    //转发微博的作者昵称
    _retweetedScreenName = [[UILabel alloc]init];
    _retweetedScreenName.font = kRetweetScreenNameFont;
    _retweetedScreenName.textColor = kRetweetScreenNameColor;
    _retweetedScreenName.backgroundColor = [UIColor clearColor];
    [self.retweetedView addSubview:_retweetedScreenName];

    //转发的微博内容
    _retweetedText = [[UILabel alloc]init];
    _retweetedText.font = kRetweetTextFont;
    _retweetedText.backgroundColor = [UIColor clearColor];
    _retweetedText.numberOfLines = 0;
    [self.retweetedView addSubview:_retweetedText];
    
    //转发的微博配图
    _retweetedPicture = [[PictureListView alloc]init];
    [self.retweetedView addSubview:_retweetedPicture];

}


- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame{
    _statusCellFrame = statusCellFrame;
    
    StatusModel *status = statusCellFrame.status;
    
    //头像
    [_profileImage setUser:status.user type:kProfileTypeSmall];
    _profileImage.frame = statusCellFrame.profileImageFrame;
    
    //昵称
    _screenName.frame = statusCellFrame.screenNameFrame;
    _screenName.text = status.user.screenName;
    
    //会员图标
    if (status.user.memberType == kMBTypeNone) {
        _memberImage.hidden = YES;
    }else {
        _memberImage.hidden = NO;
        _memberImage.frame = statusCellFrame.memberImageFrame;
    }
    
    //时间
    _time.frame = statusCellFrame.timeFrame;
    _time.text = status.createdTime;
    
    //来源
    _source.frame = statusCellFrame.sourceFrame;
    _source.text = status.source;
    
    //内容
    _text.frame = statusCellFrame.textFrame;
    _text.text = status.text;
    
    //配图
    if (status.picURLs.count) {
        _picture.hidden = NO;
        _picture.frame = statusCellFrame.pictureFrame;
        [_picture setPicUrlArray:status.picURLs];
    } else {
        _picture.hidden = YES;
    }
    
    if (status.reStatus) {
        _retweetedView.hidden = NO;
        //转发微博试图
        _retweetedView.frame = statusCellFrame.retweetedViewFrame;
        
        //转发微博的作者昵称
        _retweetedScreenName.frame = statusCellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text = [NSString stringWithFormat:@"@%@",status.reStatus.user.screenName];
        
        //转发的微博内容
        _retweetedText.frame = statusCellFrame.retweetedTextFrame;
        _retweetedText.text = status.reStatus.text;
        
        //转发的微博配图
        if (status.reStatus.picURLs.count) {
            _retweetedPicture.hidden = NO;
            _retweetedPicture.frame = statusCellFrame.retweetedPictureFrame;
            [_retweetedPicture setPicUrlArray:status.reStatus.picURLs];
        } else{
            _retweetedPicture.hidden = YES;
        }
    } else {
        _retweetedView.hidden = YES;
    }
    
}

@end
