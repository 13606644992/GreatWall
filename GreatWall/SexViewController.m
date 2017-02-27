//
//  SexViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/22.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "SexViewController.h"
#import "Header.h"
@interface SexViewController ()
@property(nonatomic, strong)UIImageView *selectedMan;
@property(nonatomic, strong)UIImageView *selectedWoman;
@end

@implementation SexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYColor_A7;
    
    self.navigationItem.title = @"性别";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    
    UIView *background = [[UIView alloc]init];
    [self.view addSubview:background];
    background.backgroundColor = [UIColor whiteColor];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13*HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(112*HEIGHT);
    }];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(17.5 * WIDTH, 56 * HEIGHT, 357.5 * WIDTH, 1)];
    line.backgroundColor = LYColor_A7;
    [background addSubview:line];
    
    
    UILabel *man = [[UILabel alloc]init];
    [background addSubview:man];
    man.backgroundColor = [UIColor whiteColor];
    [man mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.centerY.mas_equalTo(-29*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH, 40 * HEIGHT));
    }];
    man.text = @"男";
    man.font = [UIFont systemFontOfSize:14.0*WIDTH];
    man.textColor = LYColor_A3;
    UILabel *woman = [[UILabel alloc]init];
    [background addSubview:woman];
    woman.backgroundColor = [UIColor whiteColor];
    [woman mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.centerY.mas_equalTo(25*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH, 40 * HEIGHT));
    }];
    woman.text = @"女";
    woman.textColor = LYColor_A3;
    woman.font = man.font;
    
//✔️号
        [background addSubview:self.selectedMan];
        [self.selectedMan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18*WIDTH);
            make.centerY.mas_equalTo(man);
            make.size.mas_equalTo(CGSizeMake(15*WIDTH, 10*HEIGHT));
        }];
        self.selectedMan.backgroundColor = [UIColor whiteColor];
    
    [background addSubview:self.selectedWoman];
    [self.selectedWoman mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(woman);
        make.size.mas_equalTo(CGSizeMake(15*WIDTH, 10*HEIGHT));
    }];
    self.selectedWoman.backgroundColor = [UIColor whiteColor];
    
    if ([self.sexStr isEqualToString:@"男"]) {
        self.selectedWoman.hidden = YES;
    }else{
        self.selectedMan.hidden = YES;
    }
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        [background addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(50 * HEIGHT * i);
            make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 50*HEIGHT));
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    StatusBarBlack;
}
- (void)rightBtnAction:(UIButton *)sender{
    //弹出框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否保存本次修改" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *genderStr = [self.sexStr isEqualToString:@"男"] ? @"0" : @"1";
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"], @"gender": genderStr}];
        NSLog(@"修改姓名%@", params);
        [GJAFNetWork POST:URL_ALIANG params:params method:@"updateUserInfo" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"成功%@", responseObject);
            NSLog(@"%@", responseObject[@"respMsg"]);
            [[NSUserDefaults standardUserDefaults]setObject:self.sexStr forKey:@"GJ_gender"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"resetData" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];

        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeSex" object:nil userInfo:@{@"sex": self.sexStr}];
        [self.navigationController popViewControllerAnimated:YES];
       
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)btnAction:(UIButton *)sender{
    if (sender.tag == 0) {
        self.sexStr = @"男";
        self.selectedMan.hidden = NO;
        self.selectedWoman.hidden = YES;
    }else{
        self.sexStr = @"女";
        self.selectedWoman.hidden = NO;
        self.selectedMan.hidden = YES;
    }
}

- (UIImageView *)selectedMan{
    if (!_selectedMan) {
        _selectedMan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check.png"]];
    }
    return _selectedMan;
}
- (UIImageView *)selectedWoman{
    if (!_selectedWoman) {
        _selectedWoman = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check.png"]];
    }
    return _selectedWoman;
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
