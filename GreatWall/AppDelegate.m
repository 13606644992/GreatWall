//
//  AppDelegate.m
//  GreatWall
//
//  Created by GJ on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "AppDelegate.h"
#import "LYTabBarController.h"
#import "HomeViewController.h"
#import "MallViewController.h"
#import "MallTabBarViewController.h"
#import "UserViewController.h"
#import "SchoolViewController.h"
#import "SquareController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"



@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [WXApi registerApp:@"wxc7473dec7d6ffdc0"];
    [self setRootTabBarViewController];
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

    return YES;
}
-(void)setRootTabBarViewController
{
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    MallTabBarViewController *mallVC = [[MallTabBarViewController alloc]init];
    SquareController *squareVC = [[SquareController alloc]init];
    SchoolViewController *schoolVC = [[SchoolViewController alloc]init];
    UserViewController *mineVC = [[UserViewController alloc]init];
    UINavigationController *homeNaVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNaVC.tabBarItem.title = @"首页";
    homeNaVC.tabBarItem.image = [[UIImage imageNamed:@"shouye(weixuanzhong)"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNaVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"shouyexuanzhongzhuangtai"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *mallNaVC = [[UINavigationController alloc] initWithRootViewController:mallVC];
    mallNaVC.tabBarItem.title = @"商城";
    mallNaVC.tabBarItem.image = [[UIImage imageNamed:@"shangcheng(weidianji)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ;
    mallNaVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"shangcheng"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *squareNaVC = [[UINavigationController alloc] initWithRootViewController:squareVC];
    squareNaVC.tabBarItem.title = @"发现";
    squareNaVC.tabBarItem.image = [[UIImage imageNamed:@"faxian(weixunazhong)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ;
    squareNaVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"faxian"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UINavigationController *schoolNaVC = [[UINavigationController alloc] initWithRootViewController:schoolVC];
    schoolNaVC.tabBarItem.title = @"课堂";
    schoolNaVC.tabBarItem.image = [[UIImage imageNamed:@"classroom(weixuanzhong)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ;
    schoolNaVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"classroom"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *mineNaVC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNaVC.tabBarItem.title = @"我";
    mineNaVC.tabBarItem.image = [[UIImage imageNamed:@"my(weixuanzhong)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ;
    mineNaVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"my"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    LYTabBarController *tabBarControl =[[LYTabBarController alloc]init];
    tabBarControl.tabBar.tintColor = [UIColor blueColor];
    tabBarControl.viewControllers = @[homeNaVC,mallNaVC,squareNaVC,schoolNaVC,mineNaVC];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:46/255.0 green:208/255.0 blue:178/255.0 alpha:1]];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -5)];
    tabBarControl.tabBar.translucent = NO;
    self.window.rootViewController = tabBarControl;

    
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }else{
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
