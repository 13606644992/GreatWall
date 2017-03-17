//
//  XiuGaiPayPasswordVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/28.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "XiuGaiPayPasswordVC.h"
#import "Header.h"
#import "SecurityViewController.h"

@interface XiuGaiPayPasswordVC ()
@property (nonatomic,strong) UITextField *miMaTextField;
@property (nonatomic,strong) UITextField *againTextField;

@end

@implementation XiuGaiPayPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    UIButton *queDingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    queDingBtn.backgroundColor = LYColor_A1;
    [queDingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queDingBtn.layer.cornerRadius = 4.0f;
    queDingBtn.clipsToBounds = YES;
    [queDingBtn addTarget:self action:@selector(queDing:) forControlEvents:UIControlEventTouchUpInside];
    [queDingBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:queDingBtn];
    
    [queDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44 *HEIGHT);
    }];
}

#pragma mark - 确定按钮
- (void)queDing:(UIButton *)sender{
    if (self.miMaTextField.text.length < 6 || self.againTextField.text.length < 6 || self.miMaTextField.text.length > 12 || self.againTextField.text.length > 12) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"密码格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (![self.miMaTextField.text isEqualToString:self.againTextField.text]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"两次密码输入不相同" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        if ([self.type isEqualToString:@"0"]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId" ],@"oldPayPwd":self.miMaTextField.text,@"newPayPwd":self.againTextField.text}];
            [GJAFNetWork POST:URL_ALIANG params:dic method:@"modPayPwd" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
                if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"密码修改成功" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        for (UIViewController *controller in self.navigationController.viewControllers) {
                            if ([controller isKindOfClass:[SecurityViewController class]]) {
                                SecurityViewController *vc = (SecurityViewController *)controller;
                                [self.navigationController popToViewController:vc animated:YES];
                            }
                        }
                    }]];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }else if ([self.type isEqualToString:@"1"]){
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId" ],@"payPwd":self.miMaTextField.text,@"smsCode":self.yanZhengMa}];
            NSLog(@"-------smsCode=====%@",self.yanZhengMa);
            [GJAFNetWork POST:URL_ALIANG params:dic method:@"forgetPayPwd" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"忘记支付密码-->修改支付密码====%@",responseObject);
                if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"密码修改成功" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        for (UIViewController *controller in self.navigationController.viewControllers) {
                            if ([controller isKindOfClass:[SecurityViewController class]]) {
                                SecurityViewController *vc = (SecurityViewController *)controller;
                                [self.navigationController popToViewController:vc animated:YES];
                            }
                        }
                    }]];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }
        
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
