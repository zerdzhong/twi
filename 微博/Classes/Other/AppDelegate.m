//
//  AppDelegate.m
//  微博
//
//  Created by zerd on 14-10-13.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "AppDelegate.h"
#import "OauthController.h"
#import "MainController.h"
#import "NewFeatureController.h"
#import "WeiboAccountTool.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    NSString *key = (NSString *)kCFBundleVersionKey;
    // 从 微博-info.plist 中取出的版本号，既当前软件的版本号
    NSString *version = [[NSBundle mainBundle].infoDictionary valueForKey:key];
    // 从沙盒中取出上次使用的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"app_version"];
    
    if ([version isEqualToString:saveVersion]) {
        //版本号一样，判断是否有 token
        
        if ([WeiboAccountTool sharedWeiboAccountTool].currentCount == nil) {
            //没有 token 授权界面
            self.window.rootViewController = [[OauthController alloc]init];
        }else{
            //有 token 直接进入主控制器
            self.window.rootViewController = [[MainController alloc]init];
        }
        
    } else {
        //版本号不一样，第一次使用新版本的软件
        
        //将当前软件的版本号写入沙盒
        [[NSUserDefaults standardUserDefaults]setObject:version forKey:@"app_version"];
        [[NSUserDefaults standardUserDefaults]synchronize];//立即写入沙盒
        
        //显示新特性
        self.window.rootViewController = [[NewFeatureController alloc]init];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
