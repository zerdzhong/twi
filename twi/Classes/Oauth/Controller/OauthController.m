//
//  OauthController.m
//  微博
//
//  Created by zerd on 14-10-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "OauthController.h"
#import "WeiboConfig.h"
#import "HttpTool.h"
#import "WeiboAccountTool.h"
#import "MainController.h"
#import "MBProgressHUD.h"

@interface OauthController () <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation OauthController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    _webView = [[UIWebView alloc]initWithFrame:frame];
    [self.view addSubview: _webView];
    
    //1.加载授权登录页面
    NSString *url = [KAuthorizeURL stringByAppendingFormat:@"?display=mobile&client_id=%@&redirect_uri=%@",kAppKey,kRedirctURL];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    
    //2.设置监听
    _webView.delegate = self;
}

#pragma mark- webview 代理

-(void)webViewDidStartLoad:(UIWebView *)webView{
    //当 webview 开始加载
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.labelText = @"正在加载";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //当 webview 加载完成
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    MyLog(@"%@",request.URL);
    
    NSString *urlString = request.URL.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length != 0) {
        //授权成功 不需要跳转到 redirct_url
        NSString *code = [urlString substringFromIndex:range.location + range.length];
        
        //获取 access_token
        
        [self getAccessToken:code];
        
        return NO;
    }
    
    return YES;
}

#pragma mark- 获取 access_token
- (void) getAccessToken:(NSString *) code{
    
    [HttpTool postWithPath:@"oauth2/access_token"
                       params:@{
                                @"client_id":kAppKey,
                                @"client_secret":kAppSecret,
                                @"grant_type":@"authorization_code",
                                @"code":code,
                                @"redirect_uri":kRedirctURL}
                 successBlock:^(id JSON) {
                     MyLog(@"请求成功:-%@",JSON);
                     
                     //保存帐号信息
                     WeiboAccount *account = [[WeiboAccount alloc]init];
                     account.accessToken = [(NSDictionary *)JSON objectForKey:@"access_token"];
                     account.uid = [(NSDictionary *)JSON objectForKey:@"uid"];
                     [[WeiboAccountTool sharedWeiboAccountTool] saveWeiboAccount:account];
                     
                     //清除指示器
                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                     
                     //跳转到 MainController
                     self.view.window.rootViewController = [[MainController alloc]init];
                 } failureBlock:^(NSError *error) {
                     //清除指示器
                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                     MyLog(@"请求失败:-%@",[error localizedDescription]);
                 }];
    
    
}

#pragma mark- Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
