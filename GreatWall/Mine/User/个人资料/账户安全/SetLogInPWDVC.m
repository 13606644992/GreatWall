//
//  SetLogInPWDVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/28.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "SetLogInPWDVC.h"
#import "Header.h"

@interface SetLogInPWDVC ()
@property (nonatomic,strong) UITextField *miMaTextField;
@property (nonatomic,strong) UIButton *imageBtn;
@end

@implementation SetLogInPWDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置登录密码";
    UIImageView *tishiIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tixingfuhao.png"]];
    tishiIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:tishiIMG];
    [tishiIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*HEIGHT));
    }];
    
    
    UILabel *myLabel = [[UILabel alloc]init];
    myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    myLabel.textColor = LYColor_A4;
    myLabel.text = @"设置登录密码后，您可以使用手机号+密码登录，请牢记";
    [self.view addSubview:myLabel];
    [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tishiIMG.mas_right).with.offset(11*WIDTH);
        make.centerY.mas_equalTo(tishiIMG);
        make.height.mas_equalTo(13*HEIGHT);
    }];
    [myLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myLabel.mas_bottom).with.offset(12*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(56*HEIGHT);
    }];
    
    self.miMaTextField = [[UITextField alloc]init];
    self.miMaTextField.placeholder = @"密码（6-20位数字、字母组合）";
    self.miMaTextField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    self.miMaTextField.textColor = LYColor_A3;
    [background addSubview:self.miMaTextField];
    
    [self.miMaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(230*WIDTH, 30 *HEIGHT));
    }];
    
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageBtn setImage:[UIImage imageNamed:@"mimakejian"] forState:UIControlStateNormal];
    [self.imageBtn addTarget:self action:@selector(yinCang:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:self.imageBtn];
    
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13*WIDTH);
        make.centerY.mas_equalTo(self.miMaTextField);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 30*HEIGHT));
        
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

- (void)yinCang:(UIButton *)sender{
    sender.selected = !sender.selected;
    UIImage *image = sender.isSelected ? [UIImage imageNamed:@"mimabukejian.png"] : [UIImage imageNamed:@"mimakejian.png"];
    [sender setImage:image forState:UIControlStateNormal];
    self.miMaTextField.secureTextEntry = !self.miMaTextField.secureTextEntry;
    NSString *text = self.miMaTextField.text;
    self.miMaTextField.text = @" ";
    self.miMaTextField.text = text;
    
    if (self.miMaTextField.secureTextEntry)
    {
        [self.miMaTextField insertText:self.miMaTextField.text];
    }
    
}

- (void)queDing:(UIButton *)sender{
    if (self.miMaTextField.text.length > 5 && self.miMaTextField.text.length < 21) {
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"];
        NSString *loginType = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_loginType"];
        NSString *type = [loginType isEqualToString:@"0"] ? @"1" : @"2";
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : userId, @"newPwd": self.miMaTextField.text, @"resetType" : type}];
        NSLog(@"%@",dic);
        [GJAFNetWork POST:URL_ALIANG params:dic method:@"resetLoginPwd" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@", responseObject);
//            NSLog(@"%@", responseObject[@"respMsg"]);
            if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"GJ_loginType"];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"设置密码成功" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
    
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"fail==%@",error);
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请按照格式要求设置密码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
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
