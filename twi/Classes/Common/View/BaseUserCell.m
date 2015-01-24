//
//  BaseUserCell.m
//  twi_iOS
//
//  Created by zerd on 15-1-23.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "BaseUserCell.h"
#import "ProfileImageView.h"
#import "HttpTool.h"

@interface BaseUserCell ()
@property (weak, nonatomic) IBOutlet ProfileImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end

@implementation BaseUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUser:(UserModel *)user{
    _user = user;
    [_profileImage setUser:_user type:kProfileTypeDefault];
    [_profileImage setTapBlock:^(id objc) {
        MyLog(@"UserCell");
    }];
    [_screenName setText:_user.screenName];
    [_desc setText:_user.desc];
}

@end
