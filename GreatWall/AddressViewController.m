//
//  AdressViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/22.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "AddressViewController.h"
#import "Header.h"
#import "AddViewController.h"
@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.navigationItem.title = @"地址管理";
    [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor : LYColor_A1}];//修改字体颜色
    [self.navigationController.navigationBar setTintColor:LYColor_A1];//返回按钮颜色
    
    self.view.backgroundColor = LYColor_A7;
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:addBtn];
    addBtn.backgroundColor = LYColor_A1;
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(56*HEIGHT);
    }];
    [addBtn setTitle:@"＋ 新建地址" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    addBtn.titleLabel.textColor = [UIColor whiteColor];
    [addBtn addTarget:self action:@selector(addNewAdress:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    StatusBarBlack;
}
- (void)addNewAdress:(UIButton *)sender{
    AddViewController *addVC = [[AddViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
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
