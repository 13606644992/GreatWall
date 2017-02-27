//
//  TiXianViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "TiXianViewController.h"
#import "Header.h"
#import "BankCardsViewController.h"
@interface TiXianViewController ()
@property (nonatomic, strong)UILabel *bankName;
@property (nonatomic, strong)UILabel *bankNum;
@property (nonatomic, strong)UITextField *moneyTextField;
@property (nonatomic, strong)UIButton *confirmBtn;
@end

@implementation TiXianViewController
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
    self.navigationItem.title = @"提现";
   self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"lvwenhao.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction)];
    backItem.tintColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0];
    self.navigationItem.rightBarButtonItem = backItem;
    
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(91*HEIGHT);
    }];
    
    UIImageView *logoIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yinhangbiaozhi.png"]];
    logoIMGView.backgroundColor = [UIColor whiteColor];
    [background addSubview:logoIMGView];
    [logoIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(WIDTH * 30, WIDTH * 30));
    }];
    
    [background addSubview:self.bankName];
    self.bankName.text = @"中国工商银行";
    [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(logoIMGView);
        make.left.mas_equalTo(logoIMGView.mas_right).with.offset(12*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 20*HEIGHT));
    }];
    UIImageView *kahaoIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yinhangkahao-hui.png"]];
    kahaoIMGView.backgroundColor = [UIColor whiteColor];
    kahaoIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [background addSubview:kahaoIMGView];
    [kahaoIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoIMGView);
        make.top.mas_equalTo(logoIMGView.mas_bottom).with.offset(15*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 7*HEIGHT));
    }];
    
    [background addSubview:self.bankNum];
    self.bankNum.text = @"2046";
    [self.bankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(kahaoIMGView);
        make.left.mas_equalTo(kahaoIMGView.mas_right).with.offset(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(36*WIDTH, 15*HEIGHT));
    }];
    
    UILabel *chuxuka = [[UILabel alloc]init];
    chuxuka.backgroundColor = [UIColor whiteColor];
    chuxuka.font = [UIFont systemFontOfSize:14*HEIGHT];
    chuxuka.text = @"储蓄卡";
    chuxuka.textColor = LYColor_A5;
    [background addSubview:chuxuka];
    [chuxuka mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(kahaoIMGView);
        make.left.mas_equalTo(self.bankNum.mas_right).with.offset(6*WIDTH);
        make.size.mas_equalTo(CGSizeMake(43*WIDTH, 14*HEIGHT));
    }];
    
    UIButton *bangDingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bangDingBtn.backgroundColor = [UIColor whiteColor];
    bangDingBtn.layer.cornerRadius = 2.0f;
    [bangDingBtn setTitle:@"已绑定" forState:UIControlStateNormal];
    [bangDingBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    bangDingBtn.layer.masksToBounds = YES;
    bangDingBtn.layer.borderWidth = 1.0f;
    bangDingBtn.layer.borderColor = LYColor_A6.CGColor;
    bangDingBtn.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    [bangDingBtn addTarget:self action:@selector(bangDingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:bangDingBtn];
    [bangDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(logoIMGView);
        make.right.mas_equalTo(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(74*WIDTH, 24*HEIGHT));
    }];
    
    UIView *background2 = [[UIView alloc]init];
    background2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background2];
    [background2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(13*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(148*HEIGHT);
    }];
    
    UILabel *tixianjine = [[UILabel alloc]init];
    tixianjine.backgroundColor = [UIColor whiteColor];
    tixianjine.text = @"提现金额（元）:";
    tixianjine.font = [UIFont systemFontOfSize:14*HEIGHT];
    tixianjine.textColor = LYColor_A3;
    [background2 addSubview:tixianjine];
    [tixianjine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 15*HEIGHT));
    }];
    
    UILabel *fuhao = [[UILabel alloc]init];
