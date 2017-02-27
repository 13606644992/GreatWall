//
//  UserViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/21.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "UserViewController.h"
#import "Header.h"
#import "LoginViewController.h"
#import "PersonalViewController.h"
#import "UserTableViewCell.h"
#import "WodezichanViewController.h"
#import "JiFenViewController.h"
#import "HongBaoViewController.h"
#import "WodedingdanViewController.h"
#import "GeXianViewController.h"
#import "CheXianViewController.h"
#import "ZengXianViewController.h"
#import "CustomerViewController.h"
#import "CustomServiceVC.h"
@interface UserViewController ()

@property (nonatomic, strong)UIImageView *headerIMGView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIButton *loginBtn;
@property (nonatomic, strong)UILabel *renzhengLabel;
@property (nonatomic, strong)UILabel *chexianBaodan;
@property (nonatomic, strong)UILabel *gexianBaodan;
@property (nonatomic, strong)UIScrollView *myScrollView;
//@property (nonatomic, strong)UIView *navagationView;

@property (nonatomic, strong)UILabel *ketixian;
@property (nonatomic, strong)UILabel *shouru;
@property (nonatomic, strong)UILabel *jifen;
@property (nonatomic, strong)UILabel *hongbao;
@property (nonatomic, strong)UITableView *myTableView;

@property (nonatomic, strong)NSDictionary *dataDic;
@end

@implementation UserViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    StatusBarWhite;
    [self resetDataWithUserInfo];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dictionary = [defatluts dictionaryRepresentation];
