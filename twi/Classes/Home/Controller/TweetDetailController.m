//
//  TweetDetailController.m
//  twi_iOS
//
//  Created by zerd on 15-1-16.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "TweetDetailController.h"
#import "StatusCell.h"
#import "ProfileView.h"
#import "UIView+Common.h"
#import "StatusTool.h"
#import "CommentModel.h"
#import "CommentCell.h"

#define kCellIdentifier_TweetDetail @"TweetDetailCell"
#define kCellIdentifier_TweetDetailComment @"TweetDetailCommentCell"

@interface TweetDetailController ()


@property (strong, nonatomic)  NSLayoutConstraint *tweetContent;
@property (strong, nonatomic)  ProfileView *profileImage;
@property (strong, nonatomic)  UILabel *userName;
@property (strong, nonatomic)  UILabel *creatTime;
@property (strong, nonatomic)  UILabel *source;
@property (strong, nonatomic)  UILabel *tweetText;

@property (strong, nonatomic) StatusCellFrame *tweetCellFrame;
@property (strong, nonatomic) NSMutableArray *commentFrameArray;

@end

@implementation TweetDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"微博详情";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[StatusCell class] forCellReuseIdentifier:kCellIdentifier_TweetDetail];
    [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:kCellIdentifier_TweetDetailComment];
}

- (void)setCurrentStatus:(StatusModel *)currentStatus{
    _currentStatus = currentStatus;
    if (_tweetCellFrame == nil) {
        _tweetCellFrame = [[StatusCellFrame alloc]init];
    }
    _tweetCellFrame.status = _currentStatus;
    
    
    _commentFrameArray = [NSMutableArray array];
    [StatusTool getComments:_currentStatus.ID success:^(NSArray *commentArray) {
        
        for (CommentModel *comment in commentArray) {
            CommentCellFrame *cellFrame = [[CommentCellFrame alloc]init];
            cellFrame.comment = comment;
            [_commentFrameArray addObject:cellFrame];
        }

        [self.tableView reloadData];
    } failuer:^(NSError *error) {
        
    }];
}

#pragma makr- TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [_tweetCellFrame cellHeight];
    }else{
        CommentCellFrame *cellFrame = [_commentFrameArray objectAtIndex:indexPath.row - 1];
        return cellFrame.cellHeight;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 + [_commentFrameArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TweetDetail];
        if (cell == nil) {
            cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier_TweetDetail];
        }
        
        cell.statusCellFrame = _tweetCellFrame;
        [cell setBackgroundView:[UIView new]];
        [cell setSelectedBackgroundView:[UIView new]];
        return cell;
    }else{
    
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TweetDetailComment];
        
        if (cell == nil) {
            cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier_TweetDetail];
        }
        
        CommentCellFrame *cellFrame = [_commentFrameArray objectAtIndex:indexPath.row - 1];
        cell.cellFrame = cellFrame;
        
        return cell;
    }
    
    
}

@end
