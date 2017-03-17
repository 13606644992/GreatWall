//
//  TiXianViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "TiXianViewController.h"
#import "Header.h"
#import "BankCardsViewController.h"
#import "WodezichanViewController.h"
#import "WQAlertView.h"
#import "FindPswViewController.h"

@interface TiXianViewController ()<WQAlertViewDelegate>
@property (nonatomic, strong)UILabel *bankName;
@property (nonatomic, strong)UILabel *bankNum;
@property (nonatomic, strong)UILabel *chuxuka;
@property (nonatomic, strong)UITextField *moneyTextField;
@property (nonatomic, strong)UIButton *confirmBtn;
@property (nonatomic, strong)WQAlertView *alertView;
@end

@implementation TiXianViewController
{
    UIView *navBar;
    UILabel *titleLabel;
    UILabel *shuoming;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"🐷%@",self.money);
    [self setNaviBar];
    [self getBankInffo];
    [self getTiXianCishu];
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64+13*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(91*HEIGHT);
    }];
    
    
    [background addSubview:self.bankName];
//    self.bankName.text = @"中国工商银行";
    [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 20*HEIGHT));
    }];
    UIImageView *kahaoIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yinhangkahao-hui.png"]];
    kahaoIMGView.backgroundColor = [UIColor whiteColor];
    kahaoIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [background addSubview:kahaoIMGView];
    [kahaoIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bankName);
        make.top.mas_equalTo(self.bankName.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 7*HEIGHT));
    }];
    
    [background addSubview:self.bankNum];
//    self.bankNum.text = @"2046";
    [self.bankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(kahaoIMGView);
        make.left.mas_equalTo(kahaoIMGView.mas_right).with.offset(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(36*WIDTH, 15*HEIGHT));
    }];
    
    self.chuxuka = [[UILabel alloc]init];
    self.chuxuka.backgroundColor = [UIColor whiteColor];
    self.chuxuka.font = [UIFont systemFontOfSize:14*HEIGHT];
//    self.chuxuka.text = @"储蓄卡";
    
    self.chuxuka.textColor = LYColor_A5;
    [background addSubview:self.chuxuka];
    [self.chuxuka mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(kahaoIMGView);
        make.left.mas_equalTo(self.bankNum.mas_right).with.offset(6*WIDTH);
        make.size.mas_equalTo(CGSizeMake(43*WIDTH, 14*HEIGHT));
    }];
    
    UIButton *bangDingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bangDingBtn.backgroundColor = [UIColor whiteColor];
    bangDingBtn.layer.cornerRadius = 2.0f;
    [bangDingBtn setTitle:@"已绑定" forState:UIControlStateNormal];
    [bangDingBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    bangDingBtn.layer.masksToBounds = YES;
    bangDingBtn.layer.borderWidth = 1.0f;
    bangDingBtn.layer.borderColor = LYColor_A6.CGColor;
    bangDingBtn.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    [bangDingBtn addTarget:self action:@selector(bangDingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:bangDingBtn];
    [bangDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bankName);
        make.right.mas_equalTo(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(74*WIDTH, 24*HEIGHT));
    }];
    
    UIView *background2 = [[UIView alloc]init];
    background2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background2];
    [background2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(13*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(148*HEIGHT);
    }];
    
    UILabel *tixianjine = [[UILabel alloc]init];
    tixianjine.backgroundColor = [UIColor whiteColor];
    tixianjine.text = @"提现金额（元）:";
    tixianjine.font = [UIFont systemFontOfSize:14*HEIGHT];
    tixianjine.textColor = LYColor_A3;
    [background2 addSubview:tixianjine];
    [tixianjine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 15*HEIGHT));
    }];
    
    UILabel *fuhao = [[UILabel alloc]init];
//    fuhao.backgroundColor = LYColor_A1;
    fuhao.text = @"¥";
    fuhao.textColor = LYColor_A3;
    fuhao.font = [UIFont systemFontOfSize:18*HEIGHT];
    [background2 addSubview:fuhao];
    [fuhao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tixianjine.mas_bottom).with.offset(67*HEIGHT);
        make.left.mas_equalTo(tixianjine);
        make.size.mas_equalTo(CGSizeMake(10*WIDTH, 18*HEIGHT));
    }];
    
    [background2 addSubview:self.moneyTextField];
