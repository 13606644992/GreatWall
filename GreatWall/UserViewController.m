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
@property (nonatomic, strong)UILabel *yu_e;
@property (nonatomic, strong)UILabel *jifen;
@property (nonatomic, strong)UILabel *hongbao;
@property (nonatomic, strong)UITableView *myTableView;

@end

@implementation UserViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;

    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorRGBA(239, 239, 239, 1);
    [self setNeedsStatusBarAppearanceUpdate];//修改电池栏颜色
    //导航view
//    [self.view addSubview:self.navagationView];
//    self.navagationView.backgroundColor = UIColorRGBA(52, 216, 152, 1);
//    [self.navagationView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(64);
//    }];
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
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 60*HEIGHT));
    }];
    self.headerIMGView.layer.masksToBounds = YES;
    UIImage *headIMG = [UIImage imageNamed:@"head.jpg"];
    [self.headerIMGView setImage:headIMG];
    self.headerIMGView.contentMode = UIViewContentModeScaleAspectFit;
    self.headerIMGView.backgroundColor = [UIColor clearColor];
    self.headerIMGView.layer.cornerRadius = 30 * WIDTH;
    //名字
    [backgroundView addSubview:self.nameLabel];
    self.nameLabel.text = @"未登录";
    self.nameLabel.backgroundColor = [UIColor clearColor];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView);
        make.top.mas_equalTo(self.headerIMGView.mas_bottom).with.offset(16*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 16*HEIGHT));
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
    self.renzhengLabel.layer.cornerRadius = 2.0;
    self.renzhengLabel.textAlignment = NSTextAlignmentCenter;
    self.renzhengLabel.font = [UIFont systemFontOfSize:12.0*WIDTH];
    
    
    
    //个险保障icon
    UIImageView *gexianIMGView = [[UIImageView alloc]init];
    gexianIMGView.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:gexianIMGView];
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
    gexianLabel.font = [UIFont systemFontOfSize:14*WIDTH];
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
    dingdanLabel.font = [UIFont systemFontOfSize:14*WIDTH];
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
    chexianLabel.font = [UIFont systemFontOfSize:14*WIDTH];
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
    self.gexianBaodan.text = @"7份保单";
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
    self.chexianBaodan.text = @"2份保单";
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
    [self.myScrollView addSubview:self.yu_e];
    [self.myScrollView addSubview:self.jifen];
    [self.myScrollView addSubview:self.hongbao];
    self.ketixian.text = @"880.00";
    self.yu_e.text = @"1111.00";
    self.jifen.text = @"100.00";
    self.hongbao.text = @"5";
    self.ketixian.font = [UIFont systemFontOfSize:16*WIDTH];
    self.yu_e.font = [UIFont systemFontOfSize:16*WIDTH];
    self.jifen.font = [UIFont systemFontOfSize:16*WIDTH];
    self.hongbao.font = [UIFont systemFontOfSize:16*WIDTH];
    self.ketixian.textAlignment = NSTextAlignmentCenter;
    self.yu_e.textAlignment = NSTextAlignmentCenter;
    self.jifen.textAlignment = NSTextAlignmentCenter;
    self.hongbao.textAlignment = NSTextAlignmentCenter;
    self.ketixian.textColor = LYColor_A3;
    self.yu_e.textColor = LYColor_A3;
    self.jifen.textColor = LYColor_A3;
    self.hongbao.textColor = LYColor_A3;
    
    [self.ketixian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_fifth.mas_top);
        make.centerX.mas_equalTo(-375/8*3*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, HEIGHT*16));
    }];
    [self.yu_e mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_fifth.mas_top);
        make.centerX.mas_equalTo(-375/8*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, HEIGHT*16));
    }];
    [self.jifen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_fifth.mas_top);
        make.centerX.mas_equalTo(375/8*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, HEIGHT*16));
    }];
    [self.hongbao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_fifth.mas_top);
        make.centerX.mas_equalTo(375/8*3*HEIGHT);
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
    label_second.text = @"余额";
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
        make.centerX.mas_equalTo(self.yu_e);
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
//    self.navagationView.alpha = 0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeHeadIMG:) name:@"changeHeadIMG" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeName:) name:@"changeName" object:nil];
    //透明登录按钮
    [backgroundView addSubview:self.loginBtn];
    self.loginBtn.backgroundColor = [UIColor clearColor];
    [self.loginBtn addTarget:self action:@selector(presentToLoginView) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.headerIMGView);
        make.bottom.mas_equalTo(self.nameLabel);
    }];
}



#pragma mark !!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark !!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark !!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark !!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (void)presentToLoginView{
//    LoginViewController *loginVC = [[LoginViewController alloc]init];
//    self.hidesBottomBarWhenPushed = YES;
//    UINavigationController *loginNaVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
//    [self presentViewController:loginNaVC animated:YES completion:nil];
//    self.hidesBottomBarWhenPushed = NO;
    PersonalViewController *personalVC = [[PersonalViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
    }
    cell.tag = indexPath.row;
    [cell addYaoqingAnKefu];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        UINavigationController *loginNaVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNaVC animated:YES completion:nil];
        self.hidesBottomBarWhenPushed = NO;
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

- (void)personalGestureAction{
    NSLog(@"个人设置");
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLgoin"]) {
        
        self.hidesBottomBarWhenPushed=YES;
        PersonalViewController *personalVC = [[PersonalViewController alloc]init];
        personalVC.headerIMG = self.headerIMGView.image;
        personalVC.nameLabel.text = self.nameLabel.text;

        [self.navigationController pushViewController:personalVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else{
        //跳转到登录页面
        [self presentToLoginView];
    }
}
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
//- (UIView *)navagationView{
//    if (!_navagationView) {
//        _navagationView = [[UIView alloc]init];
//    }
//    return _navagationView;
//}
- (UILabel *)ketixian{
    if (!_ketixian) {
        _ketixian = [[UILabel alloc]init];
    }
    return _ketixian;
}
- (UILabel *)yu_e{
    if (!_yu_e) {
        _yu_e = [[UILabel alloc]init];
    }
    return _yu_e;
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
