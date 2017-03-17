//
//  MineViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "LoginViewController.h"
#import "Header.h"
#import "LoginView.h"
#import "AgreementViewController.h"
#import "PswLoginViewController.h"
#import "SignUpViewController.h"
@interface LoginViewController ()
@property (nonatomic, strong)LoginView *loginView;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;//隐藏导航栏
    StatusBarBlack;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if (self.loginView) {
        if (self.loginView.currentcountDown != 10 || self.loginView.currentcountDown != 0) {
            [self.loginView.myTimer invalidate];
//            self.loginView.myTimer = nil;
            [self.loginView.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.loginView.currentcountDown = 60;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self addLoginView];

    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushToAgreementVC) name:@"pushToAgreementVC" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushToPswLoginVC) name:@"pushToPswLoginVC" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushToSignUpVC) name:@"pushToSignUpVC" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToUserView) name:@"backToUserView" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backBtnAction:) name:@"popBack" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(warningAction:) name:@"warning" object:nil];
    self.hidesBottomBarWhenPushed = YES;//隐藏tabbar，之后页面都要隐藏，故写在viewdidload里面。
}
//提示框
- (void)warningAction:(NSNotification *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:sender.userInfo[@"respMsg"] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)backBtnAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//跳转到条款页面 (通知)
- (void)pushToAgreementVC{
    [self.navigationController pushViewController:[[AgreementViewController alloc]init] animated:YES];
}
//跳转到密码登录页面（通知）
- (void)pushToPswLoginVC{
    [self.navigationController pushViewController:[[PswLoginViewController alloc]init] animated:YES];
}
//跳转到注册页面 （通知）
- (void)pushToSignUpVC{
    [self.navigationController pushViewController:[[SignUpViewController alloc]init] animated:YES];
}
//转到User页面 （通知）
- (void)backToUserView{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"GJ_isLogin"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}



- (void)addLoginView{
    [self.view addSubview:self.loginView];
    self.loginView.backgroundColor = [UIColor whiteColor];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
}

//注销通知！！！！
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}




/*                    LazyLoading............             */

- (LoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LoginView alloc]init];
    }
    return _loginView;
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
