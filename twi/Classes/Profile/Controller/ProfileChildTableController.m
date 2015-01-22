//
//  ProfileChildTableController.m
//  twi_iOS
//
//  Created by zerd on 15-1-20.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "ProfileChildTableController.h"
#import "TweetTool.h"
#import "WeiboAccountTool.h"
#import "StatusCellFrame.h"
#import "StatusCell.h"
#import "TweetDetailController.h"

@interface ProfileChildTableController ()

@property (nonatomic, strong) NSMutableArray *statusFrameArray;

@end

@implementation ProfileChildTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    
    [TweetTool getTweetsWithUid:[WeiboAccountTool sharedWeiboAccountTool].currentCount.uid page:1 success:^(NSArray *statusArray) {
        
        _statusFrameArray = [NSMutableArray array];
        
        for (StatusModel *status in statusArray) {
            StatusCellFrame *cellFrame = [[StatusCellFrame alloc]init];
            cellFrame.status = status;
            [_statusFrameArray addObject:cellFrame];
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



#pragma mark- XLPager
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController{
    return self.title;
}

#pragma mark- Table view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.scrollTopBlock && scrollView.contentOffset.y < -20){
        self.scrollTopBlock();
    }else if(self.scrollDownBlock && scrollView.contentOffset.y > 0){
        self.scrollDownBlock();
    }
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
