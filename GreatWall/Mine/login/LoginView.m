//
//  loginView.m
//  GreatWall
//
//  Created by GJ on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "LoginView.h"
#import "Header.h"
#import "LYColor.h"
@implementation LoginView
{
    BOOL isUp;
    NSString *smsCode;
}

/*
// Only override drawRect: if you perform custom drawing.
// An emptynonatomic,  implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)init{
    self = [super init];
    if (self) {
        [self creatSubView];
    }
    return self;
}
- (void)creatSubView{

    self.currentcountDown = 60;
 // logo
    self.logoIMGView.frame = CGRectMake(0, 0, 78*WIDTH, 78*HEIGHT);
    self.logoIMGView.center = CGPointMake(375/2*WIDTH, 120*HEIGHT);
    [self addSubview:self.logoIMGView];

    self.logoIMGView.backgroundColor = [UIColor whiteColor];
    self.logoIMGView.contentMode = UIViewContentModeScaleAspectFit;
    self.logoIMGView.image = [UIImage imageNamed:@"logo.png"];
    //"汇保险"
    [self addSubview:self.titleIMGView];
    [self.titleIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.logoIMGView);
        make.top.mas_equalTo(self.logoIMGView.mas_bottom).with.offset(11*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(77*WIDTH, 34*HEIGHT));
    }];
    self.titleIMGView.backgroundColor = [UIColor whiteColor];
    self.titleIMGView.image = [UIImage imageNamed:@"huibaoxian.png"];
    
    //背景
    self.backgroundView = [[UIView alloc]init];
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleIMGView.mas_bottom).with.offset(32*HEIGHT);
        make.centerX.mas_equalTo(self.mas_centerX);
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
    [self addSubview:line];
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
    //验证码icon
    UIImageView *codeIMG = [[UIImageView alloc]init];
    [self.backgroundView addSubview:codeIMG];
    [codeIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneIMG);
        make.centerY.mas_equalTo(27.5*HEIGHT);
        make.size.mas_equalTo(phoneIMG);
    }];
    codeIMG.backgroundColor = [UIColor whiteColor];
    codeIMG.image = [UIImage imageNamed:@"yanzhengma.png"];
    codeIMG.contentMode = UIViewContentModeScaleAspectFit;
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
        //验证码
    [self.backgroundView addSubview:self.codeNum];
    self.codeNum.backgroundColor = [UIColor whiteColor];
    self.codeNum.placeholder = @"请输入验证码";
    self.codeNum.keyboardType = UIKeyboardTypeNumberPad;
    self.codeNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeNum.font = [UIFont systemFontOfSize:14*WIDTH];
    self.codeNum.textColor = LYColor_A3;
    [self.codeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneNum);
        make.centerY.mas_equalTo(codeIMG);
        make.width.mas_equalTo(200*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
    }];
    self.codeNum.delegate = self;

        //验证码按钮
        self.codeBtn.backgroundColor = [UIColor whiteColor];
        [self.backgroundView addSubview:self.codeBtn];
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];

        [self.codeBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
        [self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*WIDTH];
        [self.codeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.codeNum);
            make.right.mas_equalTo(-13*WIDTH);
            make.size.mas_equalTo(CGSizeMake(80*WIDTH, 30*HEIGHT));
        }];
        [self.codeBtn addTarget:self action:@selector(agreementAction) forControlEvents:UIControlEventTouchUpInside];
       self.codeBtn.userInteractionEnabled = NO;

    //阅读状态按钮
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setImage:[UIImage imageNamed:@"gouxuan.png"] forState:UIControlStateNormal];
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView);
        make.top.equalTo(self.backgroundView.mas_bottom).with.offset(21 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(20 * WIDTH, 20 * HEIGHT));
    }];
    [self.btn addTarget:self action:@selector(agreebtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.btn.selected = YES;
    //条款
    UILabel *agreement = [[UILabel alloc]init];
    [self addSubview:agreement];
    agreement.backgroundColor = [UIColor whiteColor];
    agreement.text = @"已阅读并同意《汇保险注册协议》";
    agreement.font = [UIFont fontWithName:@"applegothic" size:11.0 * WIDTH];
    agreement.textColor = [UIColor darkGrayColor];
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
    //登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.loginBtn];
    self.loginBtn.backgroundColor = LYColor_A6;
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 4.0f;
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.backgroundView.mas_bottom).with.offset(64 * HEIGHT);
        make.width.mas_equalTo(self.backgroundView);
        make.height.mas_equalTo(44*HEIGHT);
    }];
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.userInteractionEnabled = NO;
    //分隔竖线"丨"
    UILabel *line_shu = [[UILabel alloc]init];
    line_shu.backgroundColor = LYColor_A6;
    [self addSubview:line_shu];
    [line_shu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(16 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(1, 12 * HEIGHT));
    }];
    //密码登录
    UIButton *pswBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [self addSubview:pswBtn];
    pswBtn.backgroundColor = [UIColor whiteColor];
    [pswBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [pswBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
    [pswBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    pswBtn.titleLabel.font = [UIFont systemFontOfSize:12.0 * WIDTH];
    [pswBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [pswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line_shu.mas_left).with.offset(-15 * WIDTH);
        make.centerY.equalTo(line_shu.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100 * WIDTH, 30 * HEIGHT));
        
    }];
    [pswBtn addTarget:self action:@selector(pswAction:) forControlEvents:UIControlEventTouchUpInside];
    //注册
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:signUpBtn];
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
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(35*WIDTH, 35*HEIGHT));
    }];
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn setImage:[UIImage imageNamed:@"guanbi.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //监听输入框
    [self.phoneNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    [self.codeNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    //其他登录方式
    UILabel *line_first = [[UILabel alloc]init];
    [self addSubview:line_first];
    [line_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pswBtn.mas_bottom).with.offset(63*HEIGHT);
        make.left.mas_equalTo(self.loginBtn);
        make.size.mas_equalTo(CGSizeMake(125*WIDTH, 1));
    }];
    line_first.backgroundColor = LYColor_A6;
    UILabel *line_second = [[UILabel alloc]init];
    [self addSubview:line_second];
    [line_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pswBtn.mas_bottom).with.offset(63*HEIGHT);
        make.right.mas_equalTo(self.loginBtn);
        make.size.mas_equalTo(CGSizeMake(125*WIDTH, 1));
    }];
    line_second.backgroundColor = LYColor_A6;
    UILabel *other = [[UILabel alloc]init];
    other.text = @"其他登录方式";
    [self addSubview:other];
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
    [self addSubview:wxLoginBtn];
    [wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.loginBtn);
        make.top.mas_equalTo(other.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(44*WIDTH, 44*HEIGHT));
    }];
    [wxLoginBtn setBackgroundImage:[UIImage imageNamed:@"weixin.png"] forState:UIControlStateNormal];
    wxLoginBtn.contentMode = UIViewContentModeScaleAspectFit;
    [wxLoginBtn addTarget:self action:@selector(weixinLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    //初始状态
    isUp = NO;
}
- (void)weixinLoginAction:(UIButton *)sender{
    NSLog(@"微信登录");
}
//监听输入框
- (void)textFieldDidChange:(UITextField *) TextField{
    if ((self.phoneNum.text.length == 11) && ![self.codeNum.text isEqualToString:@""] && self.btn.isSelected) {
        self.loginBtn.userInteractionEnabled = YES;
        [self.loginBtn setBackgroundColor:LYColor_A1];
    }else{
        self.loginBtn.userInteractionEnabled = NO;
        [self.loginBtn setBackgroundColor:LYColor_A6];
    }
   //改变按钮可点击
    self.codeBtn.userInteractionEnabled = self.phoneNum.text.length == 11 ? YES : NO;
    //改变按钮文字颜色
    UIColor *titleColor = self.codeBtn.userInteractionEnabled ?  LYColor_A1 : LYColor_A5;
    [self.codeBtn setTitleColor:titleColor forState:UIControlStateNormal];
}
//立即登录
- (void)loginAction:(UIButton *)sender{
    NSLog(@"立即登录");
    [self.phoneNum resignFirstResponder];
    [self.codeNum resignFirstResponder];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userName":self.phoneNum.text, @"loginType":@"2", @"smsCode" : self.codeNum.text}];
    NSLog(@"params = %@", params);
   [GJAFNetWork POST:URL_ALIANG params:params method:@"login" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
       
       NSLog(@"登录结果 = %@", responseObject);
       NSLog(@"%@", responseObject[@"respMsg"]);
       if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
           NSDictionary *output = responseObject[@"output"];
           NSLog(@"%@", output);
           /**********************************保存用户信息********************************/
           /*********************************************************************************/
           [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"GJ_isLogin"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"userId"] forKey:@"GJ_userId"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"sessionId"] forKey:@"GJ_sessionId"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"mobile"] forKey:@"GJ_mobile"];
           BOOL isBClient = [output[@"isBClient"] isEqualToString:@"ture"] ? YES : NO;
           [[NSUserDefaults standardUserDefaults]setBool:isBClient forKey:@"GJ_isBClient"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"userName"] forKey:@"GJ_userName"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"realName"] forKey:@"GJ_realName"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"nickName"] forKey:@"GJ_nickName"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"logo"] forKey:@"GJ_headURL"];
           NSString *gender = [output[@"gender"] isEqualToString:@"0"] ? @"男" : @"女";
           [[NSUserDefaults standardUserDefaults]setObject:gender forKey:@"GJ_gender"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"email"] forKey:@"GJ_email"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"loginPwd"] forKey:@"GJ_loginType"];
           [[NSUserDefaults standardUserDefaults]setObject:output[@"paymentPwd"] forKey:@"GJ_paymentPwd"];
           [[NSUserDefaults standardUserDefaults]synchronize];
           /*********************************************************************************/
           /*********************************************************************************/
           [[NSNotificationCenter defaultCenter]postNotificationName:@"resetData" object:nil];
           [[NSNotificationCenter defaultCenter]postNotificationName:@"backToUserView" object:nil userInfo:nil];//返回用户界面
       }
   } fail:^(NSURLSessionDataTask *task, NSError *error) {
       NSLog(@"%@", error);
   }];
}
//注册
- (void)signUpAction:(UIButton *)sender{
    NSLog(@"我要注册");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToSignUpVC" object:nil userInfo:nil];
}
//密码登录
- (void)pswAction:(UIButton *)sender{
    NSLog(@"密码登录");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToPswLoginVC" object:nil userInfo:nil];
}
//获取验证码
- (void)agreementAction{
    NSLog(@"获取验证码");
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"codeType":@"1", @"mobile":self.phoneNum.text, @"bizType":@"11"}];

    [GJAFNetWork POST:URL_ALIANG params:params method:@"getVerifyCode" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        
               NSLog(@"%@", responseObject[@"respMsg"]);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSLog(@"成功%@", responseObject);
            smsCode = responseObject[@"output"][@"smsCode"];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"错误%@", error);
    }];
    
    self.codeBtn.userInteractionEnabled = NO;
     [self.codeBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    [self.codeNum becomeFirstResponder];
    [self.myTimer fire];
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (NSString*) md5HexDigest:(NSString*)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

//btn点击事件
- (void)agreebtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    //点击改变
    UIImage *image = sender.isSelected ? [UIImage imageNamed:@"gouxuan.png"] : [UIImage imageNamed:@"Rectanglearrondi16copie.png"];
    [sender setImage:image forState:UIControlStateNormal];
    if (![self.phoneNum.text isEqualToString:@""] && ![self.codeNum.text isEqualToString:@""] && sender.isSelected) {
        self.loginBtn.userInteractionEnabled = YES;
        [self.loginBtn setBackgroundColor:LYColor_A1];
    }else{
        self.loginBtn.userInteractionEnabled = NO;
        [self.loginBtn setBackgroundColor:LYColor_A6];
    }

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
    return YES;
}
//条款
- (void)agreementGesture{
    NSLog(@"条款");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToAgreementVC" object:nil userInfo:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.codeNum resignFirstResponder];
    [self.phoneNum resignFirstResponder];
    [self changeToBig];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self changeToSmall];
}