//    fuhao.backgroundColor = LYColor_A1;
    fuhao.text = @"¥";
    fuhao.textColor = LYColor_A3;
    fuhao.font = [UIFont systemFontOfSize:18*HEIGHT];
    [background2 addSubview:fuhao];
    [fuhao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tixianjine.mas_bottom).with.offset(67*HEIGHT);
        make.left.mas_equalTo(tixianjine);
        make.size.mas_equalTo(CGSizeMake(10*WIDTH, 18*HEIGHT));
    }];
    
    [background2 addSubview:self.moneyTextField];
    self.moneyTextField.text = @"387.64";
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(fuhao.mas_right).with.offset(8*WIDTH);
        make.bottom.mas_equalTo(fuhao);
        make.size.mas_equalTo(CGSizeMake(260*WIDTH, 30*HEIGHT));
    }];
    
    UIButton *quanbuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quanbuBtn.backgroundColor = [UIColor whiteColor];
    [quanbuBtn setTitle:@"全部提现" forState:UIControlStateNormal];
    [quanbuBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [quanbuBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    quanbuBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [quanbuBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [quanbuBtn addTarget:self action:@selector(quanbuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [background2 addSubview:quanbuBtn];
    [quanbuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(self.moneyTextField);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 30*HEIGHT));
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = LYColor_A7;
    [background2 addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(fuhao.mas_bottom).with.offset(14*HEIGHT);
        make.height.mas_equalTo(1);
    }];
    self.money = @"249.85";
    self.times = @"3";
    UILabel *shuoming = [[UILabel alloc]init];
    shuoming.backgroundColor = [UIColor whiteColor];
    shuoming.textAlignment = NSTextAlignmentLeft;
    shuoming.textColor = LYColor_A5;
    shuoming.text = [NSString stringWithFormat:@"可提现%@元  本月还可以免费提现%@次", self.money, self.times];
    shuoming.font = [UIFont systemFontOfSize:12*HEIGHT];
    [background2 addSubview:shuoming];
    [shuoming mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.top.mas_equalTo(line.mas_bottom).with.offset(10*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(300*WIDTH, 12*HEIGHT));
    }];
    
    UIImageView *tixingIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tixingfuhao.png"]];
    tixingIMGView.backgroundColor = LYColor_A7;
    tixingIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:tixingIMGView];
    [tixingIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(background2.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*WIDTH));
    }];
    
    UILabel *tixingLabel = [[UILabel alloc]init];
    tixingLabel.backgroundColor = LYColor_A7;
    tixingLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    tixingLabel.text = @"您本月若超出提现次数，继续提现需要扣除1.5元/次手续费";
    tixingLabel.textColor = LYColor_A4;
    tixingLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tixingLabel];
    [tixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tixingIMGView.mas_right).with.offset(8*WIDTH);
        make.centerY.mas_equalTo(tixingIMGView);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(12*HEIGHT);
    }];
    
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tixingLabel.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44*HEIGHT);
    }];
}
- (void)quanbuBtnAction:(UIButton *)sender{
    NSLog(@"全部提现");
}
- (void)rightBtnAction{
    NSLog(@"问号");

}
- (void)confirmBtnAction:(UIButton *)sender{
    NSLog(@"确认");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.moneyTextField resignFirstResponder];
}

- (void)bangDingBtnAction:(UIButton *)sender{
    NSLog(@"已绑定");
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[BankCardsViewController alloc]init] animated:YES];
}

/* lazyLoading.....................................*/

- (UILabel *)bankName{
    if (!_bankName) {
        _bankName = [[UILabel alloc]init];
        _bankName.font = [UIFont systemFontOfSize:18*HEIGHT];
        _bankName.textColor = LYColor_A3;
    }
    return _bankName;
}
- (UILabel *)bankNum{
    if (!_bankNum) {
        _bankNum = [[UILabel alloc]init];
        _bankNum.font = [UIFont systemFontOfSize:13*HEIGHT];
        _bankNum.textColor = LYColor_A5;
    }
    return _bankNum;
}
- (UITextField *)moneyTextField{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc]init];
        _moneyTextField.backgroundColor = [UIColor whiteColor];
        _moneyTextField.font = [UIFont systemFontOfSize:36*HEIGHT];
        _moneyTextField.textColor = LYColor_A3;
        _moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _moneyTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _moneyTextField;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = LYColor_A1;
        [_confirmBtn setTitle:@"立即提现" forState:UIControlStateNormal];
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
