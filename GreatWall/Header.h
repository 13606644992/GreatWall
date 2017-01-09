//首页
#import "HomeViewController.h"
//保险商城
#import "MallViewController.h"
//保险课堂
#import "SchoolViewController.h"
//我
#import "UserViewController.h"


#pragma mark ----TheThird---------------
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "Masonry.h"
#import "MJRefresh.h"

#pragma mark ----Controller---------------
#import <AVFoundation/AVFoundation.h>

#import "DataGreatWall.h"

#import "AppDelegate.h"
#import "MallTabBarViewController.h"

#import "SearchController.h"//搜索页

#import "SquareController.h"//活动页
#import "LYColor.h"//颜色
//广播
#import "UADScrollView.h"
//轮播
#import "AEImagePlayerView.h"
#import "AEPageView.h"

#import "UIBarButtonItem+Badge.h"

#import "LYBackButton.h"
#import "LYTitleLable.h"

#import "DescriptionController.h"//商品详情页

//虚线
#import "ImaginaryLine.h"
#import "OnlyLine.h"


#pragma mark ----Anything---------------
//状态栏白色
#define StatusBarWhite           [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO]

//状态栏黑色
#define StatusBarBlack           [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO]

//RGB色彩
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//屏幕宽度
#define ScreenWindowWidth                        [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define ScreenWindowHeight                       [[UIScreen mainScreen] bounds].size.height

#define HEIGHT       [[UIScreen mainScreen] bounds].size.height/667

#define WEIGHT       [[UIScreen mainScreen] bounds].size.width/375
#define WIDTH [UIScreen mainScreen].bounds.size.width / 375

//加载等待
#define SVProgressWait       [SVProgressHUD showWithStatus:@"加载中，请稍后。。。"]
//加载结束
#define SVProgressStop              [SVProgressHUD dismiss]
//字体加粗
#define JiaCu  @"Helvetica-Bold"
//请求时间
#define waitTime   10.0f;

#define SVProgress(AnyThing)      [SVProgressHUD showSuccessWithStatus:AnyThing];

//#define PlaceImage           [UIImage imageNamed:@"186152612"]
#define PlaceImage           [UIImage imageNamed:@"01.jpg"]







#pragma mark   -----------------LYColor------------------
#define LYColor_A1   [LYColor colorWithHexString:@"#2dce8f"]
#define LYColor_A2   [LYColor colorWithHexString:@"#ff7d37"]
#define LYColor_A3   [LYColor colorWithHexString:@"#484c4a"]
#define LYColor_A4   [LYColor colorWithHexString:@"#a8afac"]
#define LYColor_A5   [LYColor colorWithHexString:@"#c4cac7"]
#define LYColor_A6   [LYColor colorWithHexString:@"#e3e3e3"]
#define LYColor_A7   [LYColor colorWithHexString:@"#f5f5f5"]



