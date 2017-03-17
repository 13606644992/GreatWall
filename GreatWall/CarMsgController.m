//
//  CarMsgController.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/1.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CarMsgController.h"
#import "Header.h"
#import "CarSelectController.h"
#import "CarPhotoView.h"

@interface CarMsgController ()
{
    NSInteger index;
}
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) UITextField *carTypeTF;
@property (nonatomic ,strong) UITextField *shiBieTF;
@property (nonatomic ,strong) UITextField *faDongTF;
@property (nonatomic ,strong) UILabel *zhuTimeLab;
@property (nonatomic ,strong) UITextField *zaiCountLab;
@property (nonatomic ,strong) UILabel *jiaoTimeLab;
@property (nonatomic ,strong) UILabel *shangTimeLab;
@property (nonatomic ,strong) UITextField *carNameTF;
@property (nonatomic ,strong) UITextField *cardNumTF;
//@property (nonatomic ,strong) UITextField *carPerson;
@property (nonatomic ,strong) UITextField *carPhoneTF;
@property (nonatomic ,strong) UIImageView *selectImg;
@property (nonatomic ,strong) UIButton *typeBtn;

@property (nonatomic ,strong) UIButton *qieBtn;
@property (nonatomic ,strong) UILabel *PerName;
@property (nonatomic ,strong) UILabel *cardNo;

/*
 *  行驶证信息提示界面
 */
@property (nonatomic ,strong) CarPhotoView *photoView;



@end

@implementation CarMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"信息填写";index=0;
    self.view.backgroundColor = LYColor_A7;