//    for(NSString *key in [dictionary allKeys]){
//        [defatluts removeObjectForKey:key];
//        [defatluts synchronize];
//    }
    // Do any additional setup after loading the view.
    //返回手势
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    
    self.view.backgroundColor = UIColorRGBA(239, 239, 239, 1);
    [self setNeedsStatusBarAppearanceUpdate];//修改电池栏颜色
    //scrollView
    [self.view addSubview:self.myScrollView];
    self.myScrollView.delegate = self;
    self.myScrollView.backgroundColor = [UIColor whiteColor];
    self.myScrollView.showsVerticalScrollIndicator = NO;
    //背景板
    UIImageView *backgroundView = [[UIImageView alloc]init];
    backgroundView.image = [UIImage imageNamed:@"wodebeijingchahua.png"];
    [self.myScrollView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(276 * HEIGHT);
    }];
    backgroundView.userInteractionEnabled = YES;
    backgroundView.backgroundColor = [UIColor whiteColor];
    //头像
    [backgroundView addSubview:self.headerIMGView];
    [self.headerIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54*HEIGHT);
        make.centerX.mas_equalTo(backgroundView);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 60*WIDTH));
    }];
    self.headerIMGView.layer.masksToBounds = YES;
    self.headerIMGView.contentMode = UIViewContentModeScaleAspectFit;
    self.headerIMGView.backgroundColor = [UIColor clearColor];
    self.headerIMGView.layer.cornerRadius = 30 * WIDTH;
    self.headerIMGView.image = [UIImage imageNamed:@"touxiang-moren.png"];
    //名字
    [backgroundView addSubview:self.nameLabel];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView);
        make.top.mas_equalTo(self.headerIMGView.mas_bottom).with.offset(16*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 16*HEIGHT));
    }];
    self.nameLabel.font = [UIFont systemFontOfSize:16.0*WIDTH];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    //认证
    [backgroundView addSubview:self.renzhengLabel];
    self.renzhengLabel.text = @"未认证";
    self.renzhengLabel.textColor = LYColor_A2;
    [self.renzhengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(8*HEIGHT);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(59*WIDTH, 17*HEIGHT));
    }];
    self.renzhengLabel.backgroundColor = [UIColor whiteColor];
    self.renzhengLabel.layer.masksToBounds = YES;
    self.renzhengLabel.layer.cornerRadius = 2.0*HEIGHT;
    self.renzhengLabel.textAlignment = NSTextAlignmentCenter;
    self.renzhengLabel.font = [UIFont systemFontOfSize:12.0*WIDTH];
    
    
    
    //个险保障icon
    UIImageView *gexianIMGView = [[UIImageView alloc]init];
    gexianIMGView.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:gexianIMGView];
    gexianIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [gexianIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.renzhengLabel.mas_bottom).with.offset(31*HEIGHT);
        make.centerX.mas_equalTo(backgroundView);
        make.size.mas_equalTo(CGSizeMake(18*WIDTH, 20*HEIGHT));
    }];
    gexianIMGView.image = [UIImage imageNamed:@"gexian.png"];
    //个险文字
    UILabel *gexianLabel = [[UILabel alloc]init];
    gexianLabel.text = @"个险保障";
    gexianLabel.textColor = [UIColor whiteColor];
    gexianLabel.textAlignment = NSTextAlignmentCenter;
    gexianLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [backgroundView addSubview:gexianLabel];
    [gexianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView);
        make.top.mas_equalTo(gexianIMGView.mas_bottom).with.offset(10*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(64*WIDTH, 14*HEIGHT));
    }];
    gexianLabel.textColor = [UIColor whiteColor];
    //我的订单文字
    UILabel *dingdanLabel = [[UILabel alloc]init];
    dingdanLabel.text = @"我的订单";
    dingdanLabel.textColor = [UIColor whiteColor];
    dingdanLabel.textAlignment = NSTextAlignmentCenter;
    dingdanLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [backgroundView addSubview:dingdanLabel];
    [dingdanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gexianIMGView.mas_bottom).with.offset(10*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(64*WIDTH, 14*HEIGHT));
        make.left.mas_equalTo(53*WIDTH);
    }];
    dingdanLabel.textColor = [UIColor whiteColor];
    //我的订单icon
    UIImageView *dingdanIMGView = [[UIImageView alloc]init];
    dingdanIMGView.backgroundColor = [UIColor clearColor];
    dingdanIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [backgroundView addSubview:dingdanIMGView];
    [dingdanIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.renzhengLabel.mas_bottom).with.offset(31*HEIGHT);
        make.centerX.mas_equalTo(dingdanLabel);
        make.size.mas_equalTo(CGSizeMake(18*WIDTH, 20*HEIGHT));
    }];
    dingdanIMGView.image = [UIImage imageNamed:@"wodedingdan.png"];
    //车险文字
    UILabel *chexianLabel = [[UILabel alloc]init];
    chexianLabel.text = @"车险保障";
    chexianLabel.textColor = [UIColor whiteColor];
    chexianLabel.textAlignment = NSTextAlignmentCenter;
    chexianLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [backgroundView addSubview:chexianLabel];
    [chexianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gexianIMGView.mas_bottom).with.offset(10*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(64*WIDTH, 14*HEIGHT));
        make.right.mas_equalTo(-53*WIDTH);
    }];
    chexianLabel.textColor = [UIColor whiteColor];
    //车险icon
    UIImageView *chexianIMGView = [[UIImageView alloc]init];
    chexianIMGView.backgroundColor = [UIColor clearColor];
    chexianIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [backgroundView addSubview:chexianIMGView];
    [chexianIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.renzhengLabel.mas_bottom).with.offset(31*HEIGHT);
        make.centerX.mas_equalTo(chexianLabel);
        make.size.mas_equalTo(CGSizeMake(18*WIDTH, 20*HEIGHT));
    }];
    chexianIMGView.image = [UIImage imageNamed:@"chexiann.png"];
    //个险保单
    [backgroundView addSubview:self.gexianBaodan];
    [self.gexianBaodan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gexianLabel.mas_bottom).with.offset(5*HEIGHT);
        make.centerX.mas_equalTo(gexianLabel);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 11*HEIGHT));
    }];
    self.gexianBaodan.textAlignment = NSTextAlignmentCenter;
    self.gexianBaodan.textColor = UIColorRGBA(29, 130, 91, 1);
