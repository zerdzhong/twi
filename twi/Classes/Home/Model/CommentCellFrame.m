//
//  CommentCellFrame.m
//  twi_iOS
//
//  Created by zerd on 15-1-17.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "CommentCellFrame.h"
#import "Common.h"
#import "ProfileImageView.h"

@implementation CommentCellFrame

-(void)setComment:(CommentModel *)comment{
    _comment = comment;
    
    //整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * kTableBorderWidth;
    
    //利用微博数据，算出控件frame
    
    //头像
    CGFloat profileX = kCellBorder;
    CGFloat profileY = kCellBorder;
    
    CGFloat profileWidth = kProfileSmallWidth + 0.5 * kVertifyWidth;
    CGFloat profileHeight = kProfileSmallHeight + 0.5 * kVertifyHeight;
    CGRect profileImageFrame = CGRectMake(profileX, profileY, profileWidth, profileHeight);
    _profileImageFrame = profileImageFrame;
    
    
    //昵称
    CGFloat screenX = CGRectGetMaxX(profileImageFrame) + kMargin;
    CGFloat screenY = kCellBorder;
    CGSize scrennSize = [_comment.user.screenName sizeWithFont:kScreenNameFont];
    CGRect screenNameFrame = (CGRect){{screenX,screenY},scrennSize};
    
    //    CGRect memberImageFrame;
    //    //会员图标
    //    if (_comment.user.memberType != kMBTypeNone) {
    //        CGFloat memberImageX = CGRectGetMaxX(screenNameFrame) + kMargin;
    //        CGFloat memberImageY = screenY + (screenNameFrame.size.height - kMemberImageHeight) * 0.5;
    //        memberImageFrame = CGRectMake(memberImageX, memberImageY, kMemberImageWidth, kMemberImageHeight);
    //    }
    _screenNameFrame = screenNameFrame;
    
    //内容
    CGFloat textX = screenX;
    CGFloat textY = CGRectGetMaxY(screenNameFrame);
    CGSize textSize = [_comment.text sizeWithFont:kTextFont
                                constrainedToSize:CGSizeMake(cellWidth - textX, MAXFLOAT)];
    CGRect textFrame = (CGRect){{textX,textY},textSize};
    _textFrame = textFrame;
    _cellHeight = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_profileImageFrame)) + 5;
}

@end
