//
//  RootViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "RootViewController.h"
#import "Header.h"

@interface RootViewController ()

@end

@implementation RootViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYColor_A7;
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
    //                                                         forBarMetrics:UIBarMetricsDefault];
    self.rootBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rootBackBtn.frame = CGRectMake(0, 0, 10, 17.5);
    [self.rootBackBtn setImage:[UIImage imageNamed:@"jiantou-lv.png"] forState:UIControlStateNormal];
    [self.rootBackBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView: self.rootBackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}
-(void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    self.view.backgroundColor = [UIColor whiteColor];
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