//    self.gexianBaodan.text = @"7份保单";
    self.gexianBaodan.font = [UIFont systemFontOfSize:11*HEIGHT];
    //车险保单
    [backgroundView addSubview:self.chexianBaodan];
    [self.chexianBaodan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gexianLabel.mas_bottom).with.offset(5*HEIGHT);
        make.centerX.mas_equalTo(chexianLabel);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 11*HEIGHT));
    }];
    self.chexianBaodan.textAlignment = NSTextAlignmentCenter;
    self.chexianBaodan.textColor = UIColorRGBA(29, 130, 91, 1);
    self.chexianBaodan.font = [UIFont systemFontOfSize:11*HEIGHT];
    //分割线
    UIImageView *lineIMG_first = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lineline.png"]];
    lineIMG_first.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:lineIMG_first];
    [lineIMG_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gexianIMGView);
        make.size.mas_equalTo(CGSizeMake(4*WIDTH, 59*HEIGHT));
        make.centerX.mas_equalTo(-self.view.frame.size.width/8);
    }];
    lineIMG_first.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *lineIMG_second = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line.png"]];
    lineIMG_second.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:lineIMG_second];
    [lineIMG_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gexianIMGView);
        make.size.mas_equalTo(CGSizeMake(1*WIDTH, 59*HEIGHT));
        make.centerX.mas_equalTo(self.view.frame.size.width/8);
    }];
    lineIMG_second.contentMode = UIViewContentModeScaleAspectFit;
    //我的订单按钮
    UIButton *dingdanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dingdanBtn.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:dingdanBtn];
    [dingdanBtn addTarget:self action:@selector(pushToWodedingdanVC) forControlEvents:UIControlEventTouchUpInside];
    [dingdanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dingdanIMGView.mas_top).with.offset(-10*HEIGHT);
        make.bottom.mas_equalTo(dingdanLabel.mas_bottom).with.offset(10*HEIGHT);
        make.left.mas_equalTo(dingdanLabel.mas_left).with.offset(-10*WIDTH);
        make.right.mas_equalTo(dingdanLabel.mas_right).with.offset(10*WIDTH);
    }];
    //个险保障按钮
    UIButton *gexianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gexianBtn.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:gexianBtn];
    [gexianBtn addTarget:self action:@selector(pushToGeXianVC) forControlEvents:UIControlEventTouchUpInside];
    [gexianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dingdanIMGView.mas_top).with.offset(-10*HEIGHT);
        make.bottom.mas_equalTo(dingdanLabel.mas_bottom).with.offset(10*HEIGHT);
        make.left.mas_equalTo(gexianLabel.mas_left).with.offset(-10*WIDTH);
        make.right.mas_equalTo(gexianLabel.mas_right).with.offset(10*WIDTH);
    }];
    //车险保障按钮
    UIButton *chexianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chexianBtn.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:chexianBtn];
    [chexianBtn addTarget:self action:@selector(pushToCheXian) forControlEvents:UIControlEventTouchUpInside];
    [chexianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dingdanIMGView.mas_top).with.offset(-10*HEIGHT);
        make.bottom.mas_equalTo(dingdanLabel.mas_bottom).with.offset(10*HEIGHT);
        make.left.mas_equalTo(chexianLabel.mas_left).with.offset(-10*WIDTH);
        make.right.mas_equalTo(chexianLabel.mas_right).with.offset(10*WIDTH);
    }];
    //左上 设置按钮
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:settingBtn];
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*WIDTH);
        make.top.mas_equalTo(25*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 30*WIDTH));
    }];
    [settingBtn setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    //右上 消息按钮
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:messageBtn];
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13*WIDTH);
        make.top.mas_equalTo(25*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 30*WIDTH));
    }];
    [messageBtn setImage:[UIImage imageNamed:@"message.png"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    //我的资产
    UILabel *mineLabel = [[UILabel alloc]init];
    [self.myScrollView addSubview:mineLabel];
    mineLabel.text = @"我的资产";
    mineLabel.textColor = LYColor_A3;
    [mineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backgroundView.mas_bottom).with.offset(13*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 13*HEIGHT));
    }];
    mineLabel.font = [UIFont systemFontOfSize:13*HEIGHT];
   //提现 >
    UILabel *tixianLabel = [[UILabel alloc]init];
    tixianLabel.backgroundColor = [UIColor clearColor];
    tixianLabel.textColor = LYColor_A4;
    tixianLabel.text = @"提现";
    [self.myScrollView addSubview:tixianLabel];
    [tixianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mineLabel);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-35*WIDTH);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 13*HEIGHT));
    }];
    tixianLabel.textAlignment = NSTextAlignmentRight;
    tixianLabel.font = [UIFont systemFontOfSize:13*HEIGHT];
    UIImageView *tixianIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    [self.myScrollView addSubview:tixianIMGView];
    tixianIMGView.backgroundColor = [UIColor whiteColor];
    tixianIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [tixianIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tixianLabel);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(10*WIDTH, HEIGHT *13));
    }];
    UIButton *tixianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tixianBtn addTarget:self action:@selector(pushToWodezichanVC) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:tixianBtn];
    [tixianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tixianLabel);
        make.right.mas_equalTo(tixianIMGView);
        make.top.mas_equalTo(tixianLabel).with.offset(-10);
        make.bottom.mas_equalTo(tixianLabel).with.offset(10);
    }];
    //横线/竖线
    UILabel *line_third = [[UILabel alloc]init];
    line_third.backgroundColor = LYColor_A6;
    [self.myScrollView addSubview:line_third];
    [line_third mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mineLabel.mas_bottom).with.offset(18*HEIGHT);
        make.left.mas_equalTo(mineLabel.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    UILabel *line_forth = [[UILabel alloc]init];
    line_forth.backgroundColor = LYColor_A6;
    [self.myScrollView addSubview:line_forth];
    [line_forth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(line_third.mas_bottom).offset(17*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(0.5, 37*HEIGHT));
    }];
    UILabel *line_fifth = [[UILabel alloc]init];
    line_fifth.backgroundColor = LYColor_A6;
    [self.myScrollView addSubview:line_fifth];
    [line_fifth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(-94*WIDTH);
        make.top.mas_equalTo(line_third.mas_bottom).offset(17*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(0.5, 37*HEIGHT));
    }];
    UILabel *line_sixth = [[UILabel alloc]init];
    line_sixth.backgroundColor = LYColor_A6;
    [self.myScrollView addSubview:line_sixth];
    [line_sixth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(94*WIDTH);
        make.top.mas_equalTo(line_third.mas_bottom).offset(17*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(0.5, 37*HEIGHT));
    }];
    //可提现、余额、积分、红包
    [self.myScrollView addSubview:self.ketixian];
    [self.myScrollView addSubview:self.shouru];
    [self.myScrollView addSubview:self.jifen];
    [self.myScrollView addSubview:self.hongbao];
    self.ketixian.text = @"— —";
    self.shouru.text = @"— —";
    self.jifen.text = @"— —";
    self.hongbao.text = @"— —";
    self.ketixian.font = [UIFont systemFontOfSize:12*WIDTH];
    self.shouru.font = [UIFont systemFontOfSize:12*WIDTH];
    self.jifen.font = [UIFont systemFontOfSize:12*WIDTH];
    self.hongbao.font = [UIFont systemFontOfSize:12*WIDTH];
    self.ketixian.textAlignment = NSTextAlignmentCenter;
    self.shouru.textAlignment = NSTextAlignmentCenter;
    self.jifen.textAlignment = NSTextAlignmentCenter;
    self.hongbao.textAlignment = NSTextAlignmentCenter;
    self.ketixian.textColor = LYColor_A3;
    self.shouru.textColor = LYColor_A3;
    self.jifen.textColor = LYColor_A3;
    self.hongbao.textColor = LYColor_A3;
    
    [self.ketixian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_fifth.mas_top);
        make.centerX.mas_equalTo(-375/8*3*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, HEIGHT*16));
    }];
    [self.shouru mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_fifth.mas_top);
        make.centerX.mas_equalTo(-375/8*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, HEIGHT*16));
    }];
    [self.jifen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_fifth.mas_top);
        make.centerX.mas_equalTo(375/8*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, HEIGHT*16));
    }];
    [self.hongbao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_fifth.mas_top);
        make.centerX.mas_equalTo(375/8*3*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, HEIGHT*16));
    }];
    UILabel *label_first = [[UILabel alloc]init];
    UILabel *label_second = [[UILabel alloc]init];
    UILabel *label_third = [[UILabel alloc]init];
    UILabel *label_forth = [[UILabel alloc]init];
    label_first.backgroundColor = [UIColor whiteColor];
    label_second.backgroundColor = [UIColor whiteColor];
    label_third.backgroundColor = [UIColor whiteColor];
    label_forth.backgroundColor = [UIColor whiteColor];
    label_first.text = @"可提现";
    label_second.text = @"收入";
    label_third.text = @"积分";
    label_forth.text = @"红包";
    UIFont *font = [UIFont systemFontOfSize:11*HEIGHT];
    label_first.font = font;
    label_second.font = font;
    label_third.font = font;
    label_forth.font = font;
    label_first.textAlignment = NSTextAlignmentCenter;
    label_second.textAlignment = NSTextAlignmentCenter;
    label_third.textAlignment = NSTextAlignmentCenter;
    label_forth.textAlignment = NSTextAlignmentCenter;
    label_first.textColor = LYColor_A3;
    label_second.textColor = LYColor_A3;
    label_third.textColor = LYColor_A3;
    label_forth.textColor = LYColor_A3;
    [self.myScrollView addSubview:label_first];
    [self.myScrollView addSubview:label_second];
    [self.myScrollView addSubview:label_third];
    [self.myScrollView addSubview:label_forth];
    [label_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.ketixian);
        make.bottom.mas_equalTo(line_forth);
        make.size.mas_equalTo(CGSizeMake(50*WIDTH, HEIGHT * 11));
    }];
    [label_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shouru);
        make.bottom.mas_equalTo(line_forth);
        make.size.mas_equalTo(CGSizeMake(50*WIDTH, HEIGHT * 11));
    }];
    [label_third mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.jifen);
        make.bottom.mas_equalTo(line_forth);
        make.size.mas_equalTo(CGSizeMake(50*WIDTH, HEIGHT * 11));
    }];
    [label_forth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.hongbao);
        make.bottom.mas_equalTo(line_forth);
        make.size.mas_equalTo(CGSizeMake(50*WIDTH, HEIGHT * 11));
    }];
    //我的资产按钮
    UIButton *mineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mineBtn.backgroundColor = [UIColor clearColor];
    [mineBtn addTarget:self action:@selector(pushToWodezichanVC) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:mineBtn];
    [mineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mineLabel.mas_top).with.offset(-10*HEIGHT);
        make.left.mas_equalTo(mineLabel).with.offset(-10*HEIGHT);
        make.right.mas_equalTo(line_forth);
        make.bottom.mas_equalTo(line_forth).with.offset(10*HEIGHT);
    }];
    //积分按钮
    UIButton *jifenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jifenBtn.backgroundColor = [UIColor clearColor];
    [jifenBtn addTarget:self action:@selector(pushToJiFenVC) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:jifenBtn];
    [jifenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_third);
        make.left.mas_equalTo(line_forth);
        make.right.mas_equalTo(line_sixth);
        make.bottom.mas_equalTo(line_forth).with.offset(10*HEIGHT);
    }];
    //红包按钮
    UIButton *hongbaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hongbaoBtn.backgroundColor = [UIColor clearColor];
    [hongbaoBtn addTarget:self action:@selector(pushToHongBao) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:hongbaoBtn];
    [hongbaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_third);
        make.left.mas_equalTo(line_sixth);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(line_forth).with.offset(10*HEIGHT);
    }];
    //分隔条
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LYColor_A7;
    [self.myScrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(label_first.mas_bottom).with.offset(17*HEIGHT);
        make.height.mas_equalTo(10*HEIGHT);
    }];
    //tableView列表
    [self.myScrollView addSubview:self.myTableView];
    self.myTableView.backgroundColor = [UIColor greenColor];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(290*HEIGHT);
    }];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    //重新设置分割线
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [self.myTableView setSeparatorColor:LYColor_A6];
    self.myTableView.bounces = NO;
    

    [self.myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.bottom.mas_equalTo(self.myTableView.mas_bottom);
    }];
    
    self.edgesForExtendedLayout = UIRectEdgeNone; 
    [self.view bringSubviewToFront:settingBtn];
    [self.view bringSubviewToFront:messageBtn];
    //透明登录按钮
    [backgroundView addSubview:self.loginBtn];
    self.loginBtn.backgroundColor = [UIColor clearColor];
    [self.loginBtn addTarget:self action:@selector(presentToLoginView) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.headerIMGView);
        make.bottom.mas_equalTo(self.nameLabel);
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeHeadIMG:) name:@"changeHeadIMG" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeName:) name:@"changeName" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetDataWithUserInfo) name:@"resetData" object:nil];
    
    //加载用户信息
    [self resetDataWithUserInfo];
}



