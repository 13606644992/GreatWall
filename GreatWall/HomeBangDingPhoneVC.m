//
//  BangDingPhoneVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/28.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "HomeBangDingPhoneVC.h"
#import "Header.h"


@interface HomeBangDingPhoneVC ()
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *yanZhengMaTextField;
@property (nonatomic, strong) UIButton *yanZhengBtn;
@property (nonatomic, strong, nonnull)NSTimer *myTimer;
@property (nonatomic, assign)NSInteger currentcountDown;

@end

@implementation HomeBangDingPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"绑定手机";
    self.view.backgroundColor = LYColor_A7;
    self.currentcountDown = 60;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"绑定手机";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = LYColor_A1;
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(addbackClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];

    
    
    
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(82*HEIGHT);
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
    
    self.phoneTextField = [[UITextField alloc]init];
    
    self.phoneTextField = [[UITextField alloc]init];
    self.phoneTextField.placeholder = @"手机号";
    self.phoneTextField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    self.phoneTextField.textColor = LYColor_A3;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [background addSubview:self.phoneTextField];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(background).with.offset(-28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 30 *HEIGHT));
        
    }];
    
    self.yanZhengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yanZhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.yanZhengBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.yanZhengBtn addTarget:self action:@selector(huoQu:) forControlEvents:UIControlEventTouchUpInside];
    [self.yanZhengBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [background addSubview:self.yanZhengBtn];
    [self.yanZhengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18 * WIDTH);
        make.centerY.mas_equalTo(background).with.offset(-28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(90 * WIDTH, 30 * HEIGHT));
    }];
    [self.yanZhengBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    self.yanZhengMaTextField = [[UITextField alloc]init];
    self.yanZhengMaTextField.placeholder = @"验证码";
    self.yanZhengMaTextField.font = [UIFont systemFontOfSize:14 * HEIGHT];
    self.yanZhengMaTextField.textColor = LYColor_A3;
    self.yanZhengMaTextField.keyboardType = UIKeyboardTypeNumberPad;
    [background addSubview:self.yanZhengMaTextField];
    [self.yanZhengMaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(background).with.offset(28 * HEIGHT);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 30 *HEIGHT));
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
}
-(void)addbackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;


}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;

}
-(void)huoQu:(UIButton *)sender{
 
//    getVerifyCode
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"codeType":@"1", @"mobile":self.phoneTextField.text, @"bizType":@"15"}];
    
    [GJAFNetWork POST:URL_ALIANG params:params method:@"getVerifyCode" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"错误%@", error);
    }];
    
    self.yanZhengBtn.userInteractionEnabled = NO;
    [self.yanZhengBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
    [self.phoneTextField becomeFirstResponder];
    [self.myTimer fire];
    
}
- (void)queDing:(UIButton *)sender{
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"codeType":@"1", @"mobile":self.phoneTextField.text, @"bizType":@"15"}];
    
//    [GJAFNetWork POST:URL_ALIANG params:params method:@"updateUpgradeB" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"成功%@", responseObject);
//        NSLog(@"%@", responseObject[@"respMsg"]);
//        
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        NSLog(@"错误%@", error);
//    }];

    NSArray *array = self.navigationController.viewControllers;
    UIViewController *HomeVC = array[0];
    if ([HomeVC isKindOfClass:[HomeViewController class]]) {
        HomeViewController *HomeVC = array[0];
        HomeVC.result = @"1";
        [self.navigationController popToViewController:HomeVC animated:YES];
    }else if ([HomeVC isKindOfClass:[UserViewController class]]){
        UserViewController *HomeVC = array[0];
        HomeVC.result = @"1";
        [self.navigationController popToViewController:HomeVC animated:YES];
    }
}
-(void)countDown{
    if (self.currentcountDown >0) {
        //设置界面的按钮显示 根据自己需求设置
        self.currentcountDown -= 1;
        [self.yanZhengBtn setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.currentcountDown] forState:UIControlStateNormal];
    }else{
        self.currentcountDown = 60;
        [self.myTimer invalidate];
        [self.yanZhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        if (self.phoneTextField.text.length == 11) {
            self.yanZhengBtn.userInteractionEnabled = YES;
            [self.yanZhengBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSTimer *)myTimer{
    if (!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
    return _myTimer;
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
