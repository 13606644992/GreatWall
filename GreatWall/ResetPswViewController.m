//
//  ResetPswViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/28.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "ResetPswViewController.h"
#import "Header.h"
#import "PswLoginViewController.h"
@interface ResetPswViewController ()
@property (nonatomic, strong)UITextField *pswNum;
@property (nonatomic, strong)UIButton *finishBtn;
@end

@implementation ResetPswViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    StatusBarBlack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    UILabel *resetPswLabel = [[UILabel alloc]init];
    resetPswLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:resetPswLabel];
    [resetPswLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backBtn.mas_bottom).with.offset(23*HEIGHT);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, HEIGHT*19));
    }];
    resetPswLabel.text = @"重置密码";
    resetPswLabel.font = [UIFont systemFontOfSize:19*WIDTH];
    resetPswLabel.textColor = LYColor_A3;
    resetPswLabel.textAlignment = NSTextAlignmentCenter;
    //背景
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    background.layer.cornerRadius = 4.0;
    background.layer.borderWidth = 1.0;
    background.layer.borderColor = LYColor_A6.CGColor;
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(resetPswLabel.mas_bottom).with.offset(64*HEIGHT);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(56*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
    }];
    //密码icon
    UIImageView *pswIMG = [[UIImageView alloc]init];
    [background addSubview:pswIMG];
    pswIMG.backgroundColor = [UIColor whiteColor];
    pswIMG.image = [UIImage imageNamed:@"mimasuo.png"];
    [pswIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(13*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
    }];
    pswIMG.contentMode = UIViewContentModeScaleAspectFit;
    //密码
    [background addSubview:self.pswNum];
    self.pswNum.backgroundColor = [UIColor whiteColor];
    self.pswNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswNum.font = [UIFont systemFontOfSize:14*WIDTH];
    self.pswNum.textColor = LYColor_A3;
    [self.pswNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pswIMG.mas_right).with.offset(11*WIDTH);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(250*WIDTH);
        make.height.mas_equalTo(30*HEIGHT);
    }];
    self.pswNum.delegate = self;
    
    NSString *holderText = @"请输入新密码 (6-20位数字、字母组合)";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName value:LYColor_A5 range:NSMakeRange(6, holderText.length - 6)];
    [placeholder addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11*WIDTH]range:NSMakeRange(6, holderText.length - 6)];
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
    //完成按钮
    [self.view addSubview:self.finishBtn];
    self.finishBtn.backgroundColor = LYColor_A6;
    [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.finishBtn.layer.cornerRadius = 4.0f;
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(background.mas_bottom).with.offset(32 * HEIGHT);
        make.width.mas_equalTo(background);
        make.height.mas_equalTo(44*HEIGHT);
    }];
    [self.finishBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.finishBtn.userInteractionEnabled = NO;
    //监听输入框
    [self.pswNum addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    

}
- (void)textFieldDidChange:(UITextField *)textField{
    if (self.pswNum.text.length > 5 &&  self.pswNum.text.length < 21) {
        [self.finishBtn setBackgroundColor:LYColor_A1];
        self.finishBtn.userInteractionEnabled = YES;
    }else{
        [self.finishBtn setBackgroundColor:LYColor_A6];
        self.finishBtn.userInteractionEnabled = NO;
    }
}
- (void)finishBtnAction:(UIButton *)sender{
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"mobile":self.phoneStr, @"newPwd":self.pswNum.text, @"resetType":@"2",@"smsCode":self.smsCode}];
    
        [GJAFNetWork POST:URL_ALIANG params:params method:@"forgetLoginPwd" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"成功%@", responseObject);
            NSLog(@"%@", responseObject[@"respMsg"]);
    
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
    
            
        }];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[PswLoginViewController class]]) {
            PswLoginViewController *pswVC =(PswLoginViewController *)controller;
            [self.navigationController popToViewController:pswVC animated:YES];
        }
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
//限制输入长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.pswNum) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 20 && range.length!=1){
            textField.text = [toBeString substringToIndex:20];
            return NO;
        }
    }
    
    return YES;
}
- (void)backBtnAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.pswNum resignFirstResponder];
}

- (UITextField *)pswNum{
    if (!_pswNum) {
        _pswNum = [[UITextField alloc]init];
    }
    return _pswNum;
}
- (UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _finishBtn;
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
