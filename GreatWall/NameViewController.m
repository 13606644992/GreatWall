//
//  NameViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/22.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "NameViewController.h"
#import "Header.h"
@interface NameViewController ()
@property (nonatomic, strong)UIButton *rightBtn;
@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYColor_A7;
    
    self.navigationItem.title = @"编辑昵称";
    [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor : LYColor_A1}];//修改字体颜色
    [self.navigationController.navigationBar setTintColor:LYColor_A1];//返回按钮颜色
    //保存按钮
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveAction:)];
//    rightBtn.tintColor = LYColor_A4;
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [self.rightBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.rightBtn.userInteractionEnabled = NO;
    
    
    [self.view addSubview:self.nameField];
    self.nameField.backgroundColor = [UIColor whiteColor];
    self.nameField.font = [UIFont systemFontOfSize:14.0*HEIGHT];
    self.nameField.textColor = LYColor_A3;
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(13 * HEIGHT);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50*HEIGHT);
    }];
    [self setTextFieldLeftPadding:self.nameField forWidth:18.0];//前方空格
    UIView *whiteView = [[UIView alloc]init];
    [self.view addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.mas_equalTo(self.nameField);
        make.left.mas_equalTo(self.nameField.mas_right);
        make.right.mas_equalTo(0);
    }];
    [self.nameField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
}

- (void)saveAction:(UIBarButtonItem *)sender{
    [self.nameField resignFirstResponder];
    //弹出框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否保存本次修改" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeName" object:nil userInfo:@{@"name" : self.nameField.text}];
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];

}
//监听输入框
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.text.length == 0) {
        self.rightBtn.userInteractionEnabled = NO;
         [self.rightBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
    }else{
        self.rightBtn.userInteractionEnabled = YES;
         [self.rightBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameField resignFirstResponder];
}



-(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

- (UITextField *)nameField{
    if (!_nameField) {
        _nameField = [[UITextField alloc]init];
    }
    return _nameField;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _rightBtn;
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
