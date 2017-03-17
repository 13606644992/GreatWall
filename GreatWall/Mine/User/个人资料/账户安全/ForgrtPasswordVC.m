//
//  ForgrtPasswordVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/28.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ForgrtPasswordVC.h"
#import "Header.h"
#import "XiuGaiPayPasswordVC.h"

@interface ForgrtPasswordVC ()
@property (nonatomic, strong) UITextField *yanZhangMaTextField;
@property (nonatomic, strong) UIButton *yanZhengBtn;
@property (nonatomic, assign) NSInteger currentcountDown;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) NSString *smsCode;

@end

@implementation ForgrtPasswordVC

- (NSTimer *)myTimer{
    if (!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
    return _myTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentcountDown = 60;
    self.navigationItem.title = @"身份验证";
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(18*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(112*HEIGHT);
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LYColor_A7;
    [background addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(background);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    NSString *phoneNum = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_mobile"];
    NSString *string=[phoneNum stringByReplacingOccurrencesOfString:[phoneNum substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    phoneLabel.text = string;
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.textColor = LYColor_A3;
    phoneLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background addSubview:phoneLabel];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(background).with.offset(-28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 30 *HEIGHT));
        
    }];
    
    self.yanZhengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yanZhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.yanZhengBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.yanZhengBtn addTarget:self action:@selector(huoQu:) forControlEvents:UIControlEventTouchUpInside];
    [self.yanZhengBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [background addSubview:self.yanZhengBtn];
    [self.yanZhengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18 * WIDTH);
        make.centerY.mas_equalTo(background).with.offset(-28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(90 * WIDTH, 30 * HEIGHT));
    }];
    [self.yanZhengBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    self.yanZhangMaTextField = [[UITextField alloc]init];
    self.yanZhangMaTextField.placeholder = @"验证码";
    self.yanZhangMaTextField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    self.yanZhangMaTextField.textColor = LYColor_A3;
    self.yanZhangMaTextField.keyboardType = UIKeyboardTypeNumberPad;
    [background addSubview:self.yanZhangMaTextField];
    [self.yanZhangMaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(background).with.offset(28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 30 *HEIGHT));
    }];
    
    UIButton *queDingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    queDingBtn.backgroundColor = LYColor_A1;
    [queDingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queDingBtn.layer.cornerRadius = 4.0f;
    queDingBtn.clipsToBounds = YES;
    [queDingBtn addTarget:self action:@selector(xiaYiBu:) forControlEvents:UIControlEventTouchUpInside];
    [queDingBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:queDingBtn];
    
    [queDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44 *HEIGHT);
    }];

}

#pragma mark - 获取验证码
- (void)huoQu:(UIButton *)sender{
    NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_mobile"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"codeType":@"1", @"mobile":string, @"bizType":@"12"}];
    
    [GJAFNetWork POST:URL_ALIANG params:params method:@"getVerifyCode" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            NSLog(@"获取验证码成功");
            self.smsCode = responseObject[@"output"][@"smsCode"];
        }
        NSLog(@"成功%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"错误%@", error);
    }];
    
    self.yanZhengBtn.userInteractionEnabled = NO;
    [self.yanZhengBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    [self.yanZhengBtn becomeFirstResponder];
    [self.myTimer fire];
    [self.yanZhangMaTextField becomeFirstResponder];
    
}

- (void)countDown{
    if (self.currentcountDown >0) {
        //设置界面的按钮显示 根据自己需求设置
        self.currentcountDown -= 1;
        [self.yanZhengBtn setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.currentcountDown] forState:UIControlStateNormal];
    }else{
        self.currentcountDown = 60;
        [self.myTimer invalidate];
        self.myTimer = nil;
        [self.yanZhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.yanZhengBtn.userInteractionEnabled = YES;
        [self.yanZhengBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    }
    
}

- (void)xiaYiBu:(UIButton *)sender{
    if (self.yanZhangMaTextField.text <= 0 || ![self.yanZhangMaTextField.text isEqualToString:self.smsCode]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请输入正确的验证码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        XiuGaiPayPasswordVC *vc = [[XiuGaiPayPasswordVC alloc]init];
        vc.yanZhengMa = self.smsCode;
        vc.type = @"1";
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