- (void)changeToSmall{
    if (!isUp) {
        [UIView animateWithDuration:0.3 animations:^{
            self.logoIMGView.frame = CGRectMake(0, 0, 25*WIDTH, 25*HEIGHT);
            self.logoIMGView.center = CGPointMake(375/2*WIDTH, 72.5*HEIGHT);
            self.logoIMGView.transform = CGAffineTransformMakeRotation(M_PI);
            
            [self.titleIMGView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.logoIMGView.mas_bottom).with.offset(4*HEIGHT);
                make.size.mas_equalTo(CGSizeMake(25*WIDTH, 11*HEIGHT));
            }];
            [self layoutIfNeeded];
        }];
        isUp = YES;
    }
}
- (void)changeToBig{
    if (isUp) {
        [UIView animateWithDuration:0.3 animations:^{
            self.logoIMGView.frame = CGRectMake(0, 0, 78*WIDTH, 78*HEIGHT);
            self.logoIMGView.center = CGPointMake(375/2*WIDTH, 120*HEIGHT);
            self.logoIMGView.transform = CGAffineTransformMakeRotation(0);
            
            [self.titleIMGView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.logoIMGView.mas_bottom).with.offset(11*HEIGHT);
                make.size.mas_equalTo(CGSizeMake(77*WIDTH, 34*HEIGHT));
            }];
            [self layoutIfNeeded];
        }];
        isUp = NO;
    }

}
//返回按钮
- (void)backBtnAction:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"popBack" object:nil];

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

/*                    LazyLoading............             */

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
- (UITextField *)codeNum{
    if (!_codeNum) {
        _codeNum = [[UITextField alloc]init];
    }
    return _codeNum;
}
- (NSTimer *)myTimer{
    if (!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
    return _myTimer;
}
- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _codeBtn;
}
//- (UILabel *)timeLabel{
//    if (!_timeLabel) {
//        _timeLabel = [[UILabel alloc]init];
//    }
//    return _timeLabel;
//}
@end
