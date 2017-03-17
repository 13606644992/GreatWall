//
//  SetPayViewController.m
//  GreatWall
//
//  Created by GJ on 2017/2/27.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "SetPayViewController.h"
#import "Header.h"

@interface SetPayViewController ()

@property (nonatomic, strong) UITextField *miMaTextField;
@property (nonatomic, strong) UITextField *againTextField;
@property (nonatomic, strong) UITextField *yanZhangMaTextField;
@property (nonatomic, strong) UIButton *yanZhengBtn;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, assign) NSInteger currentcountDown;
@property (nonatomic, strong) NSString *smsCode;
@end

@implementation SetPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentcountDown = 60;
    self.navigationItem.title = @"设置支付密码";
    UIImageView *tixingIMG = [[UIImageView alloc]init];
    tixingIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:tixingIMG];
    tixingIMG.image = [UIImage imageNamed:@"tixingfuhao.png"];
    [tixingIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*WIDTH));    }];
    //提醒
    UILabel *tixingLabel = [[UILabel alloc]init];
    tixingLabel.font = [UIFont systemFontOfSize:12.0*HEIGHT];
    tixingLabel.textColor = LYColor_A4;
    NSString *text = @"      为了交易安全，设置支付密码用户交易确认，支付密码由6至12位数字、字母组成，字母区分大小写";
    [self.view addSubview:tixingLabel];
    tixingLabel.numberOfLines = 0;
    [tixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tixingIMG);
        make.top.mas_equalTo(tixingIMG).with.offset(-1.5*HEIGHT);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(36*HEIGHT);
    }];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:7*HEIGHT];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    tixingLabel.attributedText = attributedString;
    
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tixingLabel.mas_bottom).with.offset(12*HEIGHT);
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
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc]init];
        [background addSubview:label];
        label.text = @"支付密码";
        label.font = [UIFont systemFontOfSize:14*HEIGHT];
        label.textColor = LYColor_A3;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.centerY.mas_equalTo(-27.5*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(70*WIDTH, 14*HEIGHT));
        }];
        if (i == 1) {
            [label mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(27.5*HEIGHT);
            }];
            label.text = @"再次输入";
        }
    }
    
    self.miMaTextField = [[UITextField alloc]init];
    self.miMaTextField.placeholder = @"请输入密码";
    self.miMaTextField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    self.miMaTextField.textColor = LYColor_A3;
    [background addSubview:self.miMaTextField];
    
    [self.miMaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120*WIDTH);
        make.centerY.mas_equalTo(background).with.offset(-28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 30 *HEIGHT));
    }];
    
    self.againTextField = [[UITextField alloc]init];
    self.againTextField.textColor = LYColor_A3;
    self.againTextField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    self.againTextField.placeholder = @"请再次输入";
    [background addSubview:self.againTextField];
    
    [self.againTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120*WIDTH);
        make.centerY.mas_equalTo(background).with.offset(28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 30 *HEIGHT));
    }];
    
    UILabel *nextSectionLabel = [[UILabel alloc]init];
    nextSectionLabel.text = @"验证是否为本人操作";
    nextSectionLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    nextSectionLabel.textColor = LYColor_A4;
    [self.view addSubview:nextSectionLabel];
    
    [nextSectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(background.mas_bottom).with.offset(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 14*HEIGHT));
    }];
    
    UIView *nextbackground = [[UIView alloc]init];
    nextbackground.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nextbackground];
    [nextbackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nextSectionLabel.mas_bottom).with.offset(13*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(112*HEIGHT);
    }];
    UIView *nextline = [[UIView alloc]init];
    nextline.backgroundColor = LYColor_A7;
    [nextbackground addSubview:nextline];
    [nextline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(nextbackground);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];

    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc]init];
        [nextbackground addSubview:label];
        label.text = @"手机号";
        label.font = [UIFont systemFontOfSize:14*HEIGHT];
        label.textColor = LYColor_A3;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.centerY.mas_equalTo(-27.5*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(70*WIDTH, 14*HEIGHT));
        }];
        if (i == 1) {
            [label mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(27.5*HEIGHT);
            }];
            label.text = @"验证码";
        }
    }
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    NSString *phoneNum = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_mobile"];
    NSString *string=[phoneNum stringByReplacingOccurrencesOfString:[phoneNum substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    phoneLabel.text = string;
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.textColor = LYColor_A3;
    phoneLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [nextbackground addSubview:phoneLabel];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120*WIDTH);
        make.centerY.mas_equalTo(nextbackground).with.offset(-28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 30 *HEIGHT));

    }];
    
    self.yanZhangMaTextField = [[UITextField alloc]init];
    self.yanZhangMaTextField.placeholder = @"请输入验证码";
    self.yanZhangMaTextField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    self.yanZhangMaTextField.textColor = LYColor_A3;
    self.yanZhangMaTextField.keyboardType = UIKeyboardTypeNumberPad;
    [nextbackground addSubview:self.yanZhangMaTextField];
    [self.yanZhangMaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120*WIDTH);
        make.centerY.mas_equalTo(nextbackground).with.offset(28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 30 *HEIGHT));
    }];
    
    self.yanZhengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yanZhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.yanZhengBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.yanZhengBtn addTarget:self action:@selector(huoQu:) forControlEvents:UIControlEventTouchUpInside];
    [self.yanZhengBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [nextbackground addSubview:self.yanZhengBtn];
    [self.yanZhengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18 * WIDTH);
        make.centerY.mas_equalTo(nextbackground).with.offset(28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(90 * WIDTH, 30 * HEIGHT));
    }];
    [self.yanZhengBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    UIButton *queDingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    queDingBtn.backgroundColor = LYColor_A1;
    [queDingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queDingBtn.layer.cornerRadius = 4.0f;
    queDingBtn.clipsToBounds = YES;
    [queDingBtn addTarget:self action:@selector(queDing:) forControlEvents:UIControlEventTouchUpInside];
    [queDingBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:queDingBtn];
    
    [queDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nextbackground.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44 *HEIGHT);
    }];
}

#pragma mark - 设置登录密码数据请求
- (void)setPayPWD{
    if (![self.miMaTextField.text isEqualToString:self.againTextField.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请输入相同的支付密码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (self.yanZhangMaTextField.text.length  <= 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请输入验证码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (![self.yanZhangMaTextField.text isEqualToString:self.smsCode]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"验证码错误" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":userId,@"payPwd":self.miMaTextField.text,@"smsCode":self.yanZhangMaTextField.text}];
        [GJAFNetWork POST:URL_ALIANG params:dic method:@"setPayPwd" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
                NSLog(@"=======设置支付密码成功");
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"GJ_paymentPwd"];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"设置支付密码成功" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }]];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    
}
#pragma mark - 获取验证码
- (void)huoQu:(UIButton *)sender{
    NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_mobile"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"codeType":@"1", @"mobile":string, @"bizType":@"14"}];
    
    [GJAFNetWork POST:URL_ALIANG params:params method:@"getVerifyCode" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            NSLog(@"成功%@", responseObject);
            self.smsCode = responseObject[@"output"][@"smsCode"];
        }
        NSLog(@"%@", responseObject[@"respMsg"]);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"错误%@", error);
    }];
    
    self.yanZhengBtn.userInteractionEnabled = NO;
    [self.yanZhengBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    [self.yanZhangMaTextField becomeFirstResponder];
    [self.myTimer fire];
    
    
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

- (NSTimer *)myTimer{
    if (!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
    return _myTimer;
}
#pragma mark - 确定按钮
- (void)queDing:(UIButton *)sender{
    [self setPayPWD];
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
