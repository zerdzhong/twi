//
//  ProfilePageController.m
//  twi_iOS
//
//  Created by zerd on 15-1-19.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "ProfilePageController.h"
#import "ProfileTool.h"
#import "WeiboAccountTool.h"
#import "MJRefresh.h"
#import "ProfileHeadView.h"


@interface ProfilePageController ()

@property (weak, nonatomic) IBOutlet ProfileHeadView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)UserModel *currentUser;

@end

@implementation ProfilePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __unsafe_unretained ProfilePageController *weakSelf = self;
    
    [ProfileTool getProfileWithUid:[WeiboAccountTool sharedWeiboAccountTool].currentCount.uid
                           success:^(UserModel *user) {
                               weakSelf.currentUser = user;
                               weakSelf.headView.currentUser = _currentUser;
                           } failure:^(NSError *error) {
                               MyLog(@"failure:%@",error.description);
                           }];
    
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.tableFooterView = [UIView new];
//    
//    //添加上下拉刷新
//    [self.tableView addFooterWithTarget:self action:@selector(onFooterRefresh)];
//    [self.tableView addHeaderWithTarget:self action:@selector(onHeaderRefresh)];
    
}

- (void)awakeFromNib{
    _headView.currentUser = _currentUser;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
