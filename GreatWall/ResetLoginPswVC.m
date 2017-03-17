//
//  ResetLoginPswVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/21.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ResetLoginPswVC.h"
#import "Header.h"
@interface ResetLoginPswVC ()
@property (nonatomic, assign) NSInteger currentcountDown;
@property (nonatomic, strong) NSTimer *myTimer;
@end

@implementation ResetLoginPswVC
{
    UITextField *yanZMTextField;
    UITextField *miMaTextField;
    UIButton *yanZhengBtn;
    UIButton *imageBtn;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    StatusBarBlack;
}

- (NSTimer *)myTimer{
    if (!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
    return _myTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改密码";
    UIImageView *tishiIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tixingfuhao.png"]];
    tishiIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:tishiIMG];
    [tishiIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*HEIGHT));
    }];
    
    NSString *phoneNum = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_mobile"];
    NSString *string=[phoneNum stringByReplacingOccurrencesOfString:[phoneNum substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    UILabel *myLabel = [[UILabel alloc]init];
    myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    myLabel.textColor = LYColor_A4;
    myLabel.text = [NSString stringWithFormat:@"验证码将发送到已绑定手机%@", string];
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
    
    
    yanZMTextField = [[UITextField alloc]init];
    yanZMTextField.placeholder = @"请输入验证码";
    yanZMTextField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    yanZMTextField.textColor = LYColor_A3;
    yanZMTextField.keyboardType = UIKeyboardTypeNumberPad;
    [background addSubview:yanZMTextField];
    
    [yanZMTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18 * WIDTH);
        make.centerY.mas_equalTo(background).with.offset(-28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 30 *HEIGHT));
    }];
    
    miMaTextField = [[UITextField alloc]init];
    miMaTextField.textColor = LYColor_A3;
    miMaTextField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    miMaTextField.placeholder = @"新密码（6-20位数字、字母组合）";
    [background addSubview:miMaTextField];
    
    [miMaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18 * WIDTH);
        make.centerY.mas_equalTo(background).with.offset(28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 30 *HEIGHT));
    }];
    
    yanZhengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [yanZhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    yanZhengBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [yanZhengBtn addTarget:self action:@selector(huoQu:) forControlEvents:UIControlEventTouchUpInside];
    [yanZhengBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [background addSubview:yanZhengBtn];
    [yanZhengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18 * WIDTH);
        make.centerY.mas_equalTo(background).with.offset(-28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(90 * WIDTH, 30 * HEIGHT));
    }];
    [yanZhengBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setImage:[UIImage imageNamed:@"mimakejian"] forState:UIControlStateNormal];
    [imageBtn addTarget:self action:@selector(yinCang:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:imageBtn];
    
    [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13*WIDTH);
        make.centerY.mas_equalTo(miMaTextField);
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
    
    self.currentcountDown = 60;
}
- (void)huoQu:(UIButton *)sender{
    NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_mobile"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"codeType":@"1", @"mobile":string, @"bizType":@"12"}];
    
    [GJAFNetWork POST:URL_ALIANG params:params method:@"getVerifyCode" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"错误%@", error);
    }];
    
    yanZhengBtn.userInteractionEnabled = NO;
    [yanZhengBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    [yanZhengBtn becomeFirstResponder];
    [self.myTimer fire];
    [yanZMTextField becomeFirstResponder];

}

- (void)countDown{
    if (self.currentcountDown >0) {
        //设置界面的按钮显示 根据自己需求设置
        self.currentcountDown -= 1;
        [yanZhengBtn setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.currentcountDown] forState:UIControlStateNormal];
    }else{
        self.currentcountDown = 60;
        [self.myTimer invalidate];
        self.myTimer = nil;
        [yanZhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            yanZhengBtn.userInteractionEnabled = YES;
            [yanZhengBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        }

}


- (void)yinCang:(UIButton *)sender{
    sender.selected = !sender.selected;
    UIImage *image = sender.isSelected ? [UIImage imageNamed:@"mimabukejian.png"] : [UIImage imageNamed:@"mimakejian.png"];
    [sender setImage:image forState:UIControlStateNormal];
    miMaTextField.secureTextEntry = !miMaTextField.secureTextEntry;
    NSString *text = miMaTextField.text;
    miMaTextField.text = @" ";
    miMaTextField.text = text;
    
    if (miMaTextField.secureTextEntry)
    {
        [miMaTextField insertText:miMaTextField.text];
    }

}

- (void)queDing:(UIButton *)sender{
    [miMaTextField resignFirstResponder];
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"];
    NSString *loginType = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_loginType"];
    NSString *type = [loginType isEqualToString:@"0"] ? @"1" : @"2";
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : userId, @"newPwd": miMaTextField.text, @"resetType" : type,@"smsCode" : yanZMTextField.text}];
    NSLog(@"%@",dic);
    
    
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"resetLoginPwd" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            
            [DataGreatWall PostUpToBWithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
               
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"fail==%@",error);
    }];
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