//    self.moneyTextField.text = @"387.64";
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(fuhao.mas_right).with.offset(8*WIDTH);
        make.bottom.mas_equalTo(fuhao);
        make.size.mas_equalTo(CGSizeMake(260*WIDTH, 30*HEIGHT));
    }];
    
    UIButton *quanbuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quanbuBtn.backgroundColor = [UIColor whiteColor];
    [quanbuBtn setTitle:@"全部提现" forState:UIControlStateNormal];
    [quanbuBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [quanbuBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    quanbuBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [quanbuBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [quanbuBtn addTarget:self action:@selector(quanbuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [background2 addSubview:quanbuBtn];
    [quanbuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(self.moneyTextField);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 30*HEIGHT));
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = LYColor_A7;
    [background2 addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(fuhao.mas_bottom).with.offset(14*HEIGHT);
        make.height.mas_equalTo(1);
    }];
//    self.money = @"249.85";
//    self.times = @"3";
    shuoming = [[UILabel alloc]init];
    shuoming.backgroundColor = [UIColor whiteColor];
    shuoming.textAlignment = NSTextAlignmentLeft;
    shuoming.textColor = LYColor_A5;
    shuoming.text = [NSString stringWithFormat:@"可提现%@元  本月还可以免费提现%@次", self.money, self.times];
    shuoming.font = [UIFont systemFontOfSize:12*HEIGHT];
    [background2 addSubview:shuoming];
    [shuoming mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.top.mas_equalTo(line.mas_bottom).with.offset(10*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(300*WIDTH, 12*HEIGHT));
    }];
    
    UIImageView *tixingIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tixingfuhao.png"]];
    tixingIMGView.backgroundColor = LYColor_A7;
    tixingIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:tixingIMGView];
    [tixingIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(background2.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*WIDTH));
    }];
    
    UILabel *tixingLabel = [[UILabel alloc]init];
    tixingLabel.backgroundColor = LYColor_A7;
    tixingLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    tixingLabel.text = @"您本月若超出提现次数，继续提现需要扣除1.5元/次手续费";
    tixingLabel.textColor = LYColor_A4;
    tixingLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tixingLabel];
    [tixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tixingIMGView.mas_right).with.offset(8*WIDTH);
        make.centerY.mas_equalTo(tixingIMGView);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(12*HEIGHT);
    }];
    
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tixingLabel.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44*HEIGHT);
    }];
}
#pragma mark - 自定义navigationBar
- (void)setNaviBar{
    navBar = [[UIView alloc]init];
    navBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"jiantou-lv"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.bottom.mas_equalTo(-12.5);
        make.size.mas_equalTo(CGSizeMake(10, 18));
    }];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setImage:[UIImage imageNamed:@"lvwenhao.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.bottom.mas_equalTo(-12.5);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"全部明细";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = LYColor_A1;
    [navBar addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(139*WIDTH);
        make.bottom.mas_equalTo(-12.5);
        make.size.mas_equalTo(CGSizeMake(70, 18));
    }];
    
    UIImageView *xiaLaIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiala-mingxi"]];
    [navBar addSubview:xiaLaIMG];
    xiaLaIMG.contentMode = UIViewContentModeScaleAspectFit;
    [xiaLaIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).offset(18*WIDTH);
        make.centerY.mas_equalTo(titleLabel);
        make.size.mas_equalTo(CGSizeMake(12, 7));
    }];
    
    [self.view bringSubviewToFront:navBar];
}
- (void)btnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据请求-获取银行卡信息
- (void)getBankInffo{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"]}];
    [GJAFNetWork POST:URL_KENAN params:dic method:@"getBankCardList" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"银行卡信息responseObject=======%@",responseObject);
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            self.bankName.text = responseObject[@"output"][@"bankName"];
            self.chuxuka.text = responseObject[@"output"][@"cardType"];
            self.bankNum.text = responseObject[@"output"][@"lastDigits"];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark - 获取免费提现次数
- (void)getTiXianCishu{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"]}];
    [GJAFNetWork  POST:URL_ALIANG params:dic method:@"getWithdrawCount" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取免费提现次数=======%@",responseObject);
        NSString *str = responseObject[@"output"];
        self.times = str;
        shuoming.text = [NSString stringWithFormat:@"可提现%@元  本月还可以免费提现%@次", self.money, self.times];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark - 立即提现按钮---弹出提示框
- (void)confirmBtnAction:(UIButton *)sender{
    NSLog(@"提现");
    if (self.moneyTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请输入提现金额" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([self.moneyTextField.text floatValue] > [self.money floatValue]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"提现金额不能大于余额" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        if (self.alertView == nil) {
            self.alertView = [[WQAlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight)];
            self.alertView.delegate = self;
            [self.view addSubview:self.alertView];
        }
        [self.alertView showView];
    }
    
}

#pragma mark - alert取消按钮
- (void)AlertCancelBtn:(UIButton *)sender{
    NSLog(@"取消");
//    [self.alertView removeFromSuperview];
    [self.alertView hideView];
}
#pragma mark - alert忘记密码
- (void)AlertForgetPSWBtn:(UIButton *)sender{
    NSLog(@"忘记");
    FindPswViewController *findVC = [[FindPswViewController alloc]init];
    [self.navigationController pushViewController:findVC animated:YES];
}
#pragma mark - alert确定按钮---校验支付密码
- (void)WQAlertTextField:(NSString *)textField{
    NSLog(@"-=-=-=-=-=-=-=校验");
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"],@"payPwd":textField}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"verifyPayPwd" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@,%@",textField,responseObject);
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            NSLog(@"支付密码校验成功");
            //支付密码校验成功后，提现
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"],@"cashAmount":self.moneyTextField.text}];
            [GJAFNetWork POST:URL_ALIANG params:dic method:@"applyCash" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"银行卡信息responseObject=======%@",responseObject);
                if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"提现成功，3到5个工作日到账" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.alertView hideView];
//                        for (UIViewController *controller in self.navigationController.viewControllers) {
//                            if ([controller isKindOfClass:[WodezichanViewController class]]) {
//                                WodezichanViewController *vc = (WodezichanViewController *)controller;
//                                [self.navigationController popToViewController:vc animated:YES];
//                            }
//                        }
                    }]];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                    
            }];

        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"支付密码不正确" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark - 全部提现