//    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[LYColor colorWithHexString:@"#2dce8f"]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 10, 17.5);
    [backBtn addTarget:self action:@selector(CarMsgbackClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.view addSubview:self.scrollView];

    [self setScrollViewContent];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = NO;
    index=0;

    self.carTypeTF.text = @"别克牌SGM7161WAS3";
    self.shiBieTF.text = @"LSGAY67S1U888888";
    self.faDongTF.text = @"888888888";
    self.zhuTimeLab.text = @"2015-12-19";
    self.zaiCountLab.text = @"5";
    self.jiaoTimeLab.text = @"2015-12-19";
    self.shangTimeLab.text = @"2015-12-19";
    self.carNameTF.text = @"乔见君";
    self.cardNumTF.text = @"330122199509092525";
    self.carPhoneTF.text = @"15088667878";
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.translucent = YES;

}
-(void)setScrollViewContent{
    //车辆信息
    UILabel *carMsgLab = [[UILabel alloc] init];
    carMsgLab.textColor = LYColor_A4;
    carMsgLab.font = [UIFont systemFontOfSize:12*WIDTH];
    carMsgLab.text = @"车辆信息";
    [self.scrollView addSubview:carMsgLab];
    [carMsgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(@(18*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 12*HEIGHT));
    }];
    
    //在哪看车辆信息
    UIButton*whereBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [whereBtn setTitle:@"在哪看车辆信息" forState:UIControlStateNormal];
    whereBtn.titleLabel.font = [UIFont systemFontOfSize:12*WIDTH];
    [whereBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [whereBtn addTarget:self action:@selector(whereBtnClick) forControlEvents:UIControlEventTouchUpInside];
    whereBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.scrollView addSubview:whereBtn];
    [whereBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-18*WIDTH);
        make.centerY.equalTo(carMsgLab);
        make.size.mas_equalTo(CGSizeMake(110*WIDTH, 30*HEIGHT));
    }];
    
    //车辆信息View
    UIView *carView = [[UIView alloc] init];
    carView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:carView];
    [carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(carMsgLab.mas_bottom).with.offset(13*HEIGHT);
        make.height.equalTo(@(450*HEIGHT));
    }];
    
    //品牌型号
    UILabel *carType = [[UILabel alloc] init];
    carType.textColor = LYColor_A4;
    carType.font = [UIFont systemFontOfSize:14*WIDTH];
    carType.text = @"品牌型号";
    [carView addSubview:carType];
    [carType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(@(21*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //车辆型号输入
    self.carTypeTF = [[UITextField alloc] init];
    self.carTypeTF.font = [UIFont systemFontOfSize:13*WIDTH];
    self.carTypeTF.placeholder = @"请输入车辆型号";
    self.carTypeTF.textColor = LYColor_A3;
    [carView addSubview:self.carTypeTF];
    [self.carTypeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(131*WIDTH);
        make.centerY.equalTo(carType);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];
    
//    //相机
//    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [photoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    photoBtn.backgroundColor = [UIColor redColor];
//    [photoBtn addTarget:self action:@selector(photoClick) forControlEvents:UIControlEventTouchUpInside];
//    [carView addSubview:photoBtn];
//    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).with.offset(-18*WIDTH);
//        make.centerY.equalTo(carType);
//        make.size.mas_equalTo(CGSizeMake(31*WIDTH, 23*HEIGHT));
//    }];
    
    //间隔线1
    UILabel *line1 = [[UILabel alloc] init];
    line1.backgroundColor = LYColor_A6;
    [carView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view);
        make.top.mas_equalTo(carType.mas_bottom).with.offset(21*HEIGHT);
        make.height.equalTo(@(0.5));
    }];
    
    //车辆识别代码
    UILabel *carShiLab = [[UILabel alloc] init];
    carShiLab.text = @"车辆识别代码";
    carShiLab.textColor = LYColor_A4;
    carShiLab.font = [UIFont systemFontOfSize:14*WIDTH];
    [carView addSubview:carShiLab];
    [carShiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(line1.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //识别码输入框
    self.shiBieTF = [[UITextField alloc] init];
    self.shiBieTF.placeholder = @"请输入识别代码";
    self.shiBieTF.font = [UIFont systemFontOfSize:13*WIDTH];
    self.shiBieTF.textColor = LYColor_A3;
    [carView addSubview:self.shiBieTF];
    [self.shiBieTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(131*WIDTH));
        make.centerY.equalTo(carShiLab);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];
    
    //间隔线2
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = LYColor_A6;
    [carView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view);
        make.top.mas_equalTo(carShiLab.mas_bottom).with.offset(21*HEIGHT);
        make.height.equalTo(@(0.5));
    }];
    
    //发动机号
    UILabel *fadong = [[UILabel alloc] init];
    fadong.textColor = LYColor_A4;
    fadong.text = @"发动机号";
    fadong.font = [UIFont systemFontOfSize:14*WIDTH];
    [carView addSubview:fadong];
    [fadong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2);
        make.top.mas_equalTo(line2.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //发动机型号输入框
    self.faDongTF = [[UITextField alloc] init];
    self.faDongTF.placeholder = @"请输入发动机号";
    self.faDongTF.font = [UIFont systemFontOfSize:13*WIDTH];
    self.faDongTF.textColor = LYColor_A3;
    [carView addSubview:self.faDongTF];
    [self.faDongTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(131*WIDTH));
        make.centerY.equalTo(fadong);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];
    
    //间隔线3
    UILabel *line3 = [[UILabel alloc] init];
    line3.backgroundColor = LYColor_A6;
    [carView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view);
        make.top.mas_equalTo(fadong.mas_bottom).with.offset(21*HEIGHT);
        make.height.equalTo(@(0.5));
    }];

    //注册时间
    UILabel *zhuce = [[UILabel alloc] init];
    zhuce.textColor = LYColor_A4;
    zhuce.text = @"注册时间";
    zhuce.font = [UIFont systemFontOfSize:14*WIDTH];
    [carView addSubview:zhuce];
    [zhuce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line3);
        make.top.mas_equalTo(line3.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //注册输入框
    self.zhuTimeLab = [[UILabel alloc] init];
    self.zhuTimeLab.text = @"请选择";
    self.zhuTimeLab.font = [UIFont systemFontOfSize:13*WIDTH];
    self.zhuTimeLab.textColor = LYColor_A4;
    [carView addSubview:self.zhuTimeLab];
    [self.zhuTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(131*WIDTH));
        make.centerY.equalTo(zhuce);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];
    
    UIImageView *xiaImg1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xialaicon"]];
    [carView addSubview:xiaImg1];
    [xiaImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-18*WIDTH);
        make.centerY.equalTo(zhuce);
        make.width.equalTo(@(12.5*WIDTH));
        make.height.equalTo(@(7.5*HEIGHT));
    }];
    
    UIButton *zhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhuBtn addTarget:self action:@selector(zhuceClick) forControlEvents:UIControlEventTouchUpInside];
    [carView addSubview:zhuBtn];
    [zhuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(xiaImg1);
        make.centerY.equalTo(xiaImg1);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 40*HEIGHT));
    }];
    
    //间隔线4
    UILabel *line4 = [[UILabel alloc] init];
    line4.backgroundColor = LYColor_A6;
    [carView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view);
        make.top.mas_equalTo(zhuce.mas_bottom).with.offset(21*HEIGHT);
        make.height.equalTo(@(0.5));
    }];
    
    //荷载人数
    UILabel *hezai = [[UILabel alloc] init];
    hezai.textColor = LYColor_A4;
    hezai.text = @"荷载人数";
    hezai.font = [UIFont systemFontOfSize:14*WIDTH];
    [carView addSubview:hezai];
    [hezai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line4);
        make.top.mas_equalTo(line4.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //荷载数量
    self.zaiCountLab = [[UITextField alloc] init];
//    self.zaiCountLab.text = @"5";
    self.zaiCountLab.font = [UIFont systemFontOfSize:13*WIDTH];
    self.zaiCountLab.textColor = LYColor_A3;
    self.zaiCountLab.placeholder = @"请输入荷载人数";
    [carView addSubview:self.zaiCountLab];
    [self.zaiCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(131*WIDTH));
        make.centerY.equalTo(hezai);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];

    //间隔线5
    UILabel *line5 = [[UILabel alloc] init];
    line5.backgroundColor = LYColor_A6;
    [carView addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view);
        make.top.mas_equalTo(hezai.mas_bottom).with.offset(21*HEIGHT);
        make.height.equalTo(@(0.5));
    }];

    //交强险起保时间
    UILabel *jiaoQiang = [[UILabel alloc] init];
    jiaoQiang.textColor = LYColor_A4;
    jiaoQiang.text = @"交强险起保时间";
    jiaoQiang.font = [UIFont systemFontOfSize:14*WIDTH];
    [carView addSubview:jiaoQiang];
    [jiaoQiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line5);
        make.top.mas_equalTo(line5.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //交强险时间选择
    self.jiaoTimeLab = [[UILabel alloc] init];
    self.jiaoTimeLab.text = @"请选择";
    self.jiaoTimeLab.font = [UIFont systemFontOfSize:13*WIDTH];
    self.jiaoTimeLab.textColor = LYColor_A4;
    [carView addSubview:self.jiaoTimeLab];
    [self.jiaoTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(131*WIDTH));
        make.centerY.equalTo(jiaoQiang);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];
    
    UIImageView *xiaImg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xialaicon"]];
    [carView addSubview:xiaImg2];
    [xiaImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-18*WIDTH);
        make.centerY.equalTo(jiaoQiang);
        make.width.equalTo(@(12.5*WIDTH));
        make.height.equalTo(@(7.5*HEIGHT));
    }];
    
    UIButton *jiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiaoBtn addTarget:self action:@selector(jiaoqiangClick) forControlEvents:UIControlEventTouchUpInside];
    [carView addSubview:jiaoBtn];
    [jiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(xiaImg2);
        make.centerY.equalTo(xiaImg2);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 40*HEIGHT));
    }];


    //间隔线6
    UILabel *line6 = [[UILabel alloc] init];
    line6.backgroundColor = LYColor_A6;
    [carView addSubview:line6];
    [line6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view);
        make.top.mas_equalTo(jiaoQiang.mas_bottom).with.offset(21*HEIGHT);
        make.height.equalTo(@(0.5));
    }];
    
    //商业险起保时间
    UILabel *shangye = [[UILabel alloc] init];
    shangye.textColor = LYColor_A4;
    shangye.text = @"商业险起保时间";
    shangye.font = [UIFont systemFontOfSize:14*WIDTH];
    [carView addSubview:shangye];
    [shangye mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line6);
        make.top.mas_equalTo(line6.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //商业险时间选择
    self.shangTimeLab = [[UILabel alloc] init];
    self.shangTimeLab.text = @"请选择";
    self.shangTimeLab.font = [UIFont systemFontOfSize:13*WIDTH];
    self.shangTimeLab.textColor = LYColor_A4;
    [carView addSubview:self.shangTimeLab];
    [self.shangTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(131*WIDTH));
        make.centerY.equalTo(shangye);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];
    
    UIImageView *xiaImg3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xialaicon"]];
    [carView addSubview:xiaImg3];
    [xiaImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-18*WIDTH);
        make.centerY.equalTo(shangye);
        make.width.equalTo(@(12.5*WIDTH));
        make.height.equalTo(@(7.5*HEIGHT));
    }];
    
    UIButton *shangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shangBtn addTarget:self action:@selector(shangyeClick) forControlEvents:UIControlEventTouchUpInside];
    [carView addSubview:shangBtn];
    [shangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(xiaImg3);
        make.centerY.equalTo(xiaImg3);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 40*HEIGHT));
    }];
    
    //间隔线7
    UILabel *line7 = [[UILabel alloc] init];
    line7.backgroundColor = LYColor_A6;
    [carView addSubview:line7];
    [line7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view);
        make.top.mas_equalTo(shangye.mas_bottom).with.offset(21*HEIGHT);
        make.height.equalTo(@(0.5));
    }];
    
    //过户车辆按钮
    self.selectImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weigouxuan(xincheweishangpai)"]];
    [carView addSubview:self.selectImg];
    [self.selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line7.mas_bottom).with.offset(19*HEIGHT);
        make.left.equalTo(@(18*WIDTH));
        make.size.mas_equalTo(CGSizeMake(19*WIDTH, 19*WIDTH));
    }];
    
    //过户车辆首次投保
    UILabel *guoLab = [[UILabel alloc] init];
    guoLab.textColor = LYColor_A1;
    guoLab.font = [UIFont systemFontOfSize:14*WIDTH];
    guoLab.text = @"过户车辆首次投保";
    [carView addSubview:guoLab];
    [guoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectImg.mas_right).with.offset(11*WIDTH);
        make.centerY.equalTo(self.selectImg);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 14*HEIGHT));
    }];
    

    self.typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.typeBtn addTarget:self action:@selector(carTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    self.typeBtn.selected = NO;
    [carView addSubview:self.typeBtn];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.centerY.equalTo(guoLab);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 56*HEIGHT));
    }];
    
    //车主信息
    UILabel *carperLab = [[UILabel alloc] init];
    carperLab.textColor = LYColor_A4;
    carperLab.font = [UIFont systemFontOfSize:12*WIDTH];
    carperLab.text = @"车主信息";
    [self.scrollView addSubview:carperLab];
    [carperLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(carView.mas_bottom).with.offset(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 12*HEIGHT));
    }];
    
    //个人(企业)车辆
    self.qieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.qieBtn setTitle:@"企业车辆" forState:UIControlStateNormal];
    self.qieBtn.titleLabel.font = [UIFont systemFontOfSize:12*WIDTH];
    [self.qieBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [self.qieBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.qieBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.qieBtn.selected = NO;
    [self.scrollView addSubview:self.qieBtn];
    [self.qieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-18*WIDTH);
        make.centerY.equalTo(carperLab);
        make.size.mas_equalTo(CGSizeMake(110*WIDTH, 30*HEIGHT));
    }];

    UIView *ownerView = [[UIView alloc] init];
    ownerView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:ownerView];
    [ownerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(carperLab.mas_bottom).with.offset(18*HEIGHT);
        make.height.equalTo(@(169*HEIGHT));
    }];
    
    //车主姓名（企业名称）
    self.PerName = [[UILabel alloc] init];
    self.PerName.textColor = LYColor_A4;
    self.PerName.text = @"车主姓名";
    self.PerName.font = [UIFont systemFontOfSize:14*WIDTH];
    [ownerView addSubview:self.PerName];
    [self.PerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(ownerView).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //车主姓名（企业名称）输入框
    self.carNameTF = [[UITextField alloc] init];
    self.carNameTF.placeholder = @"请输入车主姓名";
    self.carNameTF.font = [UIFont systemFontOfSize:13*WIDTH];
    self.carNameTF.textColor = LYColor_A3;
    [ownerView addSubview:self.carNameTF];
    [self.carNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(131*WIDTH));
        make.centerY.equalTo(self.PerName);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];

    
