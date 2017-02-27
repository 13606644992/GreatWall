//
//  ZhiFuMimaViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ZhiFuMimaViewController.h"
#import "Header.h"
#import "TiXianViewController.h"
@interface ZhiFuMimaViewController ()
@property (nonatomic, strong)UITextField *pswCode;
@property (nonatomic, strong)UITextField *inputAgain;
@property (nonatomic, strong)UITextField *phoneNum;
@property (nonatomic, strong)UITextField *codeNum;
@property (nonatomic, strong)UIButton *codeBtn;
@property (nonatomic, strong)UIButton *confirmBtn;
@end

@implementation ZhiFuMimaViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置支付密码";
   self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    UILabel *tixingLabel = [[UILabel alloc]init];
    tixingLabel.font = [UIFont systemFontOfSize:12.0*WIDTH];
    tixingLabel.backgroundColor = LYColor_A7;
    tixingLabel.textColor = LYColor_A4;
    NSString *text = @"      为了交易安全，设置支付密码用户交易确认，支付密码由6至12位数字、字母组成，字母区分大小写。";
    [self.view addSubview:tixingLabel];
    tixingLabel.numberOfLines = 0;
    [tixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(18*HEIGHT);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(36*HEIGHT);
    }];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:7*HEIGHT];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    tixingLabel.attributedText = attributedString;
    
    
    UIImageView *tixing = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tixingfuhao.png"]];
    tixing.backgroundColor = LYColor_A7;
    [self.view addSubview:tixing];
    [tixing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*WIDTH));
    }];
    //支付密码  再次输入
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tixingLabel.mas_bottom).with.offset(12*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(110*HEIGHT);
    }];
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = LYColor_A7;
    [background addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54.5*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    UILabel *zhifumima = [[UILabel alloc]init];
    zhifumima.text = @"支付密码";
    zhifumima.textColor = LYColor_A4;
    zhifumima.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background addSubview:zhifumima];
    [zhifumima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.centerY.mas_equalTo(-27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];
    UILabel *zaicishuruLabel = [[UILabel alloc]init];
    zaicishuruLabel.text = @"再次输入";
    zaicishuruLabel.textColor = LYColor_A4;
    zaicishuruLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background addSubview:zaicishuruLabel];
    [zaicishuruLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.centerY.mas_equalTo(27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];

    UIView *background2 = [[UIView alloc]init];
    background2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background2];
    [background2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(13*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(110*HEIGHT);
    }];
    UILabel *line2 = [[UILabel alloc]init];
    line2.backgroundColor = LYColor_A7;
    [background2 addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54.5*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    UILabel *shoujihao = [[UILabel alloc]init];
    shoujihao.text = @"手机号";
    shoujihao.textColor = LYColor_A4;
    shoujihao.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background2 addSubview:shoujihao];
    [shoujihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line2);
        make.centerY.mas_equalTo(-27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];
    UILabel *yanzhengma = [[UILabel alloc]init];
    yanzhengma.text = @"验证码";
    yanzhengma.textColor = LYColor_A4;
    yanzhengma.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background2 addSubview:yanzhengma];
    [yanzhengma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line2);
        make.centerY.mas_equalTo(27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    
    [background addSubview:self.pswCode];
    [background addSubview:self.inputAgain];
    [background2 addSubview:self.phoneNum];
    [background2 addSubview:self.codeNum];
    
    [self.pswCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(zhifumima.mas_right).with.offset(23*WIDTH);
        make.centerY.mas_equalTo(zhifumima);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 35*HEIGHT));
    }];
   [self.inputAgain mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.pswCode);
       make.centerY.mas_equalTo(zaicishuruLabel);
       make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
   }];
    
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pswCode);
        make.centerY.mas_equalTo(shoujihao);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 14*HEIGHT));
    }];
    [self.codeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pswCode);
        make.centerY.mas_equalTo(yanzhengma);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 14*HEIGHT));
    }];
    
    //验证码
    [background2 addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.codeNum);
        make.right.mas_equalTo(-13*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 13*HEIGHT));
    }];
    
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background2.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44*HEIGHT);
    }];
    
}
- (void)confirmBtnAction:(UIButton *)sender{
    NSLog(@"确认");
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[TiXianViewController alloc]init] animated:YES];
}

/**
 发送验证码
 */
- (void)sendYanzhengma{
    NSLog(@"获取验证码");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.pswCode resignFirstResponder];
     [self.inputAgain resignFirstResponder];
     [self.phoneNum resignFirstResponder];
     [self.codeNum resignFirstResponder];
    
}
- (UITextField *)pswCode{
    if (!_pswCode) {
        _pswCode = [[UITextField alloc]init];
        _pswCode.backgroundColor = [UIColor whiteColor];
        _pswCode.font = [UIFont systemFontOfSize:13*HEIGHT];
        _pswCode.textColor = LYColor_A3;
        _pswCode.placeholder = @"请输入密码";
        [_pswCode setValue:LYColor_A5 forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _pswCode;
}
- (UITextField *)inputAgain{
    if (!_inputAgain) {
        _inputAgain = [[UITextField alloc]init];
        _inputAgain.backgroundColor = [UIColor whiteColor];
        _inputAgain.font = [UIFont systemFontOfSize:13*HEIGHT];
        _inputAgain.textColor = LYColor_A3;
        _inputAgain.placeholder = @"请再次输入";
        [_inputAgain setValue:LYColor_A5 forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _inputAgain;
}
- (UITextField *)phoneNum{
    if (!_phoneNum) {
        _phoneNum = [[UITextField alloc]init];
        _phoneNum.backgroundColor = [UIColor whiteColor];
        _phoneNum.font = [UIFont systemFontOfSize:13*HEIGHT];
        _phoneNum.textColor = LYColor_A3;
        _phoneNum.placeholder = @"请输入手机号";
        [_phoneNum setValue:LYColor_A5 forKeyPath:@"_placeholderLabel.textColor"];
        _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneNum;
}
- (UITextField *)codeNum{
    if (!_codeNum) {
        _codeNum = [[UITextField alloc]init];
        _codeNum.backgroundColor = [UIColor whiteColor];
        _codeNum.font = [UIFont systemFontOfSize:13*HEIGHT];
        _codeNum.textColor = LYColor_A3;
        _codeNum.placeholder = @"请输入验证码";
        [_codeNum setValue:LYColor_A5 forKeyPath:@"_placeholderLabel.textColor"];
        _codeNum.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeNum;
}
- (UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeBtn.backgroundColor = [UIColor whiteColor];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
         [_codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_codeBtn addTarget:self action:@selector(sendYanzhengma) forControlEvents:UIControlEventTouchUpInside];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*WIDTH];
        [_codeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _codeBtn;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = LYColor_A1;
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = 4.0f;
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
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
