//
//  TweetDetailController.m
//  twi_iOS
//
//  Created by zerd on 15-1-16.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "TweetDetailController.h"
#import "StatusCell.h"
#import "ProfileImageView.h"
#import "UIView+Common.h"
#import "TweetTool.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "MJRefresh.h"

#define kCellIdentifier_TweetDetail @"TweetDetailCell"
#define kCellIdentifier_TweetDetailComment @"TweetDetailCommentCell"

@interface TweetDetailController ()


@property (strong, nonatomic)  NSLayoutConstraint *tweetContent;
@property (strong, nonatomic)  ProfileImageView *profileImage;
@property (strong, nonatomic)  UILabel *userName;
@property (strong, nonatomic)  UILabel *creatTime;
@property (strong, nonatomic)  UILabel *source;
@property (strong, nonatomic)  UILabel *tweetText;

@property (strong, nonatomic) StatusCellFrame *tweetCellFrame;
@property (strong, nonatomic) NSMutableArray *commentFrameArray;

@property (assign, nonatomic) int page;

@end

@implementation TweetDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"微博详情";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[StatusCell class] forCellReuseIdentifier:kCellIdentifier_TweetDetail];
    [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:kCellIdentifier_TweetDetailComment];
    
    //添加上下拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(onFooterRefresh)];
    [self.tableView addHeaderWithTarget:self action:@selector(onHeaderRefresh)];
}

- (void)setCurrentStatus:(StatusModel *)currentStatus{
    _currentStatus = currentStatus;
    if (_tweetCellFrame == nil) {
        _tweetCellFrame = [[StatusCellFrame alloc]init];
    }
    _tweetCellFrame.status = _currentStatus;
    
    [self onHeaderRefresh];
}

#pragma mark- 上下拉刷新
- (void)onFooterRefresh{
    
    [TweetTool getCommentsWithID:_currentStatus.ID page:_page + 1 success:^(NSArray *resultArray) {
        //拿到最新微博数据的同时，计算frame
        
        for (CommentModel *comment in resultArray) {
            CommentCellFrame *cellFrame = [[CommentCellFrame alloc]init];
            cellFrame.comment = comment;
            [_commentFrameArray addObject:cellFrame];
        }
        
        //刷新tableview
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        _page ++;
    } failuer:^(NSError *error) {
        //failure
        [self.tableView footerEndRefreshing];
    }];
}

- (void)onHeaderRefresh{
    [TweetTool getCommentsWithID:_currentStatus.ID page:1 success:^(NSArray *resultArray) {
        //拿到最新微博数据的同时，计算frame
        _commentFrameArray = [NSMutableArray array];
        
        for (CommentModel *comment in resultArray) {
            CommentCellFrame *cellFrame = [[CommentCellFrame alloc]init];
            cellFrame.comment = comment;
            [_commentFrameArray addObject:cellFrame];
        }
        
        //刷新tableview
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        _page = 1;
    } failuer:^(NSError *error) {
        //failure
        [self.tableView headerEndRefreshing];
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
