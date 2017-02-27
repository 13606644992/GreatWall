//
//  BankCardsViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/11.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "BankCardsViewController.h"
#import "Header.h"
@interface BankCardsViewController ()
@property (nonatomic, strong)UILabel *bankName;
@property (nonatomic, strong)UILabel *bankNum;
@end

@implementation BankCardsViewController

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
    self.navigationItem.title = @"我的银行卡";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏文字颜色及大小
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    UIView *bankCardView = [[UIView alloc]init];
    bankCardView.backgroundColor = LYColor_A1;
    [self.view addSubview:bankCardView];
    [bankCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(164*HEIGHT);
    }];
    [bankCardView layoutIfNeeded];
    bankCardView.layer.cornerRadius = 4.0;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:bankCardView.bounds];
    bankCardView.layer.masksToBounds = NO;
    bankCardView.layer.shadowColor = LYColor_A1.CGColor;
    bankCardView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    bankCardView.layer.shadowOpacity = 0.7f;
    bankCardView.layer.shadowRadius = 8.0f;
    bankCardView.layer.shadowPath = shadowPath.CGPath;
    
    [bankCardView addSubview:self.bankName];
    self.bankName.text = @"中国工商银行";
    [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30*WIDTH);
        make.left.mas_equalTo(33*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 20*HEIGHT));
    }];
    UILabel *bankType = [[UILabel alloc]init];
    bankType.backgroundColor = [UIColor clearColor];
    bankType.text = @"储蓄卡";
    bankType.textColor = [UIColor whiteColor];
    bankType.textAlignment = NSTextAlignmentLeft;
    bankType.font = [UIFont systemFontOfSize:14*HEIGHT];
    [bankCardView addSubview:bankType];
    [bankType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bankName);
        make.top.mas_equalTo(self.bankName.mas_bottom).with.offset(10*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];
    
    UIImageView *yuandianIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yinhangkahao-bai.png"]];
    yuandianIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [bankCardView addSubview:yuandianIMGView];
    [yuandianIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bankType);
        make.top.mas_equalTo(bankType.mas_bottom).with.offset(44*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 9*HEIGHT));
    }];
    
    
    UIImageView *logoIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gongshangyinhang.png"]];
    logoIMG.contentMode = UIViewContentModeScaleAspectFit;
    [bankCardView addSubview:logoIMG];
    [logoIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 93*HEIGHT));
    }];
    
    [bankCardView addSubview:self.bankNum];
    self.bankNum.text = @"2089";
    [self.bankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yuandianIMGView.mas_right).with.offset(16*WIDTH);
        make.centerY.mas_equalTo(yuandianIMGView);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 20*HEIGHT));
    }];
    
    UIButton *jiebangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiebangBtn setTitle:@"解绑" forState:UIControlStateNormal];
    jiebangBtn.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    [jiebangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    jiebangBtn.layer.cornerRadius = 2.0f;
    jiebangBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    jiebangBtn.layer.borderWidth = 1.0f;
    [jiebangBtn addTarget:self action:@selector(jieBangBtnActio:) forControlEvents:UIControlEventTouchUpInside];
    [bankCardView addSubview:jiebangBtn];
    [jiebangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bankName);
        make.right.mas_equalTo(-30*WIDTH);
        make.size.mas_equalTo(CGSizeMake(74*WIDTH, 24*HEIGHT));
    }];
}
- (void)jieBangBtnActio:(UIButton *)sender{
    NSLog(@"解绑");
}
/* lazyLoading.....................................*/

- (UILabel *)bankName{
    if (!_bankName) {
        _bankName = [[UILabel alloc]init];
        _bankName.font = [UIFont systemFontOfSize:20*HEIGHT];
        _bankName.textColor = [UIColor whiteColor];
        _bankName.textAlignment = NSTextAlignmentLeft;
    }
    return _bankName;
}
- (UILabel *)bankNum{
    if (!_bankNum) {
        _bankNum = [[UILabel alloc]init];
        _bankNum.font = [UIFont systemFontOfSize:16*HEIGHT];
        _bankNum.textColor = [UIColor whiteColor];
        _bankNum.textAlignment = NSTextAlignmentLeft;
    }
    return _bankNum;
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
