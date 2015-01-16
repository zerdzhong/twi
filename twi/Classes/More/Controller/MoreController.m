//
//  MoreController.m
//  微博
//
//  Created by zerd on 14-10-17.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "MoreController.h"
#import "UIBarButtonItem+ZD.h"
#import "UIImage+ZD.h"

#define kOrangeColor [UIColor colorWithRed:255/255.0 green:128/255.0 blue:45/255.0 alpha:1.0]

@interface LogoutButton : UIButton

@end

@implementation LogoutButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2 * x;
    CGFloat height = contentRect.size.height;
    
    return CGRectMake(x, y, width, height);
}

@end

@interface MoreController ()

@property (nonatomic,strong) NSArray *listArray;

@end

@implementation MoreController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //1.搭建界面
    [self buildUI];
    
    //2.读取 plist 文件
    [self loadPlist];
    
    //3.设置 tableview 属性
    [self buildTableView];
    
}

#pragma makr- 搭建 UI
- (void)buildUI{
    //设置 Title
    self.title = @"更多";
    //设置右上角 barbutton
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem .rightBarButtonItem setTitleTextAttributes:@{UITextAttributeTextColor:kOrangeColor} forState:UIControlStateNormal];
    //设置退出登录按钮
    LogoutButton *logoutButton = [LogoutButton buttonWithType:UIButtonTypeCustom];
    [logoutButton setImage:[UIImage resizedImage:@"common_button_big_red.png"] forState:UIControlStateNormal];
    [logoutButton setImage:[UIImage resizedImage:@"common_button_big_red_highlighted.png"] forState:UIControlStateHighlighted];
    
    //footview 的宽度不需要设置就是 tableview 的宽度
    logoutButton.bounds = CGRectMake(0, 0, 0, 44);
//    logoutButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    [logoutButton setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    
    [self.tableView setTableFooterView:logoutButton];
    
    //增加底部额外的滚动区域
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 10, 0)];
}

#pragma mark- 读取 plist 文件
- (void)loadPlist{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"More" withExtension:@"plist"];
    self.listArray = [NSArray arrayWithContentsOfURL:url];
}

#pragma mark- 设置 tableview
- (void)buildTableView{
    //1.设置背景
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = kGlobalTableBG;

    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

#pragma mark- Table view datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.listArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //初始化
    static NSString *cellIdentifier = @"more_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //取出对应的数据
    NSDictionary *dic = [[self.listArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    //设置 cell 文字
    cell.textLabel.text = [dic objectForKey:@"name"];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 2) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12];
        label.bounds = CGRectMake(0, 0, 80, 44);
        label.text = indexPath.row ? @"有图模式":@"经典模式";
        cell.accessoryView = label;
    }else{
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.listArray.count - 1) {
        return 10;
    }else {
        return 0.01;
    }
}


#pragma mark- table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