//    间隔线8
    UILabel *line8 = [[UILabel alloc] init];
    line8.backgroundColor = LYColor_A6;
    [ownerView addSubview:line8];
    [line8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view);
        make.top.mas_equalTo(self.PerName.mas_bottom).with.offset(21*HEIGHT);
        make.height.equalTo(@(0.5));
    }];
    
    
    //身份证号（组织机构代码）
    self.cardNo  = [[UILabel alloc] init];
    self.cardNo.textColor = LYColor_A4;
    self.cardNo.text = @"身份证号";
    self.cardNo.font = [UIFont systemFontOfSize:14*WIDTH];
    [ownerView addSubview:self.cardNo];
    [self.cardNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(line8).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //身份证号（组织机构代码）输入框
    self.cardNumTF = [[UITextField alloc] init];
    self.cardNumTF.placeholder = @"请输入证件号";
    self.cardNumTF.font = [UIFont systemFontOfSize:13*WIDTH];
    self.cardNumTF.textColor = LYColor_A3;
    [ownerView addSubview:self.cardNumTF];
    [self.cardNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(131*WIDTH));
        make.centerY.equalTo(self.cardNo);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];

    //    间隔线9
    UILabel *line9 = [[UILabel alloc] init];
    line9.backgroundColor = LYColor_A6;
    [ownerView addSubview:line9];
    [line9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view);
        make.top.mas_equalTo(self.cardNo.mas_bottom).with.offset(21*HEIGHT);
        make.height.equalTo(@(0.5));
    }];
    
    
    //联系电话
    UILabel *phoneLab  = [[UILabel alloc] init];
    phoneLab.textColor = LYColor_A4;
    phoneLab.text = @"联系电话";
    phoneLab.font = [UIFont systemFontOfSize:14*WIDTH];
    [ownerView addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(line9).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    
    //联系电话
    self.carPhoneTF = [[UITextField alloc] init];
    self.carPhoneTF.placeholder = @"请输入电话号码";
    self.carPhoneTF.font = [UIFont systemFontOfSize:13*WIDTH];
    self.carPhoneTF.textColor = LYColor_A3;
    [ownerView addSubview:self.carPhoneTF];
    [self.carPhoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(131*WIDTH));
        make.centerY.equalTo(phoneLab);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 13*HEIGHT));
    }];
    
    UIButton *tiJiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tiJiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tiJiaoBtn setTitle:@"提交" forState:UIControlStateNormal];
    tiJiaoBtn.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH];
    [tiJiaoBtn addTarget:self action:@selector(tiJiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    tiJiaoBtn.backgroundColor = LYColor_A1;
    tiJiaoBtn.layer.cornerRadius = 4.0f;
    tiJiaoBtn.clipsToBounds = YES;
    [self.scrollView addSubview:tiJiaoBtn];
    [tiJiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view).with.offset(-18*WIDTH);;
        make.top.mas_equalTo(ownerView.mas_bottom).with.offset(31*HEIGHT);
        make.height.equalTo(@(44*HEIGHT));
    }];
}

