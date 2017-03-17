//
//  FindPswViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/28.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "FindPswViewController.h"
#import "Header.h"
#import "ResetPswViewController.h"
@interface FindPswViewController ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong, nonnull)UITextField *phoneNum;
@property (nonatomic, strong, nonnull)UITextField *codeNum;
@property (nonatomic, strong, nonnull)UIButton *codeBtn;
@property (nonatomic, strong)NSTimer *myTimer;
@property (nonatomic, assign)NSInteger currentcountDown;
@property (nonatomic, strong, nonnull)UIButton *nextBtn;

@end

@implementation FindPswViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;//隐藏导航栏
    StatusBarBlack;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if (self.currentcountDown != 10 || self.currentcountDown != 0) {
        [self.myTimer invalidate];
        self.myTimer = nil;
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = YES;
        self.currentcountDown = 60;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentcountDown = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(33*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(25*WIDTH, 22*HEIGHT));
    }];
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *findPswLabel = [[UILabel alloc]init];
    findPswLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:findPswLabel];
    [findPswLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backBtn.mas_bottom).with.offset(23*HEIGHT);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, HEIGHT*19));
    }];
    findPswLabel.text = @"找回密码";
    findPswLabel.font = [UIFont systemFontOfSize:19*WIDTH];
    findPswLabel.textColor = LYColor_A3;
    findPswLabel.textAlignment = NSTextAlignmentCenter;
    
    //背景
    self.backgroundView = [[UIView alloc]init];
    [self.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(findPswLabel.mas_bottom).with.offset(34*HEIGHT);
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
        make.height.mas_equalTo(0.5);
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
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 13*HEIGHT));
    }];
    [self.codeBtn addTarget:self action:@selector(agreementAction) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn.userInteractionEnabled = NO;
    //下一步按钮
    [self.view addSubview:self.nextBtn];
    self.nextBtn.backgroundColor = LYColor_A6;
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = 4.0f;
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.backgroundView.mas_bottom).with.offset(32 * HEIGHT);
        make.width.mas_equalTo(self.backgroundView);
        make.height.mas_equalTo(44*HEIGHT);
    }];
    [self.nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.userInteractionEnabled = NO;

    //监听输入框
    [self.phoneNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    [self.codeNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldDidChange:(UITextField *) TextField{
    if ((self.phoneNum.text.length == 11) && ![self.codeNum.text isEqualToString:@""]) {
        self.nextBtn.userInteractionEnabled = YES;
        [self.nextBtn setBackgroundColor:LYColor_A1];
    }else{
        self.nextBtn.userInteractionEnabled = NO;
        [self.nextBtn setBackgroundColor:LYColor_A6];
    }
    //改变按钮可点击
    self.codeBtn.userInteractionEnabled = self.phoneNum.text.length == 11 ? YES : NO;
    //改变按钮文字颜色
    UIColor *titleColor = self.codeBtn.userInteractionEnabled ?  LYColor_A1 : LYColor_A5;
    [self.codeBtn setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.codeNum resignFirstResponder];
    [self.phoneNum resignFirstResponder];
}
- (void)nextAction:(UIButton *)sender{
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"codeType":@"1", @"mobile":self.phoneNum.text, @"bizType":@"12"}];
//    
//    [GJAFNetWork POST:URL_TEST params:params method:@"getVerifyCode" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"成功%@", responseObject);
//        NSLog(@"%@", responseObject[@"respMsg"]);
//        
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        
//    }];
    ResetPswViewController *resetPswVC = [[ResetPswViewController alloc]init];
    resetPswVC.smsCode = self.codeNum.text;
    resetPswVC.phoneStr = self.phoneNum.text;
    [self.navigationController pushViewController:resetPswVC animated:YES];
}
- (void)agreementAction{
    NSLog(@"获取验证码");
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"codeType":@"1", @"mobile":self.phoneNum.text, @"bizType":@"12"}];
    
    [GJAFNetWork POST:URL_ALIANG params:params method:@"getVerifyCode" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];

    [self.codeBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    [self.codeNum becomeFirstResponder];
    self.codeBtn.userInteractionEnabled = NO;
    [self.myTimer fire];
}
- (void)countDown{
    if (self.currentcountDown >0) {
        //设置界面的按钮显示 根据自己需求设置
        NSLog(@"%ld", (long)self.currentcountDown);
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
- (void)backBtnAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];

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
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _nextBtn;
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