#pragma mark !!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark !!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark !!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark !!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (void)resetDataWithUserInfo{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLogin"]) {
        [self getUserInfo]; //获取用户信息
//        NSString *headUrlStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_headURL"];
//        if (![headUrlStr isEqualToString:@""]) {
//            [self.headerIMGView sd_setImageWithURL:[NSURL URLWithString:headUrlStr] placeholderImage:[UIImage imageNamed:@"touxiang-moren.png"]];
//        }
//        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_nickName"]isEqualToString:@""]) {
//            self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userName"];
//        }else{
//            self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_nickName"];
//        }
    }else{
        self.nameLabel.text = @"未登录";
        self.headerIMGView.image = [UIImage imageNamed:@"touxiang-moren.png"];
    }

}
/**
 获取用户信息
 */
- (void)getUserInfo{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"]) {
    
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"]}];
        [GJAFNetWork POST:URL_ALIANG params:params method:@"getMyPageInfo" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"用户信息%@", responseObject);
            NSLog(@"%@", responseObject[@"respMsg"]);
            if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
                self.dataDic = responseObject[@"output"]; //获取资产信息
                NSString *ketixianStr = [NSString stringWithFormat:@"%@", self.dataDic[@"acctBalance"]];
                NSString *ketixian = [NSString stringWithFormat:@"%.2f", [ketixianStr floatValue] / 100 ];  //可提现
                self.ketixian.text = ketixian;
                NSString *jifenStr = [NSString stringWithFormat:@"%@", self.dataDic[@"score"]];
                NSString *jifen = [NSString stringWithFormat:@"%ld", [jifenStr integerValue] / 100 ];      //积分
                self.jifen.text = jifen;
                NSString *shouruStr = [NSString stringWithFormat:@"%@", self.dataDic[@"acctSum"]];
                NSString *shouru = [NSString stringWithFormat:@"%.2f", [shouruStr floatValue] / 100 ];      //收入
                self.shouru.text = shouru;
                NSString *hongbaoStr = [NSString stringWithFormat:@"%@", self.dataDic[@"couponCount"]];//红包
                self.hongbao.text = hongbaoStr;
                 NSString *geXianBaoZhang = [NSString stringWithFormat:@"%@份保单", self.dataDic[@"policyCount"]];//个险保障
                self.gexianBaodan.text = geXianBaoZhang;
                NSString *cheXianBaoZhang = [NSString stringWithFormat:@"%@份保单", self.dataDic[@"carPolicyCount"]];//个险保障
                self.chexianBaodan.text = cheXianBaoZhang;
                self.ketixian.font = [UIFont systemFontOfSize:16*WIDTH];
                self.shouru.font = [UIFont systemFontOfSize:16*WIDTH];
                self.jifen.font = [UIFont systemFontOfSize:16*WIDTH];
                self.hongbao.font = [UIFont systemFontOfSize:16*WIDTH];
                //头像
                NSString *headString = [NSString stringWithFormat:@"%@", self.dataDic[@"userLogo"]];
                if (![headString isEqualToString:@""] ) {    //如果设置过头像就显示。
                    NSLog(@"headstring = %@", headString);
                    [self.headerIMGView sd_setImageWithURL:[NSURL URLWithString:headString] placeholderImage:[UIImage imageNamed:@"touxiang-moren.png"] options:SDWebImageRefreshCached];
                }
                //姓名
                NSString *name = [NSString stringWithFormat:@"%@", self.dataDic[@"nickName"]];
                if ([name isEqualToString:@""]) {
                    name = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_mobile"];
                }
                self.nameLabel.text = name;
                //是否认证
                NSString *realNameStatus = [NSString stringWithFormat:@"%@", self.dataDic[@"realNameStatus"]];
                self.renzhengLabel.text = [realNameStatus isEqualToString:@"1"] ? @"已认证" : @"未认证";
                
            }
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
    }

}
- (void)pushToWodedingdanVC{
    NSLog(@"我的订单");
    WodedingdanViewController *wodedingdanVC = [[WodedingdanViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wodedingdanVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)pushToGeXianVC{
    NSLog(@"个险保障");
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLogin"]) {
        GeXianViewController *gexianVC = [[GeXianViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gexianVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        UINavigationController *loginNaVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNaVC animated:YES completion:nil];
        self.hidesBottomBarWhenPushed = NO;
    }
}
- (void)pushToCheXian{
    NSLog(@"车险保障");
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLogin"]) {
        CheXianViewController *gexianVC = [[CheXianViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gexianVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        UINavigationController *loginNaVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNaVC animated:YES completion:nil];
        self.hidesBottomBarWhenPushed = NO;
    }

}
- (void)pushToWodezichanVC{
    NSLog(@"我的资产");
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLogin"]) {
        WodezichanViewController *wodezichanVC = [[WodezichanViewController alloc]init];
        NSString *moneyStr = [NSString stringWithFormat:@"%@", self.dataDic[@"acctBalance"]];
        NSString *money = [NSString stringWithFormat:@"%.2f", [moneyStr floatValue] / 100 ];  //可提现
        wodezichanVC.moneyLabel.text = money;
        NSString *jiesuanzhongStr = [NSString stringWithFormat:@"%@", self.dataDic[@"acctSettSum"]];
        NSString *jiesuanzhong = [NSString stringWithFormat:@"%.2f", [jiesuanzhongStr floatValue] / 100 ];  //结算中
        wodezichanVC.jiesuanzhong.text = jiesuanzhong;
        NSString *benyueshouruStr = [NSString stringWithFormat:@"%@", self.dataDic[@"acctMonthSum"]];
        NSString *benyueshouru = [NSString stringWithFormat:@"%.2f", [benyueshouruStr floatValue] / 100 ];  //本月收入
        wodezichanVC.benyueshouru.text = benyueshouru;
        NSString *leijishouruStr = [NSString stringWithFormat:@"%@", self.dataDic[@"acctSum"]];
        NSString *leijishouru = [NSString stringWithFormat:@"%.2f", [leijishouruStr floatValue] / 100 ];  //累计收入
        wodezichanVC.leijishouru.text = leijishouru;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wodezichanVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        UINavigationController *loginNaVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNaVC animated:YES completion:nil];
        self.hidesBottomBarWhenPushed = NO;
    }

}
- (void)pushToJiFenVC{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLogin"]) {
        JiFenViewController *jifenVC = [[JiFenViewController alloc]init];
        jifenVC.jifenLabel.text = self.jifen.text;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:jifenVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        UINavigationController *loginNaVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNaVC animated:YES completion:nil];
        self.hidesBottomBarWhenPushed = NO;
    }
    NSLog(@"我的积分");
}
- (void)pushToHongBao{
    NSLog(@"红包");
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLogin"]) {
        HongBaoViewController *jifenVC = [[HongBaoViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:jifenVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        UINavigationController *loginNaVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNaVC animated:YES completion:nil];
        self.hidesBottomBarWhenPushed = NO;
    }

}
- (void)presentToLoginView{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLogin"]) {
        PersonalViewController *personalVC = [[PersonalViewController alloc]init];
        personalVC.headerIMG = self.headerIMGView.image;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personalVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        UINavigationController *loginNaVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNaVC animated:YES completion:nil];
        self.hidesBottomBarWhenPushed = NO;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *identifier = @"cell";
        UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    if (indexPath.row == 0) {
        [cell setImgeWith:[UIImage imageNamed:@"zengxian.png"] AndTitle:@"赠险产品"];
    }else if (indexPath.row == 1){
        [cell setImgeWith:[UIImage imageNamed:@"kehu.png"] AndTitle:@"我的客户"];
    }else if (indexPath.row == 2){
        [cell setImgeWith:[UIImage imageNamed:@"shoucangj.png"] AndTitle:@"我的收藏"];
    }else if (indexPath.row == 3){
        [cell setImgeWith:[UIImage imageNamed:@"yaoqinghaoyou.png"] AndTitle:@"邀请好友"];
    }else{
        [cell setImgeWith:[UIImage imageNamed:@"kefuzhongxin"] AndTitle:@"客服中心"];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWindowWidth);
    }
    cell.tag = indexPath.row;
    [cell addYaoqingAnKefu];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLogin"]) {
        if (indexPath.row == 0) {
            ZengXianViewController *zengxianVC = [[ZengXianViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:zengxianVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }else if (indexPath.row == 1){
            CustomerViewController *customerVC = [[CustomerViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:customerVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }else if (indexPath.row == 4){
            CustomServiceVC *customerServiceVC = [[CustomServiceVC alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:customerServiceVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        UINavigationController *loginNaVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNaVC animated:YES completion:nil];
        self.hidesBottomBarWhenPushed = NO;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58*HEIGHT;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView ==  self.myScrollView) {
        CGFloat y =  self.myScrollView.contentOffset.y;
        if (y < 0) {
            self.myScrollView.contentSize = CGSizeMake(375*WIDTH, 0);

        } else {

            self.myScrollView.contentSize = CGSizeMake(375*WIDTH, 691*HEIGHT);
            
        }
    }
}

- (void)settingAction:(UIButton *)sender{
    NSLog(@"设置");

    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"GJ_isLogin"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self resetDataWithUserInfo];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userName"]);
}
- (void)messageAction:(UIButton *)sender{
    NSLog(@"消息");
}

- (void)changeName:(NSNotification *)sender{
    self.nameLabel.text = sender.userInfo[@"name"];
}
- (void)changeHeadIMG:(NSNotification *)sender{
    self.headerIMGView.image = sender.userInfo[@"headIMG"];
}

//- (void)personalGestureAction{
//    NSLog(@"个人设置");
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLgoin"]) {
//        
//        self.hidesBottomBarWhenPushed=YES;
//        PersonalViewController *personalVC = [[PersonalViewController alloc]init];
//        personalVC.headerIMG = self.headerIMGView.image;
//        personalVC.nameLabel.text = self.nameLabel.text;
//
//        [self.navigationController pushViewController:personalVC animated:YES];
//        self.hidesBottomBarWhenPushed=NO;
//    }else{
//        //跳转到登录页面
//        [self presentToLoginView];
//    }
//}
- (void)settingGestureAction{
    NSLog(@"设置");
}









                          /*            lazyLoading...... .          */

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]init];
    }
    return _myTableView;
}
- (UIImageView *)headerIMGView{
    if (!_headerIMGView) {
        _headerIMGView = [[UIImageView alloc]init];
    }
    return _headerIMGView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
    }
    return _nameLabel;
}
- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _loginBtn;
}
- (UILabel *)renzhengLabel{
    if (!_renzhengLabel) {
        _renzhengLabel = [[UILabel alloc]init];
    }
    return _renzhengLabel;
}
- (UILabel *)chexianBaodan{
    if (!_chexianBaodan) {
        _chexianBaodan = [[UILabel alloc]init];
    }
    return _chexianBaodan;
}
- (UILabel *)gexianBaodan{
    if (!_gexianBaodan) {
        _gexianBaodan = [[UILabel alloc]init];
    }
    return _gexianBaodan;
}
- (UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc]init];
    }
    return _myScrollView;
}

- (UILabel *)ketixian{
    if (!_ketixian) {
        _ketixian = [[UILabel alloc]init];
    }
    return _ketixian;
}
- (UILabel *)shouru{
    if (!_shouru) {
        _shouru = [[UILabel alloc]init];
    }
    return _shouru;
}
- (UILabel *)jifen{
    if (!_jifen) {
        _jifen = [[UILabel alloc]init];
    }
    return _jifen;
}
- (UILabel *)hongbao{
    if (!_hongbao) {
        _hongbao = [[UILabel alloc]init];
    }
    return _hongbao;
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
