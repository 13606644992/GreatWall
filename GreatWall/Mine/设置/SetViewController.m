//
//  SetViewController.m
//  GreatWall
//
//  Created by GJ on 2017/3/2.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "SetViewController.h"
#import "Header.h"
#import "PersonalViewController.h"
#import "AboutVC.h"
#import "IdeaVC.h"

@interface SetViewController ()
@property (nonatomic, strong) UIButton *morenBtn;

@end

@implementation SetViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    StatusBarBlack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
//    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    //第一个背景View
    UIView *background = [[UIView alloc]init];
    [self.view addSubview:background];
    background.backgroundColor = [UIColor whiteColor];
//    background.backgroundColor = [UIColor redColor];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18*HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49*HEIGHT);
    }];
    //个人资料label
    UILabel *person = [[UILabel alloc]init];
    [background addSubview:person];
    person.backgroundColor = [UIColor whiteColor];
    [person mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH, 40 * HEIGHT));
    }];
    person.text = @"个人资料";
    person.font = [UIFont systemFontOfSize:14.0*WIDTH];
    person.textColor = LYColor_A3;
    //箭头和btn
    //箭头
    UIImageView *jiantouIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    jiantouIMG.contentMode = UIViewContentModeScaleAspectFit;
    [background addSubview:jiantouIMG];
    [jiantouIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(person);
        make.right.mas_equalTo(-18 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(5.5 * WIDTH, 9.5 * HEIGHT));
    }];
    //按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [background addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(person);
        make.right.mas_equalTo(-5 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(300 * WIDTH, 40 * HEIGHT));
    }];
    btn.alpha = 0.5;
    //        btn.backgroundColor = [UIColor yellowColor];
    //        [btn setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
    btn.tag = 1000;
    btn.adjustsImageWhenHighlighted = NO;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    //第二个背景View
    UIView *backgroundTwo = [[UIView alloc]init];
    [self.view addSubview:backgroundTwo];
    backgroundTwo.backgroundColor = [UIColor whiteColor];
    [backgroundTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).offset(13*HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(98*HEIGHT);
    }];
    //第二个背景View上的线
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(17.5 * WIDTH, 49 * HEIGHT, 357.5 * WIDTH, 1)];
    line.backgroundColor = LYColor_A7;
    [backgroundTwo addSubview:line];
    //推广费显示label
    UILabel *tuiGuangFei = [[UILabel alloc]init];
    [backgroundTwo addSubview:tuiGuangFei];
    tuiGuangFei.backgroundColor = [UIColor whiteColor];
    [tuiGuangFei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(-25*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH, 40 * HEIGHT));
    }];
    tuiGuangFei.text = @"推广费显示";
    tuiGuangFei.font = [UIFont systemFontOfSize:14.0*WIDTH];
    tuiGuangFei.textColor = LYColor_A3;
    //默认按钮
    [backgroundTwo addSubview:self.morenBtn];
    self.morenBtn.backgroundColor = [UIColor whiteColor];
    [self.morenBtn mas_makeConstraints:^(MASConstraintMaker *make) { 
        make.centerY.mas_equalTo(tuiGuangFei);
        make.right.mas_equalTo(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(40*WIDTH, 24*HEIGHT));
    }];
    [self.morenBtn addTarget:self action:@selector(setToMoren:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = self.morenBtn.isSelected ? [UIImage imageNamed:@"on.png"] : [UIImage imageNamed:@"off.png"];
    [self.morenBtn setImage:image forState:UIControlStateNormal];
    //缓存
    UILabel *huanCun = [[UILabel alloc]init];
    [backgroundTwo addSubview:huanCun];
    huanCun.backgroundColor = [UIColor whiteColor];
    [huanCun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.centerY.mas_equalTo(25*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH, 40 * HEIGHT));
    }];
    huanCun.text = @"清除缓存";
    huanCun.textColor = LYColor_A3;
    huanCun.font = person.font;
    //箭头和btn
    //箭头
    UIImageView *jiantouIMGTwo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    jiantouIMGTwo.contentMode = UIViewContentModeScaleAspectFit;
    [backgroundTwo addSubview:jiantouIMGTwo];
    [jiantouIMGTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(huanCun);
        make.right.mas_equalTo(-18 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(5.5 * WIDTH, 9.5 * HEIGHT));
    }];
    //按钮
    UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [backgroundTwo addSubview:btnTwo];
    [btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(huanCun);
        make.right.mas_equalTo(-5 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(300 * WIDTH, 40 * HEIGHT));
    }];
    btnTwo.alpha = 0.5;
    //        btn.backgroundColor = [UIColor yellowColor];
    //        [btn setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
    btnTwo.tag = 1001;
    btnTwo.adjustsImageWhenHighlighted = NO;
    [btnTwo addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    //第3个背景View
    UIView *backgroundThree = [[UIView alloc]init];
    [self.view addSubview:backgroundThree];
    backgroundThree.backgroundColor = [UIColor whiteColor];
    [backgroundThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backgroundTwo.mas_bottom).offset(13*HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(147*HEIGHT);
    }];
    //第3个背景View上的第一条线
    UILabel *lineTwo = [[UILabel alloc]initWithFrame:CGRectMake(17.5 * WIDTH, 49 * HEIGHT, 357.5 * WIDTH, 1)];
    lineTwo.backgroundColor = LYColor_A7;
    [backgroundThree addSubview:lineTwo];
    //第3个背景View上的第2条线
    UILabel *lineThree = [[UILabel alloc]initWithFrame:CGRectMake(17.5 * WIDTH, 49 * 2 * HEIGHT, 357.5 * WIDTH, 1)];
    lineThree.backgroundColor = LYColor_A7;
    [backgroundThree addSubview:lineThree];
    //好评
    UILabel *haoPing = [[UILabel alloc]init];
    [backgroundThree addSubview:haoPing];
    haoPing.backgroundColor = [UIColor whiteColor];
    [haoPing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(lineTwo).offset(-25*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH, 40 * HEIGHT));
    }];
    haoPing.text = @"赐予好评";
    haoPing.font = [UIFont systemFontOfSize:14.0*WIDTH];
    haoPing.textColor = LYColor_A3;
    //意见
    UILabel *yiJian = [[UILabel alloc]init];
    [backgroundThree addSubview:yiJian];
    yiJian.backgroundColor = [UIColor whiteColor];
    [yiJian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.centerY.mas_equalTo(lineTwo).offset(25*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH, 40 * HEIGHT));
    }];
    yiJian.text = @"意见反馈";
    yiJian.textColor = LYColor_A3;
    yiJian.font = person.font;
    //关于汇保险
    UILabel *guanYu = [[UILabel alloc]init];
    [backgroundThree addSubview:guanYu];
    guanYu.backgroundColor = [UIColor whiteColor];
    [guanYu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.centerY.mas_equalTo(lineThree).offset(25*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH, 40 * HEIGHT));
    }];
    guanYu.text = @"关于汇保险";
    guanYu.textColor = LYColor_A3;
    guanYu.font = person.font;
    //箭头和btn
    
        //箭头
    UIImageView *jiantouIMGThree = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    jiantouIMGThree.contentMode = UIViewContentModeScaleAspectFit;
    [backgroundThree addSubview:jiantouIMGThree];
    [jiantouIMGThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(haoPing);
        make.right.mas_equalTo(-18 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(5.5 * WIDTH, 9.5 * HEIGHT));
    }];
    
    UIImageView *jiantouIMGFour = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    jiantouIMGFour.contentMode = UIViewContentModeScaleAspectFit;
    [backgroundThree addSubview:jiantouIMGFour];
    [jiantouIMGFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(yiJian);
        make.right.mas_equalTo(-18 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(5.5 * WIDTH, 9.5 * HEIGHT));
    }];
    UIImageView *jiantouIMGFive = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    jiantouIMGFive.contentMode = UIViewContentModeScaleAspectFit;
    [backgroundThree addSubview:jiantouIMGFive];
    [jiantouIMGFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(guanYu);
        make.right.mas_equalTo(-18 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(5.5 * WIDTH, 9.5 * HEIGHT));
    }];
        //按钮
    UIButton *ciYuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backgroundThree addSubview:ciYuBtn];
    [ciYuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(haoPing);
        make.right.mas_equalTo(-5 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(300 * WIDTH, 40 * HEIGHT));
    }];
    ciYuBtn.alpha = 0.5;
        //        btn.backgroundColor = [UIColor yellowColor];
        //        [btn setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
    ciYuBtn.tag = 1002;
    ciYuBtn.adjustsImageWhenHighlighted = NO;
    [ciYuBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *yiJianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backgroundThree addSubview:yiJianBtn];
    [yiJianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(yiJian);
        make.right.mas_equalTo(-5 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(300 * WIDTH, 40 * HEIGHT));
    }];
    yiJianBtn.alpha = 0.5;
    yiJianBtn.tag = 1003;
    yiJianBtn.adjustsImageWhenHighlighted = NO;
    [yiJianBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backgroundThree addSubview:aboutBtn];
    [aboutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(guanYu);
        make.right.mas_equalTo(-5 * WIDTH);
        make.size.mas_equalTo(CGSizeMake(300 * WIDTH, 40 * HEIGHT));
    }];
    aboutBtn.alpha = 0.5;
    aboutBtn.tag = 1004;
    aboutBtn.adjustsImageWhenHighlighted = NO;
    [aboutBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //退出View
    UIView *tuiChuBackground = [[UIView alloc]init];
    [self.view addSubview:tuiChuBackground];
    tuiChuBackground.backgroundColor = [UIColor whiteColor];
    [tuiChuBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backgroundThree.mas_bottom).offset(18*HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49*HEIGHT);
    }];
    //退出Button
    UIButton *tuiChuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tuiChuBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [tuiChuBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    tuiChuBtn.titleLabel.font = [UIFont systemFontOfSize:18*HEIGHT];
    [tuiChuBtn addTarget:self action:@selector(tuiChuAction) forControlEvents:UIControlEventTouchUpInside];
    [tuiChuBackground addSubview:tuiChuBtn];
    [tuiChuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
}

#pragma mark - 推广费按钮
- (void)setToMoren:(UIButton *)sender{
    sender.selected = !sender.selected;
    UIImage *image = sender.isSelected ? [UIImage imageNamed:@"on.png"] : [UIImage imageNamed:@"off.png"];
    [sender setImage:image forState:UIControlStateNormal];
}
#pragma mark - 箭头Action
- (void)btnAction:(UIButton *)sender{
    PersonalViewController *PersonalVC = [[PersonalViewController alloc]init];
    IdeaVC *idVC = [[IdeaVC alloc]init];
    AboutVC *aboutVC = [[AboutVC alloc]init];
    switch (sender.tag) {
        case 1000:
            [self.navigationController pushViewController:PersonalVC animated:YES];
            break;
        case 1001:
            
            break;
        case 1002:
            
            break;
        case 1003:
            [self.navigationController pushViewController:idVC animated:YES];
            break;
        case 1004:
            [self.navigationController pushViewController:aboutVC animated:YES];
            break;
            
        default:
            break;
    }
}
#pragma mark - 退出登录
- (void)tuiChuAction{
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":userId}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"logout" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"退出登录：%@",responseObject);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSLog(@"退出登录成功");
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"GJ_isLogin"];
//    [NSUserDefaults standardUserDefaults] ;
    [[NSUserDefaults standardUserDefaults]synchronize];
//    [self resetDataWithUserInfo];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userName"]);
}

- (UIButton *)morenBtn{
    if (!_morenBtn) {
        _morenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _morenBtn;
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
