//
//  ProfileChildTableController.m
//  twi_iOS
//
//  Created by zerd on 15-1-20.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "ProfileUserController.h"
#import "TweetTool.h"
#import "WeiboAccountTool.h"
#import "StatusCellFrame.h"
#import "StatusCell.h"
#import "TweetDetailController.h"
#import "ProfileTool.h"

@interface ProfileUserController ()

@end

@implementation ProfileUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.userArray == nil || self.userArray.count == 0) {
        __unsafe_unretained ProfileUserController *weakSelf = self;
        if (self.type == kFollower) {
            [ProfileTool getFollowerWithUid:_uid success:^(NSArray *resultArray) {
                weakSelf.userArray = [NSMutableArray arrayWithArray:resultArray];
                //刷新tableview
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                MyLog(@"failure");
            }];
        }else if (self.type == kFriend){
            [ProfileTool getFriendWithUid:_uid success:^(NSArray *resultArray) {
                weakSelf.userArray = [NSMutableArray arrayWithArray:resultArray];
                //刷新tableview
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                MyLog(@"failure");
            }];
        }
    }

}

- (void)setUid:(NSString *)uid{
    _uid = uid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到新的用户界面
}

#pragma mark- XLPager
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController{
    return self.title;
}

#pragma mark- Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.scrollTopBlock && scrollView.contentOffset.y < -20){
        self.scrollTopBlock();
    }else if(self.scrollDownBlock && scrollView.contentOffset.y > 0){
        self.scrollDownBlock();
    }
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