//相机
-(void)photoClick
{
    
}


//在哪看车辆信息
-(void)whereBtnClick{
    [self.view endEditing:YES];
    [self.view addSubview:self.photoView];
}
//注册时间
-(void)zhuceClick{
    [[LGLDatePickerView shareDatePiker] datePikerShowWithMode:LGLDatePickerModeDate];
    [[LGLDatePickerView shareDatePiker] dateCallBackSelectBlock:^(NSString *date) {
        self.zhuTimeLab.text = date;
        self.zhuTimeLab.textColor = LYColor_A3;
    }];
}
//交强险起保时间
-(void)jiaoqiangClick{
    [[LGLDatePickerView shareDatePiker] datePikerShowWithMode:LGLDatePickerModeDate];
    [[LGLDatePickerView shareDatePiker] dateCallBackSelectBlock:^(NSString *date) {
        self.jiaoTimeLab.text = date;
        self.jiaoTimeLab.textColor = LYColor_A3;
    }];
}
//商业险起保时间
-(void)shangyeClick{
    [[LGLDatePickerView shareDatePiker] datePikerShowWithMode:LGLDatePickerModeDate];
    [[LGLDatePickerView shareDatePiker] dateCallBackSelectBlock:^(NSString *date) {
        self.shangTimeLab.text = date;
        self.shangTimeLab.textColor = LYColor_A3;
    }];
}
//是否是过户车辆第一次
-(void)carTypeClick:(UIButton *)sender
{
    if (sender.selected == YES) {
        sender.selected = NO;
        self.selectImg.image = [UIImage imageNamed:@"gouxuanxincheweishangpai"];
        index=0;
    }else{
        sender.selected = YES;
        self.selectImg.image = [UIImage imageNamed:@"weigouxuan(xincheweishangpai)"];
        index = 1;
    }
}
//企业（个人）车辆
-(void)changeBtnClick:(UIButton *)sender
{
    if (sender.selected == YES) {
        sender.selected = NO;
        [sender setTitle:@"企业车辆" forState:UIControlStateNormal];
        self.carNameTF.placeholder = @"请输入车主姓名";
        self.cardNumTF.placeholder = @"请输入证件号";
        self.PerName.text = @"车主姓名";
        self.cardNo.text = @"身份证号";
        
    }else{
        sender.selected = YES;
        [sender setTitle:@"个人车辆" forState:UIControlStateNormal];
        self.carNameTF.placeholder = @"请输入企业名称";
        self.PerName.text = @"企业名称";
        self.cardNo.text = @"组织机构代码";
        self.cardNumTF.placeholder = @"请输入代码号";

        
    }
}
//提交
-(void)tiJiaoBtnClick{
    
    if ([self.carTypeTF.text isEqualToString:@""]) {
        SVProgress(@"请输入品牌型号");
    }else if ([self.shiBieTF.text isEqualToString:@""]){
        SVProgress(@"请输入车辆识别代码");
    }else if ([self.faDongTF.text isEqualToString:@""]){
        SVProgress(@"请输入发动机号");
    }else if ([self.zhuTimeLab.text isEqualToString:@"请选择"]||[self.zhuTimeLab.text isEqualToString:@""]){
        SVProgress(@"请选择注册时间");
    }else if ([self.zaiCountLab.text isEqualToString:@""]){
        SVProgress(@"请输入荷载人数");
    }else if ([self.jiaoTimeLab.text isEqualToString:@""]||[self.jiaoTimeLab.text isEqualToString:@"请选择"]){
        SVProgress(@"请选择交强险起保时间");
    }else if ([self.shangTimeLab.text isEqualToString:@""]||[self.shangTimeLab.text isEqualToString:@"请选择"]){
        SVProgress(@"请选择商业险起保时间");
    }else if ([self.carNameTF.text isEqualToString:@""]){
        SVProgress(@"请输入车主姓名");
    }else if ([self.cardNumTF.text isEqualToString:@""]){
        SVProgress(@"请输入证件号码");
    }else if ([self.carPhoneTF.text isEqualToString:@""]){
        SVProgress(@"请输入联系电话");
    }else{
        [DataGreatWall PostTheCarMsgWithTheAddserialId:self.serialId WithextractComp:@"0" WithmodelType:self.carTypeTF.text WithvinNo:self.shiBieTF.text WithengineNo:self.faDongTF.text WithfirstRegDate:self.zhuTimeLab.text Withseats:self.zaiCountLab.text WithsyStartDate:self.shangTimeLab.text WithjqStartDate:self.jiaoTimeLab.text WithtransferFlag:[NSString stringWithFormat:@"%ld",index] WithtransferDate:@"" WithdriveName:self.carNameTF.text WithidNo: self.cardNumTF.text Withmobile:self.carPhoneTF.text WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
            self.hidesBottomBarWhenPushed=YES;
            CarSelectController *baseVC = [[CarSelectController alloc] init];
            [self.navigationController pushViewController:baseVC animated:YES];
            
        }];
    }
    
}

-(void)CarMsgbackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  -------Controller-------
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight-64)];
        _scrollView.contentSize = CGSizeMake(0, 900*HEIGHT);
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.backgroundColor = LYColor_A7;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

-(CarPhotoView *)photoView{
    if (!_photoView) {
        _photoView = [[CarPhotoView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight-64)];
    }
    return _photoView;
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
