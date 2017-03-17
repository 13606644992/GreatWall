//
//  SecurityViewController.m
//  GreatWall
//
//  Created by GJ on 2017/2/17.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "SecurityViewController.h"
#import "Header.h"
#import "SecurityTableViewCell.h"
#import "ResetLoginPswVC.h"
#import "SetPayViewController.h"
#import "ChangePayViewController.h"
#import "PhoneVerifyViewController.h"
#import "SetLogInPWDVC.h"
@interface SecurityViewController ()

@end

@implementation SecurityViewController
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    StatusBarBlack;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"账户安全";
    UITableView *securityList = [[UITableView alloc]init];
    [self.view addSubview:securityList];
    [securityList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(18);
        make.height.mas_equalTo(204*HEIGHT);
    }];
    securityList.delegate = self;
    securityList.dataSource = self;
    if ([securityList respondsToSelector:@selector(setSeparatorInset:)]) {
        [securityList setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [securityList setSeparatorColor:LYColor_A6];
    securityList.bounces = NO;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    SecurityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SecurityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 2) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWindowWidth);  //去除分割线
    }
    switch (indexPath.row) {
        case 0:
            cell.titleLab.text = @"登录密码";
            cell.contentLab.text = @"建议您定期更改密码以保护账户安全";
            break;
        case 1:
            cell.titleLab.text = @"支付密码";
            cell.contentLab.text = @"使用账户资产、积分时、用于验证支付";
            break;
        case 2:
            cell.titleLab.text = @"手机验证";
            cell.contentLab.text = @"若您的验证手机丢失或停用，请立即修改更换";
            break;
        default:
            break;
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68*HEIGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSString *loginPwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_loginType"];
        NSLog(@"loginPwd====%@",loginPwd);
        if ([loginPwd isEqualToString:@"1"]) {
            //重置密码
            ResetLoginPswVC *resetLoginPswVC = [[ResetLoginPswVC alloc]init];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:resetLoginPswVC animated:YES];
            
            }else{
                
                //设置密码(未设置过登录密码)
                SetLogInPWDVC *vc = [[SetLogInPWDVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
        }
            }else if (indexPath.row == 1){
        NSString *paymentPwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_paymentPwd"];
        if ([paymentPwd isEqualToString:@"0"]) {
            //设置支付密码（第一次设置支付密码）
            SetPayViewController *vc = [[SetPayViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //修改支付密码
            ChangePayViewController *vc = [[ChangePayViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.row == 2){
        PhoneVerifyViewController *vc = [[PhoneVerifyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
