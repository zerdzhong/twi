//
//  ProfileTweetController.m
//  twi_iOS
//
//  Created by zerd on 15-1-23.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "ProfileTweetController.h"
#import "TweetTool.h"
#import "WeiboAccountTool.h"
#import "StatusModel.h"
#import "StatusCellFrame.h"

@interface ProfileTweetController ()

@end

@implementation ProfileTweetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    
    [TweetTool getTweetsWithUid:[WeiboAccountTool sharedWeiboAccountTool].currentCount.uid page:1 success:^(NSArray *statusArray) {
        
        self.statusFrameArray = [NSMutableArray array];
        
        for (StatusModel *status in statusArray) {
            StatusCellFrame *cellFrame = [[StatusCellFrame alloc]init];
            cellFrame.status = status;
            [self.statusFrameArray addObject:cellFrame];
        }
        
        //刷新tableview
        [self.tableView reloadData];
        
        
    } failuer:^(NSError *error) {
        MyLog(@"failure");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.scrollTopBlock && scrollView.contentOffset.y < -20){
        self.scrollTopBlock();
    }else if(self.scrollDownBlock && scrollView.contentOffset.y > 0){
        self.scrollDownBlock();
    }
}

#pragma mark- XLPager
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController{
    return self.title;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
