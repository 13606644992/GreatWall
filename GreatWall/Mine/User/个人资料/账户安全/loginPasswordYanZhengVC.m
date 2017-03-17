//
//  loginPasswordYanZhengVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/28.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "loginPasswordYanZhengVC.h"
#import "Header.h"
#import "BangDingPhoneVC.h"

@interface loginPasswordYanZhengVC ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation loginPasswordYanZhengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"身份验证";
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
    tixingLabel.text = @"输入登录密码，完成身份验证";
    [self.view addSubview:tixingLabel];
    tixingLabel.numberOfLines = 0;
    [tixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tixingIMG.mas_right).with.offset(11*WIDTH);
        make.centerY.mas_equalTo(tixingIMG);
        make.height.mas_equalTo(13*HEIGHT);
    }];
    [tixingLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tixingLabel.mas_bottom).with.offset(12*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(56*HEIGHT);
    }];
    
    self.textField = [[UITextField alloc]init];
    self.textField.placeholder = @"登录密码";
    self.textField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    self.textField.textColor = LYColor_A3;
    [background addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 30 *HEIGHT));
    }];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor = LYColor_A1;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 4.0f;
    nextBtn.clipsToBounds = YES;
    [nextBtn addTarget:self action:@selector(queDing:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"验证后绑定新手机" forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44 *HEIGHT);
    }];

}
#pragma mark - 验证后绑定新手机
- (void)queDing:(UIButton *)sender{
    BangDingPhoneVC *vc = [[BangDingPhoneVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