- (void)quanbuBtnAction:(UIButton *)sender{
    NSLog(@"全部提现");
    if ( [self.money floatValue] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"您的余额为0.00元" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        self.moneyTextField.text = self.money;
        if (self.alertView == nil) {
            self.alertView = [[WQAlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight)];
            self.alertView.delegate = self;
            [self.view addSubview:self.alertView];
        }
        [self.alertView showView];
        [self confirmBtnAction:sender];
    }
}
#pragma mark - 问号h5
- (void)rightBtnAction{
    NSLog(@"问号");

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.moneyTextField resignFirstResponder];
}

- (void)bangDingBtnAction:(UIButton *)sender{
    NSLog(@"已绑定");
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[BankCardsViewController alloc]init] animated:YES];
}

/* lazyLoading.....................................*/

- (UILabel *)bankName{
    if (!_bankName) {
        _bankName = [[UILabel alloc]init];
        _bankName.font = [UIFont systemFontOfSize:18*HEIGHT];
        _bankName.textColor = LYColor_A3;
    }
    return _bankName;
}
- (UILabel *)bankNum{
    if (!_bankNum) {
        _bankNum = [[UILabel alloc]init];
        _bankNum.font = [UIFont systemFontOfSize:13*HEIGHT];
        _bankNum.textColor = LYColor_A5;
    }
    return _bankNum;
}
- (UITextField *)moneyTextField{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc]init];
        _moneyTextField.backgroundColor = [UIColor whiteColor];
        _moneyTextField.font = [UIFont systemFontOfSize:36*HEIGHT];
        _moneyTextField.textColor = LYColor_A3;
        _moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _moneyTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _moneyTextField;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = LYColor_A1;
        [_confirmBtn setTitle:@"立即提现" forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = 4.0f;
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
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
