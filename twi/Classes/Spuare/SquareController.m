//
//  SquareController.m
//  twi_iOS
//
//  Created by zerd on 15-1-22.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "SquareController.h"
#import "TweetTool.h"

@interface SquareController ()

@end

@implementation SquareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //请求公共微博
    
    [TweetTool getPublicTweetsWithCount:20 success:^(NSArray *resultArray) {
        MyLog(@"success");
    } failure:^(NSError *error) {
        MyLog(@"failure");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
