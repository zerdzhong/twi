//
//  CommentCell.m
//  twi_iOS
//
//  Created by zerd on 15-1-17.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "CommentCell.h"
#import "ProfileImageView.h"
#import "NSString+Common.h"

#define kMemberImageWidth 14
#define kMemberImageHeight 14

@interface CommentCell ()

@property (strong, nonatomic) ProfileImageView *profileView;
@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) UILabel *commentText;

@end

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self ) {
        _profileView = [[ProfileImageView alloc]init];
        [self addSubview:_profileView];
        _userName = [[UILabel alloc]init];
        [self addSubview:_userName];
        _commentText = [[UILabel alloc]init];
        _commentText.numberOfLines = 0;
        _commentText.font = kTextFont;
        [self addSubview:_commentText];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellFrame:(CommentCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    [_profileView setUser:_cellFrame.comment.user type:kProfileTypeSmall];
    _profileView.frame = _cellFrame.profileImageFrame;
    
    _userName.text = _cellFrame.comment.user.screenName;
    _userName.frame = _cellFrame.screenNameFrame;
    
    _commentText.text = _cellFrame.comment.text;
    _commentText.frame = _cellFrame.textFrame;
}

//+ (CGFloat)cellHeightWithObj:(id)obj{
//    CGFloat cellHeight = 0;
//    if ([obj isKindOfClass:[CommentModel class]]) {
//        CommentModel *toComment = (CommentModel *)obj;
//        CGFloat curWidth = kScreen_Width - 40 - 2*kCellBorder;
//        cellHeight += 10 +[toComment.text getHeightWithFont:kTextFont constrainedToSize:CGSizeMake(curWidth, CGFLOAT_MAX)] + 5 +20 +10;
//    }
//    return cellHeight;
//}


@end
