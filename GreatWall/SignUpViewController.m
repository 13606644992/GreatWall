//
//  SignUpViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "SignUpViewController.h"
#import "Header.h"
#import "AgreementViewController.h"
#import "PswLoginViewController.h"
@interface SignUpViewController ()
@property (nonatomic, strong)UIImageView *titleIMGView;
@property (nonatomic, strong)UITextField *phoneNum;
@property (nonatomic, strong)UITextField *codeNum;
@property (nonatomic, strong)UITextField *pswNum;
@property (nonatomic, strong)UIButton *codeBtn;
@property (nonatomic, strong)NSTimer *myTimer;
@property (nonatomic, assign)NSInteger currentcountDown;
@property (nonatomic, strong, nonnull)UIButton *btn;
@property (nonatomic, strong)UIButton *signUpBtn;
@property (nonatomic, strong)UIButton *backBtn;
@end

@implementation SignUpViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    StatusBarBlack;
}
- (void)viewWillDisappear:(BOOL)animated{
    if (self.currentcountDown != 10 || self.currentcountDown != 0) {
        [self.myTimer invalidate];
        self.myTimer = nil;
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.currentcountDown = 60;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentcountDown = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(33*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(25*WIDTH, 22*HEIGHT));
    }];
    self.backBtn.backgroundColor = [UIColor clearColor];
    [self.backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.titleIMGView];
    self.titleIMGView.backgroundColor = [UIColor clearColor];
    [self.titleIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(68*HEIGHT);
        make.left.mas_equalTo(3*WIDTH);
        make.right.mas_equalTo(-3*WIDTH);
        make.height.mas_equalTo(95*HEIGHT);
    }];
    self.titleIMGView.image = [UIImage imageNamed:@"xinrenzhuceyoujiang.png"];
    self.titleIMGView.contentMode = UIViewContentModeScaleAspectFit;
