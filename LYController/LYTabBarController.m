//
//  LYTabBarController.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/27.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "LYTabBarController.h"
#import "Header.h"

@interface LYTabBarController ()

@end

@implementation LYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.tabBar.frame;
    frame.size.height = 59;
    frame.origin.y = [[UIScreen mainScreen] bounds].size.height- frame.size.height;
    self.tabBar.frame = frame;
    self.tabBar.backgroundColor = [LYColor colorWithHexString:@"fafafa"];
    self.tabBar.barStyle = UIBarStyleDefault;//此处需要设置barStyle，否则颜色会分成上下两层
//    [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];

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
