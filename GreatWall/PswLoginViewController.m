//
//  PswLoginViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "PswLoginViewController.h"
#import "FindPswViewController.h"
#import "SignUpViewController.h"
#import "Header.h"
@interface PswLoginViewController ()
@property (nonatomic, strong, nonnull)UIImageView *logoIMGView;
@property (nonatomic, strong, nonnull)UIImageView *titleIMGView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong, nonnull)UITextField *phoneNum;
@property (nonatomic, strong, nonnull)UITextField *pswNum;
@property (nonatomic, strong, nonnull)UIButton *btn;
@property (nonatomic, strong, nonnull)UIButton *codeBtn;
@property (nonatomic, strong, nonnull)UIButton *loginBtn;
@end

@implementation PswLoginViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;//隐藏导航栏
    StatusBarBlack;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(33*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(25*WIDTH, 25*HEIGHT));
    }];
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    // logo
    self.logoIMGView.frame = CGRectMake(0, 0, 78*WIDTH, 78*HEIGHT);
    self.logoIMGView.center = CGPointMake(375/2*WIDTH, 120*HEIGHT);
    [self.view addSubview:self.logoIMGView];
    
    self.logoIMGView.backgroundColor = [UIColor whiteColor];
    self.logoIMGView.contentMode = UIViewContentModeScaleAspectFit;
    self.logoIMGView.image = [UIImage imageNamed:@"logo.png"];
    //"汇保险"
    [self.view addSubview:self.titleIMGView];
