//
//  StatusCellFrame.m
//  微博
//
//  Created by zerd on 14-10-23.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "StatusCellFrame.h"
#import "PictureListView.h"
#import "ProfileImageView.h"

#define kMemberImageWidth 14
#define kMemberImageHeight 14

@implementation StatusCellFrame

- (void)setStatus:(StatusModel *)status{
    _status = status;
    
    //整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * kTableBorderWidth;
    
    //利用微博数据，算出控件frame
    
    //头像
    CGFloat profileX = kCellBorder;
    CGFloat profileY = kCellBorder;
    
    CGFloat width = kProfileSmallWidth + 0.5 * kVertifyWidth;
    CGFloat height = kProfileSmallHeight + 0.5 * kVertifyHeight;
    _profileImageFrame = CGRectMake(profileX, profileY, width, height);
    
    
    //昵称
    CGFloat screenX = CGRectGetMaxX(_profileImageFrame) + kMargin;
    CGFloat screenY = kCellBorder;
    CGSize scrennSize = [_status.user.screenName sizeWithFont:kScreenNameFont];
    _screenNameFrame = (CGRect){{screenX,screenY},scrennSize};
    
    //会员图标
    if (status.user.memberType != kMBTypeNone) {
        CGFloat memberImageX = CGRectGetMaxX(_screenNameFrame) + kMargin;
        CGFloat memberImageY = screenY + (_screenNameFrame.size.height - kMemberImageHeight) * 0.5;
        _memberImageFrame = CGRectMake(memberImageX, memberImageY, kMemberImageWidth, kMemberImageHeight);
    }
    
    //时间
    CGFloat timeX = screenX;
    CGFloat timeY = CGRectGetMaxY(_screenNameFrame) + kMargin;
    CGSize timeSize = [_status.createdTime sizeWithFont:kTimeFont];
    _timeFrame = (CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(_timeFrame) + kMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_status.source sizeWithFont:kSourceFont];
    _sourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    //内容
    CGFloat textX = profileX;
    CGFloat textY = MAX(CGRectGetMaxY(_sourceFrame), CGRectGetMaxY(_profileImageFrame))  + kMargin;
    CGSize textSize = [_status.text sizeWithFont:kTextFont
                               constrainedToSize:CGSizeMake(cellWidth - 2 * kCellBorder, MAXFLOAT)];
    _textFrame = (CGRect){{textX,textY},textSize};
    
    //配图
    if (_status.picURLs.count) {
        //有配图
        CGFloat picX = textX;
        CGFloat picY = CGRectGetMaxY(_textFrame) + kMargin;
        CGSize size = [PictureListView pictureListSize:(int)_status.picURLs.count];
        _pictureFrame = CGRectMake(picX, picY, size.width, size.height);
    }else if (_status.reStatus){
        //转发微博整体试图
        CGFloat retweetX = textX;
        CGFloat retweetY = CGRectGetMaxY(_textFrame) + kMargin;
        CGFloat retweetWidth = cellWidth - 2 * kCellBorder;
        CGFloat retweetHeight ;
        
        //转发微博的作者昵称
        CGFloat retweetScreenNameX = kCellBorder;
        CGFloat retweetScreenNameY = kCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@",status.reStatus.user.screenName];
        CGSize retweetScreenNameSize = [name sizeWithFont:kRetweetScreenNameFont];
        _retweetedScreenNameFrame = (CGRect){{retweetScreenNameX,retweetScreenNameY},retweetScreenNameSize};
        
        //转发微博内容
        CGFloat retweetTextX = retweetScreenNameX;
        CGFloat retweetTextY = CGRectGetMaxY(_retweetedScreenNameFrame) + kMargin;
        CGSize retweetTextSize = [_status.reStatus.text sizeWithFont:kRetweetTextFont
                                      constrainedToSize:CGSizeMake(retweetWidth - 2 * kCellBorder, MAXFLOAT)];
        _retweetedTextFrame = (CGRect){{retweetTextX,retweetTextY},retweetTextSize};
        
        
        //转发微博配图
        if (_status.reStatus.picURLs.count) {
            //有配图
            CGFloat retweetPicX = retweetTextX;
            CGFloat retweetPicY = CGRectGetMaxY(_retweetedTextFrame) + kMargin;
            CGSize size = [PictureListView pictureListSize:(int)_status.reStatus.picURLs.count];
            _retweetedPictureFrame = CGRectMake(retweetPicX, retweetPicY, size.width, size.height);
            retweetHeight = CGRectGetMaxY(_retweetedPictureFrame) + kMargin;
        }else {
            retweetHeight = CGRectGetMaxY(_retweetedTextFrame) + kMargin;
        }
        
        //计算转发微博的整体高度

        _retweetedViewFrame = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
    }
    
    //整个cell的高度
    _cellHeight = kCellBorder + kCellMargin + kOptionBarHeight;
    if (status.picURLs.count) {
        _cellHeight += CGRectGetMaxY(_pictureFrame);
    } else if (status.reStatus) {
        _cellHeight += CGRectGetMaxY(_retweetedViewFrame);
    } else {
        _cellHeight += CGRectGetMaxY(_textFrame);
    }
    
}

@end
