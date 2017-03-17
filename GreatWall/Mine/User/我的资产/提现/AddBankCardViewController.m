//
//  AddBankCardViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "Header.h"
#import "WodezichanViewController.h"
#import "TiXianViewController.h"
#import "ZhiFuMimaViewController.h"
@interface AddBankCardViewController ()
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UILabel *shenfenzhenghao;
@property (nonatomic, strong)UITextField *kahaoTextField;
@property (nonatomic, strong)UIButton *confirmBtn;
@end

@implementation AddBankCardViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    StatusBarBlack;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"🐷%@",self.tiXianjinE);
    self.navigationItem.title = @"添加银行卡";
    UIImageView *tixing = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tixingfuhao.png"]];
    tixing.backgroundColor = LYColor_A7;
    [self.view addSubview:tixing];
    [tixing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*WIDTH));
    }];
    UILabel *myLabel = [[UILabel alloc]init];
    myLabel.font = [UIFont systemFontOfSize:12.0*WIDTH];
    myLabel.backgroundColor = LYColor_A7;
    myLabel.textColor = LYColor_A4;
    myLabel.text = @"绑卡只用于提现，不会产生扣费";
    [self.view addSubview:myLabel];
    [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tixing);
        make.left.mas_equalTo(tixing.mas_right).with.offset(11*WIDTH);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 12*HEIGHT));
    }];

    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myLabel.mas_bottom).with.offset(13*HEIGHT);
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
    UILabel *nameLable = [[UILabel alloc]init];
    nameLable.text = @"真实姓名";
    nameLable.textColor = LYColor_A4;
    nameLable.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.centerY.mas_equalTo(-27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];
    UILabel *shenfenzhengHaoLabel = [[UILabel alloc]init];
    shenfenzhengHaoLabel.text = @"身份证号";
    shenfenzhengHaoLabel.textColor = LYColor_A4;
    shenfenzhengHaoLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background addSubview:shenfenzhengHaoLabel];
    [shenfenzhengHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.centerY.mas_equalTo(27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];

    UIImageView *tanhaoIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhenshixingming.png"]];
    tanhaoIMGView.backgroundColor = [UIColor whiteColor];
    tanhaoIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [background addSubview:tanhaoIMGView];
    [tanhaoIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameLable);
        make.right.mas_equalTo(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(22*WIDTH, 22*HEIGHT));
    }];
    tanhaoIMGView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tanhaoAction:)];
    [tanhaoIMGView addGestureRecognizer:gesture];
    //输入真实姓名
    [background addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLable.mas_right).with.offset(23*WIDTH);
        make.centerY.mas_equalTo(nameLable);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 35*HEIGHT));
    }];
    //身份证号
    [background addSubview:self.shenfenzhenghao];
    [self.shenfenzhenghao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTextField);
        make.centerY.mas_equalTo(shenfenzhengHaoLabel);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 20*HEIGHT));
    }];
    NSString *string = @"430902199908061218";
    self.shenfenzhenghao.text = [string stringByReplacingOccurrencesOfString:[string substringWithRange:NSMakeRange(6,8)]withString:@"********"];
    
    //银行卡
    UIView *background2 = [[UIView alloc]init];
    background2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background2];
    [background2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(13*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(55*HEIGHT);
    }];
    UILabel *kahaoLable = [[UILabel alloc]init];
    kahaoLable.text = @"银行卡号";
    kahaoLable.textColor = LYColor_A4;
    kahaoLable.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background2 addSubview:kahaoLable];
    [kahaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];
    //输入银行卡号
    [background2 addSubview:self.kahaoTextField];
    [self.kahaoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kahaoLable.mas_right).with.offset(23*WIDTH);
        make.centerY.mas_equalTo(kahaoLable);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 35*HEIGHT));
    }];
    
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background2.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44*HEIGHT);
    }];

}
#pragma mark - 确认按钮
- (void)confirmBtnAction:(UIButton *)sender{
    NSLog(@"确认");
    //测试
    self.hidesBottomBarWhenPushed = YES;
    ZhiFuMimaViewController *vc = [[ZhiFuMimaViewController alloc]init];
    vc.jinE = self.tiXianjinE;
    [self.navigationController pushViewController:vc animated:YES];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"],@"accountName":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_realName"],@"idNo":@"230521199406011117",@"cardNo":self.kahaoTextField.text}];
    [GJAFNetWork POST:URL_KENAN params:dic method:@"bindingBankCard" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"绑定银行卡responseObject=======%@",responseObject);
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            NSLog(@"银行卡绑定成功");
            self.hidesBottomBarWhenPushed = YES;
            ZhiFuMimaViewController *vc = [[ZhiFuMimaViewController alloc]init];
            vc.jinE = self.tiXianjinE;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)tanhaoAction:(UITapGestureRecognizer *)gesture{
    NSLog(@"弹出说明");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameTextField resignFirstResponder];
    [self.kahaoTextField resignFirstResponder];
}
- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]init];
        _nameTextField.backgroundColor = [UIColor whiteColor];
        _nameTextField.font = [UIFont systemFontOfSize:13*HEIGHT];
        _nameTextField.textColor = LYColor_A3;
        _nameTextField.placeholder = @"请输入真实姓名";
        [_nameTextField setValue:LYColor_A5 forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _nameTextField;
}
- (UILabel *)shenfenzhenghao{
    if (!_shenfenzhenghao) {
        _shenfenzhenghao = [[UILabel alloc]init];
        _shenfenzhenghao.backgroundColor = [UIColor whiteColor];
        _shenfenzhenghao.font = [UIFont systemFontOfSize:13*HEIGHT];
        _shenfenzhenghao.textColor = LYColor_A3;
    }
    return _shenfenzhenghao;
}
- (UITextField *)kahaoTextField{
    if (!_kahaoTextField) {
        _kahaoTextField = [[UITextField alloc]init];
        _kahaoTextField.backgroundColor = [UIColor whiteColor];
        _kahaoTextField.font = [UIFont systemFontOfSize:13*HEIGHT];
        _kahaoTextField.textColor = LYColor_A3;
        _kahaoTextField.placeholder = @"请输入您的银行卡号";
        [_kahaoTextField setValue:LYColor_A5 forKeyPath:@"_placeholderLabel.textColor"];
        _kahaoTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _kahaoTextField;
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
