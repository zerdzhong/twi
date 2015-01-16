//
//  HomeController.m
//  微博
//
//  Created by zerd on 14-10-17.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "HomeController.h"
#import "UIBarButtonItem+ZD.h"
#import "StatusTool.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "StatusCellFrame.h"
#import "StatusCell.h"

@interface HomeController ()

@property (nonatomic,strong) NSMutableArray *statusFrameArray;

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
    
    //2.请求数据
    
    [self getStatusData];
    
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
}

#pragma mark- 请求首页数据

- (void)getStatusData{
    
    _statusFrameArray = [NSMutableArray array];
    
    [StatusTool getStatusesWithSuccess:^(NSArray *statusArray) {
        //拿到最新微博数据的同时，计算frame
        
        for (StatusModel *status in statusArray) {
            StatusCellFrame *cellFrame = [[StatusCellFrame alloc]init];
            cellFrame.status = status;
            [_statusFrameArray addObject:cellFrame];
        }
        
        //刷新tableview
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        //failure
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

#pragma mark- Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _statusFrameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_statusFrameArray[indexPath.row] cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"home_cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.statusCellFrame = _statusFrameArray[indexPath.row];
    
    return cell;
}

@end
