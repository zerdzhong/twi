//
//  HomeController.m
//  微博
//
//  Created by zerd on 14-10-17.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "HomeController.h"
#import "UIBarButtonItem+ZD.h"
#import "TweetTool.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "StatusCellFrame.h"
#import "StatusCell.h"
#import "TweetDetailController.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

@interface HomeController ()

@property (nonatomic, assign) int page;

@end

@implementation HomeController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //1.设置界面属性
    [self setUI];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //2.请求数据
    [self onHeaderRefresh];
    
}

#pragma mark- 初始化界面
- (void)setUI{
    //1.设置标题
    self.title = @"首页";
    
    //2.左边的 item
    
    UIBarButtonItem *leftBtnItem = [UIBarButtonItem itemWithImage:@"navigationbar_compose.png" highlightedImage:@"navigationbar_compose_highlighted.png" target:self action:@selector(sendStatus)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    //3.右边的 item
    
    UIBarButtonItem *rightBtnItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop.png" highlightedImage:@"navigationbar_pop_highlighted.png" target:self action:@selector(popMenu)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //增加底部额外的滚动区域
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 10, 0)];
    [self.tableView setBackgroundColor:kGlobalTableBG];
    
    //添加上下拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(onFooterRefresh)];
    [self.tableView addHeaderWithTarget:self action:@selector(onHeaderRefresh)];
}

#pragma mark- 上下拉刷新
- (void)onFooterRefresh{
    [TweetTool getTweetsWithPage:_page + 1 success:^(NSArray *statusArray) {
        //拿到最新微博数据的同时，计算frame
//        _statusFrameArray = [NSMutableArray array];
        
        for (StatusModel *status in statusArray) {
            StatusCellFrame *cellFrame = [[StatusCellFrame alloc]init];
            cellFrame.status = status;
            [self.statusFrameArray addObject:cellFrame];
        }
        
        //刷新tableview
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        _page ++;
    } failure:^(NSError *error) {
        //failure
        [self.tableView footerEndRefreshing];
    }];
}

- (void)onHeaderRefresh{
    
    __unsafe_unretained HomeController *weakSelf = self;
    
    [TweetTool getTweetsWithPage:1 success:^(NSArray *statusArray) {
        //拿到最新微博数据的同时，计算frame
        weakSelf.statusFrameArray = [NSMutableArray array];
        
        for (StatusModel *status in statusArray) {
            StatusCellFrame *cellFrame = [[StatusCellFrame alloc]init];
            cellFrame.status = status;
            [weakSelf.statusFrameArray addObject:cellFrame];
        }
        
        //刷新tableview
        [weakSelf.tableView reloadData];
        [weakSelf.tableView headerEndRefreshing];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        _page = 1;
    } failure:^(NSError *error) {
        //failure
        [weakSelf.tableView headerEndRefreshing];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

#pragma mark- 发微博
- (void)sendStatus{
    MyLog(@"发微博");
}

#pragma mark- 弹出菜单
- (void)popMenu{
    MyLog(@"菜单");
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//}

@end
