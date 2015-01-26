//
//  BaseTweetTableController.m
//  twi_iOS
//
//  Created by zerd on 15-1-23.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "BaseTweetTableController.h"
#import "TweetCellFrame.h"
#import "BaseTweetCell.h"
#import "TweetDetailController.h"
#import "ProfilePageController.h"

@interface BaseTweetTableController ()

@end

@implementation BaseTweetTableController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _statusFrameArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _statusFrameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_statusFrameArray[indexPath.row] cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"status_cell";
    BaseTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[BaseTweetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.statusCellFrame = _statusFrameArray[indexPath.row];
    TweetModel *status = cell.statusCellFrame.status;
    //点击头像进入微博作者页面
    [cell setTapBlock:^(id objc) {
        ProfilePageController *profileController = [[ProfilePageController alloc]init];
        profileController.currentUser = status.user;
        [self.navigationController pushViewController:profileController animated:YES];
    }];
    //    cell.selectedBackgroundView = [UIView new];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark- Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //调到微博详情
    TweetDetailController *tweetVC = [[TweetDetailController alloc]init];
    
    tweetVC.currentStatus = [_statusFrameArray[indexPath.row] valueForKey:@"status"];
    
    [self.navigationController pushViewController:tweetVC animated:YES];
    
}


@end
