//
//  ShenfenzhengHaoViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ShenfenzhengHaoViewController.h"
#import "Header.h"
@interface ShenfenzhengHaoViewController ()

@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UILabel *shenfenzhenghao;
@property (nonatomic, strong)UIButton *yanzhengBtn;
@end

@implementation ShenfenzhengHaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"实名认证";
    
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
    myLabel.text = @"请核对信息，如有误请点击修改";
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
    nameLable.text = @"姓名";
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
    
    UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nameBtn.backgroundColor = [UIColor whiteColor];
    [nameBtn setBackgroundImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    [nameBtn addTarget:self action:@selector(nameBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:nameBtn];
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(-27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(15*WIDTH, 15*WIDTH));
    }];
    
    [background addSubview:self.nameTextField];
    self.nameTextField.text = @"杰森斯坦森";
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(nameBtn.mas_left).with.offset(-5*WIDTH);
        make.centerY.mas_equalTo(nameBtn);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 14*HEIGHT));
    }];
    
    [background addSubview:self.shenfenzhenghao];
    self.shenfenzhenghao.text = @"430902199908061218";
    [self.shenfenzhenghao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(nameBtn);
        make.centerY.mas_equalTo(shenfenzhengHaoLabel);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 13*HEIGHT));
    }];
    
    [self.view addSubview:self.yanzhengBtn];
    [self.yanzhengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH );
        make.height.mas_equalTo(44*HEIGHT);
    }];
}

/**
 验证按钮

 */
- (void)yanzhengBtnAction:(UIButton *)sender{
    NSLog(@"提交验证");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeView" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)nameBtnAction:(UIButton *)sender{
    [self.nameTextField becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameTextField resignFirstResponder];
}

- (UILabel *)shenfenzhenghao{
    if (!_shenfenzhenghao) {
        _shenfenzhenghao = [[UILabel alloc]init];
        _shenfenzhenghao.font = [UIFont systemFontOfSize:13*HEIGHT];
        _shenfenzhenghao.textColor = LYColor_A5;
        _shenfenzhenghao.textAlignment = NSTextAlignmentRight;
    }
    return _shenfenzhenghao;
}
- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]init];
        _nameTextField.font = [UIFont systemFontOfSize:13*HEIGHT];
        _nameTextField.textColor = LYColor_A5;
        _nameTextField.backgroundColor = [UIColor whiteColor];
        _nameTextField.textAlignment = NSTextAlignmentRight;
    }
    return _nameTextField;
}
- (UIButton *)yanzhengBtn{
    if (!_yanzhengBtn) {
        _yanzhengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yanzhengBtn.backgroundColor = LYColor_A1;
        [_yanzhengBtn setTitle:@"提交验证" forState:UIControlStateNormal];
        _yanzhengBtn.layer.cornerRadius = 4.0f;
        [_yanzhengBtn addTarget:self action:@selector(yanzhengBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _yanzhengBtn.userInteractionEnabled = !(self.nameTextField.text.length == 0) && self.shenfenzhenghao.text.length == 18 ? YES : NO;
        _yanzhengBtn.backgroundColor = _yanzhengBtn.userInteractionEnabled ? LYColor_A1 : LYColor_A6;
    }
    return _yanzhengBtn;
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