//背景
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    background.layer.cornerRadius = 4.0;
    background.layer.borderColor = LYColor_A6.CGColor;
    background.layer.borderWidth = 1.0;
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleIMGView.mas_bottom).with.offset(46*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(168*HEIGHT);
    }];
    UILabel *line_first = [[UILabel alloc]init];
    line_first.backgroundColor = LYColor_A6;
    [background addSubview:line_first];
    [line_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(168/3*HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    UILabel *line_second = [[UILabel alloc]init];
    line_second.backgroundColor = LYColor_A6;
    [background addSubview:line_second];
    [line_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(168/3*2*HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    UIImageView *phoneIMG = [[UIImageView alloc]init];
    [background addSubview:phoneIMG];
    phoneIMG.image = [UIImage imageNamed:@"iphone.png"];
    phoneIMG.backgroundColor = [UIColor whiteColor];
    [phoneIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-168/3*HEIGHT);
        make.left.mas_equalTo(13*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
        make.width.mas_equalTo(15*WIDTH);
    }];
    phoneIMG.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *codeIMG=  [[UIImageView alloc]init];
    [background addSubview:codeIMG];
    codeIMG.image = [UIImage imageNamed:@"yanzhengma.png"];
    codeIMG.backgroundColor = [UIColor whiteColor];
    [codeIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(13*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
        make.width.mas_equalTo(15*WIDTH);
    }];
    codeIMG.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView *pswIMG=  [[UIImageView alloc]init];
    [background addSubview:pswIMG];
    pswIMG.image = [UIImage imageNamed:@"mimasuo.png"];
    pswIMG.backgroundColor = [UIColor whiteColor];
    [pswIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(168/3*HEIGHT);
        make.left.mas_equalTo(13*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
        make.width.mas_equalTo(15*WIDTH);
    }];
    pswIMG.contentMode = UIViewContentModeScaleAspectFit;
    //手机号
    [background addSubview:self.phoneNum];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneIMG.mas_right).with.offset(11*WIDTH);
        make.centerY.mas_equalTo(phoneIMG);
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
    //验证码
    [background addSubview:self.codeNum];
    self.codeNum.backgroundColor = [UIColor whiteColor];
    self.codeNum.placeholder = @"请输入验证码";
    self.codeNum.keyboardType = UIKeyboardTypeNumberPad;
    self.codeNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeNum.font = [UIFont systemFontOfSize:14*WIDTH];
    self.codeNum.textColor = LYColor_A3;
    [self.codeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeIMG.mas_right).with.offset(11*WIDTH);
        make.centerY.mas_equalTo(codeIMG);
        make.width.mas_equalTo(200*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
    }];
    self.codeNum.delegate = self;
    //密码
    [background addSubview:self.pswNum];
    [self.pswNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pswIMG.mas_right).with.offset(11*WIDTH);
        make.centerY.mas_equalTo(pswIMG);
        make.right.mas_equalTo(-13*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
    }];
    self.pswNum.backgroundColor = [UIColor whiteColor];
    self.pswNum.font = [UIFont systemFontOfSize:14*WIDTH];
    self.pswNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswNum.textColor = LYColor_A3;
    self.pswNum.delegate = self;
    NSString *holderText = @"请输入密码 (6-20位数字、字母组合)";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName value:LYColor_A5 range:NSMakeRange(5, holderText.length - 5)];
    [placeholder addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11*WIDTH]range:NSMakeRange(5, holderText.length - 5)];
    self.pswNum.attributedPlaceholder = placeholder;
    
    //隐私按钮
    UIButton *hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hideBtn.backgroundColor = [UIColor whiteColor];
    [background addSubview:hideBtn];
    [hideBtn setImage:[UIImage imageNamed:@"mimakejian.png"] forState:UIControlStateNormal];
    [hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13*WIDTH);
        make.centerY.mas_equalTo(self.pswNum);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 30*HEIGHT));
    }];
    [hideBtn addTarget:self action:@selector(hideAction:) forControlEvents:UIControlEventTouchUpInside];
    hideBtn.selected = NO;

    //验证码按钮
    self.codeBtn.backgroundColor = [UIColor whiteColor];
    [background addSubview:self.codeBtn];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*WIDTH];
    [self.codeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.codeNum);
        make.right.mas_equalTo(-13*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 13*HEIGHT));
    }];
    [self.codeBtn addTarget:self action:@selector(agreementAction) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn.userInteractionEnabled = NO;
    //阅读状态按钮
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setImage:[UIImage imageNamed:@"gouxuan.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(background);
        make.top.equalTo(background.mas_bottom).with.offset(20 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(20 * WIDTH, 20 * HEIGHT));
    }];
    [self.btn addTarget:self action:@selector(agreebtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.btn.selected = YES;
    
    UILabel *agreement = [[UILabel alloc]init];
    [self.view addSubview:agreement];
    agreement.backgroundColor = [UIColor whiteColor];
    agreement.text = @"已阅读并同意《汇保险注册协议》";
    agreement.font = [UIFont fontWithName:@"applegothic" size:11.0 * WIDTH];
    agreement.textColor = [UIColor whiteColor];
    NSMutableAttributedString *agreementString=[[NSMutableAttributedString alloc]initWithString:@"已阅读并同意《汇保险注册协议》"];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[agreementString string]rangeOfString:@"已阅读并同意"];
    [agreementString addAttribute:NSForegroundColorAttributeName value:LYColor_A3 range:range1];
    NSRange range2=[[agreementString string]rangeOfString:@"《汇保险注册协议》"];
    [agreementString addAttribute:NSForegroundColorAttributeName value:LYColor_A1 range:range2];
    agreement.attributedText=agreementString;
    [agreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn.mas_right).with.offset(10 * WIDTH);
        make.top.equalTo(self.btn);
        make.height.equalTo(self.btn);
        make.width.mas_equalTo(170 * WIDTH);
    }];
    agreement.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agreementGesture)];
    [agreement addGestureRecognizer:gesture];
    //注册按钮
    [self.view addSubview:self.signUpBtn];
    self.signUpBtn.backgroundColor = LYColor_A6;
    [self.signUpBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [self.signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signUpBtn.layer.cornerRadius = 4.0f;
    [self.signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.btn.mas_bottom).with.offset(29 * HEIGHT);
        make.width.mas_equalTo(background);
        make.height.mas_equalTo(44*HEIGHT);
    }];
    [self.signUpBtn addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    self.signUpBtn.userInteractionEnabled = NO;
    //监听输入框
    [self.phoneNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    [self.codeNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    [self.pswNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    //已有账号，去登录
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signUpBtn.mas_bottom).with.offset(5*HEIGHT);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 30*HEIGHT));
    }];
    [loginBtn setTitle:@"已有账号，去登陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*WIDTH];
    [loginBtn addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
    //把返回按钮置于最上
    [self.view bringSubviewToFront:self.backBtn];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNum resignFirstResponder];
    [self.codeNum resignFirstResponder];
    [self.pswNum resignFirstResponder];
    
    if (self.view.frame.origin.y == -110*HEIGHT) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(33*HEIGHT);
            }];
            [self.view layoutIfNeeded];
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}
- (void)goToLogin{
    NSLog(@"去登陆");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldDidChange:(UITextField *) TextField{
    if (self.phoneNum.text.length == 11 && self.pswNum.text.length > 5 && self.pswNum.text.length < 21&&![self.codeNum.text isEqualToString:@""]&&self.btn.isSelected) {
        self.signUpBtn.userInteractionEnabled = YES;
        [self.signUpBtn setBackgroundColor:LYColor_A1];
    }else{
        self.signUpBtn.userInteractionEnabled = NO;
        [self.signUpBtn setBackgroundColor:LYColor_A6];
    }
    //改变按钮可点击
    self.codeBtn.userInteractionEnabled = self.phoneNum.text.length == 11 ? YES : NO;
    //改变按钮文字颜色
    UIColor *titleColor = self.codeBtn.userInteractionEnabled ?  LYColor_A1 : LYColor_A5;
    [self.codeBtn setTitleColor:titleColor forState:UIControlStateNormal];

}
- (void)signUpAction:(UIButton *)sender{
    NSLog(@"注册");
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userName":self.phoneNum.text, @"loginPwd":self.pswNum.text, @"smsCode":self.codeNum.text}];
    
    [GJAFNetWork POST:URL_ALIANG params:params method:@"regUser" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            //循环，如果有的话就直接返回
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[PswLoginViewController class]]) {
                    PswLoginViewController *pswVC =(PswLoginViewController *)controller;
                    [self.navigationController popToViewController:pswVC animated:YES];
                    return; //返回之后直接return
                }
            }
            //如果没有的话就加到controller数组里
            PswLoginViewController *pswVC = [[PswLoginViewController alloc]init];
            NSMutableArray *controllersArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [controllersArr insertObject:pswVC atIndex:1];
            self.navigationController.viewControllers = controllersArr;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];

    
}
//btn点击事件
- (void)agreebtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    //点击改变
    UIImage *image = sender.isSelected ? [UIImage imageNamed:@"gouxuan.png"] : [UIImage imageNamed:@"Rectanglearrondi16copie.png"];
    [sender setImage:image forState:UIControlStateNormal];
    if (![self.phoneNum.text isEqualToString:@""] && ![self.pswNum.text isEqualToString:@""]&&![self.codeNum.text isEqualToString:@""]&&self.btn.isSelected) {
        self.signUpBtn.userInteractionEnabled = YES;
        [self.signUpBtn setBackgroundColor:LYColor_A1];
    }else{
        self.signUpBtn.userInteractionEnabled = NO;
        [self.signUpBtn setBackgroundColor:LYColor_A6];
    }
}
//条款
- (void)agreementGesture{
    NSLog(@"条款");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToAgreementVC" object:nil userInfo:nil];
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
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.view bringSubviewToFront:self.backBtn];
    if (textField == self.pswNum)
    {
        if (textField.secureTextEntry)
        {
            [textField insertText:self.pswNum.text];
        }
    }
    if (self.view.frame.origin.y == 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame= CGRectMake(0, -110*HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
            [self.backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(143*HEIGHT);
            }];
            [self.view layoutIfNeeded];
        }];
    }

}
- (void)agreementAction{
    NSLog(@"获取验证码");
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"codeType":@"1", @"mobile":self.phoneNum.text, @"bizType":@"10"}];
    
    [GJAFNetWork POST:URL_ALIANG params:params method:@"getVerifyCode" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];

    self.codeBtn.userInteractionEnabled = NO;
    [self.codeBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    [self.codeNum becomeFirstResponder];
    [self.myTimer fire];

}
- (void)countDown{
    if (self.currentcountDown >0) {
        //设置界面的按钮显示 根据自己需求设置
        self.currentcountDown -= 1;
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.currentcountDown] forState:UIControlStateNormal];
    }else{
        self.currentcountDown = 60;
        [self.myTimer invalidate];
        self.myTimer = nil;
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        if (self.phoneNum.text.length == 11) {
            self.codeBtn.userInteractionEnabled = YES;
            [self.codeBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        }
    }
}
- (void)viewMoveUpAction{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
        
    }];
}
- (void)viewMovedownAction{
    
}
- (void)backBtnAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}









/************LazyLoading*******************/
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
- (UITextField *)codeNum{
    if (!_codeNum) {
        _codeNum = [[UITextField alloc]init];
    }
    return _codeNum;
}
- (UITextField *)pswNum{
    if (!_pswNum) {
        _pswNum = [[UITextField alloc]init];
    }
    return _pswNum;
}
- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _codeBtn;
}
- (NSTimer *)myTimer{
    if (!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
    return _myTimer;
}
- (UIButton *)signUpBtn{
    if (!_signUpBtn) {
        _signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _signUpBtn;
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