//    self.titleIMGView.frame = CGRectMake(0, 170*HEIGHT, 77*WIDTH, 34*HEIGHT);
//    self.titleIMGView.center = CGPointMake(375/2*WIDTH, 170*HEIGHT);
    [self.titleIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.logoIMGView);
        make.top.mas_equalTo(self.logoIMGView.mas_bottom).with.offset(11*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(77*WIDTH, 34*HEIGHT));
    }];
    self.titleIMGView.backgroundColor = [UIColor whiteColor];
    self.titleIMGView.image = [UIImage imageNamed:@"huibaoxian.png"];
    
    //背景
    self.backgroundView = [[UIView alloc]init];
    [self.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleIMGView.mas_bottom).with.offset(32*HEIGHT);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(110*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
    }];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.cornerRadius = 4.0;
    self.backgroundView.layer.borderColor = LYColor_A6.CGColor;
    self.backgroundView.layer.borderWidth = 1;
    //分割线
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LYColor_A6;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.backgroundView);
        make.width.mas_equalTo(self.backgroundView);
        make.height.mas_equalTo(1);
    }];
    //手机icon
    UIImageView *phoneIMG = [[UIImageView alloc]init];
    [self.backgroundView addSubview:phoneIMG];
    phoneIMG.backgroundColor = [UIColor whiteColor];
    phoneIMG.image = [UIImage imageNamed:@"iphone.png"];
    [phoneIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-27.5*HEIGHT);
        make.left.mas_equalTo(13*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
    }];
    phoneIMG.contentMode = UIViewContentModeScaleAspectFit;
    //密码icon
    UIImageView *pswIMG = [[UIImageView alloc]init];
    [self.backgroundView addSubview:pswIMG];
    [pswIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneIMG);
        make.centerY.mas_equalTo(27.5*HEIGHT);
        make.size.mas_equalTo(phoneIMG);
    }];
    pswIMG.backgroundColor = [UIColor whiteColor];
    pswIMG.image = [UIImage imageNamed:@"mimasuo.png"];
    pswIMG.contentMode = UIViewContentModeScaleAspectFit;
    //手机号输入
    [self.backgroundView addSubview:self.phoneNum];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phoneIMG);
        make.left.mas_equalTo(phoneIMG.mas_right).with.offset(11*WIDTH);
        make.right.mas_equalTo(-13*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
    }];
    self.phoneNum.backgroundColor = [UIColor whiteColor];
    self.phoneNum.placeholder = @"请输入手机号";
    self.phoneNum.font = [UIFont systemFontOfSize:14*WIDTH];
    self.phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNum.textColor = LYColor_A3;
    self.phoneNum.delegate = self;
    //密码
    [self.backgroundView addSubview:self.pswNum];
    self.pswNum.backgroundColor = [UIColor whiteColor];
    self.pswNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswNum.font = [UIFont systemFontOfSize:14*WIDTH];
    self.pswNum.textColor = LYColor_A3;
    [self.pswNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneNum);
        make.centerY.mas_equalTo(pswIMG);
        make.width.mas_equalTo(250*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
    }];
    self.pswNum.delegate = self;
    
    NSString *holderText = @"请输入密码 (6-20位数字、字母组合)";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName value:LYColor_A5 range:NSMakeRange(5, holderText.length - 5)];
    [placeholder addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11*WIDTH]range:NSMakeRange(5, holderText.length - 5)];
    self.pswNum.attributedPlaceholder = placeholder;
    //忘记密码
    UIButton *forgetPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:forgetPswBtn];
    forgetPswBtn.backgroundColor = [UIColor whiteColor];
    [forgetPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backgroundView);
        make.top.mas_equalTo(self.backgroundView.mas_bottom).with.offset(19*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 20*HEIGHT));
    }];
    [forgetPswBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [forgetPswBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPswBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
    forgetPswBtn.titleLabel.font = [UIFont systemFontOfSize:12*WIDTH];
    [forgetPswBtn addTarget:self action:@selector(forgetBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.loginBtn];
    self.loginBtn.backgroundColor = LYColor_A6;
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 4.0f;
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.backgroundView.mas_bottom).with.offset(64 * HEIGHT);
        make.width.mas_equalTo(self.backgroundView);
        make.height.mas_equalTo(44*HEIGHT);
    }];
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.userInteractionEnabled = NO;
    //分隔竖线"丨"
    UILabel *line_shu = [[UILabel alloc]init];
    line_shu.backgroundColor = LYColor_A6;
    [self.view addSubview:line_shu];
    [line_shu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(16 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(1, 12 * HEIGHT));
    }];
    //短信登录
    UIButton *pswBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:pswBtn];
    pswBtn.backgroundColor = [UIColor whiteColor];
    [pswBtn setTitle:@"短信登录" forState:UIControlStateNormal];
    [pswBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
    [pswBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    pswBtn.titleLabel.font = [UIFont systemFontOfSize:12.0 * WIDTH];
    [pswBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [pswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line_shu.mas_left).with.offset(-15 * WIDTH);
        make.centerY.equalTo(line_shu.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100 * WIDTH, 30 * HEIGHT));
        
    }];
    [pswBtn addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    //注册
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:signUpBtn];
    signUpBtn.backgroundColor = [UIColor whiteColor];
    [signUpBtn setTitle:@"我要注册" forState:UIControlStateNormal];
    [signUpBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
    [signUpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    signUpBtn.titleLabel.font = [UIFont systemFontOfSize:12.0 * WIDTH];
    [signUpBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [signUpBtn addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line_shu.mas_right).with.offset(15 * WIDTH);
        make.centerY.equalTo(line_shu.mas_centerY);
        make.size.mas_equalTo(pswBtn);
        
    }];

    //其他登录方式
    UILabel *line_first = [[UILabel alloc]init];
    [self.view addSubview:line_first];
    [line_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pswBtn.mas_bottom).with.offset(63*HEIGHT);
        make.left.mas_equalTo(self.loginBtn);
        make.size.mas_equalTo(CGSizeMake(125*WIDTH, 1));
    }];
    line_first.backgroundColor = LYColor_A6;
    UILabel *line_second = [[UILabel alloc]init];
    [self.view addSubview:line_second];
    [line_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pswBtn.mas_bottom).with.offset(63*HEIGHT);
        make.right.mas_equalTo(self.loginBtn);
        make.size.mas_equalTo(CGSizeMake(125*WIDTH, 1));
    }];
    line_second.backgroundColor = LYColor_A6;
    UILabel *other = [[UILabel alloc]init];
    other.text = @"其他登录方式";
    [self.view addSubview:other];
    [other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.loginBtn);
        make.centerY.mas_equalTo(line_first.mas_top);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 12*HEIGHT));
    }];
    other.font = [UIFont systemFontOfSize:12*WIDTH];
    other.textAlignment = NSTextAlignmentCenter;
    other.textColor = LYColor_A6;
    //微信登录按钮
    UIButton *wxLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxLoginBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wxLoginBtn];
    [wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.loginBtn);
        make.top.mas_equalTo(other.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(44*WIDTH, 44*HEIGHT));
    }];
    [wxLoginBtn setBackgroundImage:[UIImage imageNamed:@"weixin.png"] forState:UIControlStateNormal];
    wxLoginBtn.contentMode = UIViewContentModeScaleAspectFit;
    [wxLoginBtn addTarget:self action:@selector(weixinLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //隐私按钮
    UIButton *hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hideBtn.backgroundColor = [UIColor whiteColor];
    [self.backgroundView addSubview:hideBtn];
    [hideBtn setImage:[UIImage imageNamed:@"mimakejian.png"] forState:UIControlStateNormal];
    [hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13*WIDTH);
        make.centerY.mas_equalTo(self.pswNum);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 30*HEIGHT));
    }];
    [hideBtn addTarget:self action:@selector(hideAction:) forControlEvents:UIControlEventTouchUpInside];
    hideBtn.selected = NO;
    //监听输入框
    [self.phoneNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    [self.pswNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldDidChange:(UITextField *) TextField{
    if ((self.phoneNum.text.length == 11) && self.pswNum.text.length > 5 &&  self.pswNum.text.length < 21) {    // 小于20 大于6 位 密码
        self.loginBtn.userInteractionEnabled = YES;
        [self.loginBtn setBackgroundColor:LYColor_A1];
    }else{
        self.loginBtn.userInteractionEnabled = NO;
        [self.loginBtn setBackgroundColor:LYColor_A6];
    }
}
- (void)hideAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    UIImage *image = sender.isSelected ? [UIImage imageNamed:@"mimabukejian.png"] : [UIImage imageNamed:@"mimakejian.png"];
    [sender setImage:image forState:UIControlStateNormal];
    self.pswNum.secureTextEntry = !self.pswNum.secureTextEntry;
    NSString *text = self.pswNum.text;
    self.pswNum.text = @" ";
    self.pswNum.text = text;
    
    if (self.pswNum.secureTextEntry)
    {
        [self.pswNum insertText:self.pswNum.text];
    }
}

- (void)weixinLoginAction:(UIButton *)sender{
    NSLog(@"微信登录");
}

- (void)loginAction:(UIButton *)sender{
    NSLog(@"登录");
    [self.phoneNum resignFirstResponder];
    [self.pswNum resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"GJ_isLogin"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)messageAction:(UIButton *)sender{
    NSLog(@"短信登录");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)signUpAction:(UIButton *)sender{
    NSLog(@"注册");
    [self.navigationController pushViewController:[[SignUpViewController alloc]init] animated:YES];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.pswNum resignFirstResponder];
    [self.phoneNum resignFirstResponder];
    [self changeToBig];
}
- (void)forgetBtnAction:(UIButton *)sender{
    NSLog(@"忘记密码");
    [self.navigationController pushViewController:[[FindPswViewController alloc]init] animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self changeToSmall];
    if (textField == self.pswNum)
    {
        if (textField.secureTextEntry)
        {
            [textField insertText:self.pswNum.text];
        }
    }
}
- (void)backBtnAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)changeToSmall{
    [UIView animateWithDuration:0.3 animations:^{
        self.logoIMGView.frame = CGRectMake(0, 0, 25*WIDTH, 25*HEIGHT);
        self.logoIMGView.center = CGPointMake(375/2*WIDTH, 72.5*HEIGHT);
        self.logoIMGView.transform = CGAffineTransformMakeRotation(M_PI);
        
        [self.titleIMGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logoIMGView.mas_bottom).with.offset(4*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(25*WIDTH, 11*HEIGHT));
        }];
        [self.view layoutIfNeeded];
    }];
}
- (void)changeToBig{
    [UIView animateWithDuration:0.3 animations:^{
        self.logoIMGView.frame = CGRectMake(0, 0, 78*WIDTH, 78*HEIGHT);
        self.logoIMGView.center = CGPointMake(375/2*WIDTH, 120*HEIGHT);
        self.logoIMGView.transform = CGAffineTransformMakeRotation(0);
        
        [self.titleIMGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logoIMGView.mas_bottom).with.offset(11*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(77*WIDTH, 34*HEIGHT));
        }];
        [self.view layoutIfNeeded];

    }];
    
}
//限制输入长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.phoneNum) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 11 && range.length!=1){
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    if (textField == self.pswNum) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 20 && range.length!=1){
            textField.text = [toBeString substringToIndex:20];
            return NO;
        }
    }
    return YES;
}
- (UIImageView *)logoIMGView{
    if (!_logoIMGView) {
        _logoIMGView = [[UIImageView alloc]init];
    }
    return _logoIMGView;
}
- (UIImageView *)titleIMGView{
    if (!_titleIMGView) {
        _titleIMGView = [[UIImageView alloc]init];
    }
    return _titleIMGView;
}
- (UITextField *)phoneNum{
    if (!_phoneNum) {
        _phoneNum = [[UITextField alloc]init];
    }
    return _phoneNum;
}
- (UITextField *)pswNum{
    if (!_pswNum) {
        _pswNum = [[UITextField alloc]init];
    }
    return _pswNum;
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
