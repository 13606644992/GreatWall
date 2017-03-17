//
//  EmailViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "EmailViewController.h"
#import "Header.h"
@interface EmailViewController ()
@property (nonatomic, strong)UIButton *rightBtn;
@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改邮箱";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
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
    
    [self.view addSubview:self.emailTextField];
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    self.emailTextField.font = [UIFont systemFontOfSize:14.0*HEIGHT];
    self.emailTextField.textColor = LYColor_A3;
    self.emailTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_email"];
    self.emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(13 * HEIGHT);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50*HEIGHT);
    }];
    [self setTextFieldLeftPadding:self.emailTextField forWidth:18.0];//前方空格
    UIView *whiteView = [[UIView alloc]init];
    [self.view addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.mas_equalTo(self.emailTextField);
        make.left.mas_equalTo(self.emailTextField.mas_right);
        make.right.mas_equalTo(0);
    }];
    [self.emailTextField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];

}
- (void)saveAction:(UIBarButtonItem *)sender{
    [self.emailTextField resignFirstResponder];
    //弹出框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否保存本次修改" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"], @"email": self.emailTextField.text}];
        NSLog(@"修改邮箱%@", params);
        [GJAFNetWork POST:URL_ALIANG params:params method:@"updateUserInfo" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"成功%@", responseObject);
            NSLog(@"%@", responseObject[@"respMsg"]);
            [[NSUserDefaults standardUserDefaults]setObject:self.emailTextField.text forKey:@"GJ_email"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"resetData" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
        
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
    [self.emailTextField resignFirstResponder];
}



-(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

- (UITextField *)emailTextField{
    if (!_emailTextField) {
        _emailTextField = [[UITextField alloc]init];
    }
    return _emailTextField;
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
