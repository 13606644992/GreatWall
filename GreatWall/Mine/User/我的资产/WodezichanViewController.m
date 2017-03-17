//
//  WodezichanViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "WodezichanViewController.h"
#import "Header.h"
#import "AddBankCardViewController.h"
#import "JieSuanViewController.h"
#import "LeiJiViewController.h"
#import "MingXiViewController.h"
#import "BenYueSRVC.h"

@interface WodezichanViewController ()
@property (nonatomic, strong)UIButton *mingxiBtn;

@end

@implementation WodezichanViewController
{
    UIView *footView;
    NSArray *monthArr;
    NSMutableArray *ziChanArr;
    NSMutableArray *pingJunArr;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.barTintColor = LYColor_A1;
    self.navigationController.navigationBar.translucent = NO;
    [self.rootBackBtn setImage:[UIImage imageNamed:@"jiantou_bai.png"] forState:UIControlStateNormal];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏文字颜色及大小
    StatusBarWhite;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getMyZiChanData];
    [self getZheXianData];
    self.navigationItem.title = @"我的资产";
    //明细按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.mingxiBtn];
    
    UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wodezichan.png"]];
    background.backgroundColor = LYColor_A7;
//    background.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(229*HEIGHT);
    }];
    background.userInteractionEnabled = YES;
    //钱数
    [background addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(28*HEIGHT);
        make.centerX.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(240*WIDTH, 37*HEIGHT));
    }];
//    self.moneyLabel.text = @"478.88";
    UILabel *ketixian = [[UILabel alloc]init];
    ketixian.backgroundColor = [UIColor clearColor];
    ketixian.textColor = [UIColor whiteColor];
    ketixian.text = @"可提现 (元)";
    ketixian.textAlignment = NSTextAlignmentCenter;
    ketixian.font = [UIFont systemFontOfSize:11*HEIGHT];
    [background addSubview:ketixian];
    [ketixian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(background);
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).with.offset(10*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 10*HEIGHT));
    }];
    //提现按钮
    UIButton *tixianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tixianBtn.backgroundColor = [UIColor whiteColor];
    [tixianBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    tixianBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [tixianBtn setTitle:@"提现" forState:UIControlStateNormal];
    tixianBtn.layer.cornerRadius = 2.0f;
    [tixianBtn addTarget:self action:@selector(tixianBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:tixianBtn];
    [tixianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(background);
        make.top.mas_equalTo(ketixian.mas_bottom).with.offset(19*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(74*WIDTH, 24*HEIGHT));
    }];
    
    UIView *myView=  [[UIView alloc]init];
    myView.backgroundColor = [UIColor whiteColor];
    [background addSubview:myView];
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*WIDTH);
        make.right.mas_equalTo(-13*WIDTH);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(85*HEIGHT);
    }];
    [myView layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:myView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = myView.bounds;
    maskLayer.path = maskPath.CGPath;
    myView.layer.mask = maskLayer;
    //竖线
    UILabel *line1 = [[UILabel alloc]init];
    line1.backgroundColor = LYColor_A6;
    [myView addSubview:line1];
    UILabel *line2 = [[UILabel alloc]init];
    line2.backgroundColor = LYColor_A6;
    [myView addSubview:line2];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(myView);
        make.size.mas_equalTo(CGSizeMake(1, 32*HEIGHT));
        make.left.mas_equalTo((myView.frame.size.width - 2) / 3);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(myView);
        make.size.mas_equalTo(CGSizeMake(1, 32*HEIGHT));
        make.right.mas_equalTo(-(myView.frame.size.width - 2) / 3);
    }];
    //本月收入、结算中、累计收入

    [myView addSubview:self.benyueshouru];
     [myView addSubview:self.jiesuanzhong];
     [myView addSubview:self.leijishouru];
    [self.benyueshouru mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24*HEIGHT);
        make.centerX.mas_equalTo(myView).with.offset(-(myView.frame.size.width - 2) / 3);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 16*HEIGHT));
    }];
    [self.jiesuanzhong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24*HEIGHT);
        make.centerX.mas_equalTo(myView);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 16*HEIGHT));
    }];
    [self.leijishouru mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24*HEIGHT);
        make.centerX.mas_equalTo(myView).with.offset((myView.frame.size.width - 2) / 3);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 16*HEIGHT));
    }];
    UILabel *benyue = [[UILabel alloc]init];
    benyue.backgroundColor = [UIColor whiteColor];
    benyue.text = @"本月收入";
    benyue.textColor = LYColor_A3;
    benyue.font = [UIFont systemFontOfSize:11*HEIGHT];
    benyue.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:benyue];
    UILabel *jiesuan = [[UILabel alloc]init];
    jiesuan.backgroundColor = [UIColor whiteColor];
    jiesuan.text = @"结算中";
    jiesuan.textColor = LYColor_A3;
    jiesuan.font = [UIFont systemFontOfSize:11*HEIGHT];
    jiesuan.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:jiesuan];
    UILabel *leiji = [[UILabel alloc]init];
    leiji.backgroundColor = [UIColor whiteColor];
    leiji.text = @"累计收入";
    leiji.textColor = LYColor_A3;
    leiji.font = [UIFont systemFontOfSize:11*HEIGHT];
    leiji.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:leiji];
    
    [benyue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.benyueshouru.mas_bottom).with.offset(10*HEIGHT);
        make.centerX.mas_equalTo(self.benyueshouru);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 11*HEIGHT));
    }];
    [jiesuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jiesuanzhong.mas_bottom).with.offset(10*HEIGHT);
        make.centerX.mas_equalTo(self.jiesuanzhong);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 11*HEIGHT));
    }];
    [leiji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leijishouru.mas_bottom).with.offset(10*HEIGHT);
        make.centerX.mas_equalTo(self.leijishouru);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 11*HEIGHT));
    }];
    UIImageView *yinyingIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yinying-zichan.png"]];
    yinyingIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [myView addSubview:yinyingIMGView];
    [yinyingIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(6*HEIGHT);
    }];
    
    
    footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(13*HEIGHT);
        make.left.and.right.bottom.mas_equalTo(0);
    }];
    
    UIButton *benYueShouRu = [UIButton buttonWithType:UIButtonTypeCustom];
    benYueShouRu.backgroundColor = [UIColor clearColor];
    benYueShouRu.alpha = 0.7;
    [myView addSubview:benYueShouRu];
    [benYueShouRu addTarget:self action:@selector(benYueShouRuAction:) forControlEvents:UIControlEventTouchUpInside];
    [benYueShouRu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jiesuanzhong).with.offset(-10*HEIGHT);
        make.bottom.mas_equalTo(jiesuan).with.offset(10*HEIGHT);
        make.width.mas_equalTo(self.jiesuanzhong);
        make.centerX.mas_equalTo(self.benyueshouru);
    }];
    
    UIButton *jiesuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jiesuanBtn.backgroundColor = [UIColor clearColor];
    jiesuanBtn.alpha = 0.7;
    [myView addSubview:jiesuanBtn];
    [jiesuanBtn addTarget:self action:@selector(JieSuanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [jiesuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jiesuanzhong).with.offset(-10*HEIGHT);
        make.bottom.mas_equalTo(jiesuan).with.offset(10*HEIGHT);
        make.width.mas_equalTo(self.jiesuanzhong);
        make.centerX.mas_equalTo(self.jiesuanzhong);
    }];
    
    UIButton *leijiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leijiBtn.backgroundColor = [UIColor clearColor];
    leijiBtn.alpha = 0.7;
    [myView addSubview:leijiBtn];
    [leijiBtn addTarget:self action:@selector(LeiJiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [leijiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jiesuanzhong).with.offset(-10*HEIGHT);
        make.bottom.mas_equalTo(jiesuan).with.offset(10*HEIGHT);
        make.width.mas_equalTo(self.jiesuanzhong);
        make.centerX.mas_equalTo(self.leijishouru);
    }];
    
    UILabel *myLabel = [[UILabel alloc]init];
    myLabel.text = @"最近六个月收入走势";
    myLabel.textColor = LYColor_A3;
    myLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [myLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [footView addSubview:myLabel];
    [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.height.mas_equalTo(15*HEIGHT);
    }];
    UIView *green = [[UIView alloc]init];
    green.backgroundColor = LYColor_A1;
    [footView addSubview:green];
    [green mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(myLabel);
        make.left.mas_equalTo(myLabel.mas_right).with.offset(30*WIDTH);
        make.size.mas_equalTo(CGSizeMake(18*WIDTH, 5*HEIGHT));
    }];
    UILabel *zichan = [[UILabel alloc]init];
    zichan.text = @"我的资产";
    zichan.textColor = LYColor_A3;
    zichan.font = [UIFont systemFontOfSize:11*HEIGHT];
    [zichan setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [footView addSubview:zichan];
    [zichan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(myLabel);
        make.left.mas_equalTo(green.mas_right).with.offset(10*WIDTH);
        make.height.mas_equalTo(11*HEIGHT);
    }];
    UIView *orange = [[UIView alloc]init];
    orange.backgroundColor = LYColor_A2;
    [footView addSubview:orange];
    [orange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(myLabel);
        make.left.mas_equalTo(zichan.mas_right).with.offset(13*WIDTH);
        make.size.mas_equalTo(CGSizeMake(18*WIDTH, 5*HEIGHT));
    }];
    UILabel *pingjun = [[UILabel alloc]init];
    pingjun.text = @"平台平均值";
    pingjun.textColor = LYColor_A3;
    pingjun.font = [UIFont systemFontOfSize:11*HEIGHT];
    [pingjun setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [footView addSubview:pingjun];
    [pingjun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(myLabel);
        make.left.mas_equalTo(orange.mas_right).with.offset(10*WIDTH);
        make.height.mas_equalTo(11*HEIGHT);
    }];

}
#pragma mark~          折线图
- (void)addPNChart{
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(18*WIDTH, 65*HEIGHT, 360*WIDTH, 280*HEIGHT)];
    lineChart.backgroundColor = [UIColor whiteColor];
    [footView addSubview:lineChart];
    lineChart.delegate = self;
    lineChart.contentMode = UIViewContentModeScaleAspectFit;
//    lineChart.showCoordinateAxis = YES;
//    lineChart.showSmoothLines = YES;
    lineChart.showYGridLines = YES;
//    lineChart.axisColor = LYColor_A1;
    lineChart.yGridLinesColor = LYColor_A5;
    lineChart.yLabelColor = LYColor_A4;
    lineChart.yLabelFont = [UIFont systemFontOfSize:14.0f];
    [lineChart setXLabels:monthArr];
    // Line Chart No.1
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = LYColor_A1;
    data01.itemCount = lineChart.xLabels.count;
    data01.inflexionPointStyle = PNScatterChartPointStyleSquare;
    data01.lineWidth = 2.0f;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [ziChanArr[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@14000, @1800, @2400, @3000, @1262, @2000];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = LYColor_A2;

    data02.itemCount = lineChart.xLabels.count;
    data02.inflexionPointStyle = PNScatterChartPointStyleSquare;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
}
- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex {
    
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}
- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex {
    
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
    
    //在这个位置弹出逻辑
}
/**
 结算页面
 */
- (void)benYueShouRuAction:(UIButton *)sender{
    NSLog(@"跳转到本月收入页面");
    self.hidesBottomBarWhenPushed = YES;
    BenYueSRVC *vc= [[BenYueSRVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)JieSuanBtnAction:(UIButton *)sender{
    NSLog(@"跳转到结算页面");
    self.hidesBottomBarWhenPushed = YES;
    JieSuanViewController *jiesuanVC = [[JieSuanViewController alloc]init];
    [self.navigationController pushViewController:jiesuanVC animated:YES];
//    jiesuanVC.moneyLabel.text = self.jiesuanzhong.text;
}
- (void)LeiJiBtnAction:(UIButton *)sender{
    NSLog(@"跳转到累计收入页面");
    self.hidesBottomBarWhenPushed = YES;
    LeiJiViewController *leijiVC = [[LeiJiViewController alloc]init];
    [self.navigationController pushViewController:leijiVC animated:YES];
}
- (void)tixianBtnAction:(UIButton *)sender{
    NSLog(@"提现");
    self.hidesBottomBarWhenPushed = YES;
    AddBankCardViewController *VC = [[AddBankCardViewController alloc]init];
    VC.tiXianjinE = self.moneyLabel.text;
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)mingxiAction:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MingXiViewController *vc = [[MingXiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
- (UIButton *)mingxiBtn{
    if (!_mingxiBtn) {
        _mingxiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mingxiBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_mingxiBtn setTitle:@"明细" forState:UIControlStateNormal];
        _mingxiBtn.frame = CGRectMake(0, 0, 30, 30);
        [_mingxiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_mingxiBtn addTarget:self action:@selector(mingxiAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mingxiBtn;
}
- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = [UIFont systemFontOfSize:36*HEIGHT];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}
- (UILabel *)benyueshouru{
    if (!_benyueshouru) {
        _benyueshouru = [[UILabel alloc]init];
        _benyueshouru.textColor = LYColor_A3;
        _benyueshouru.font = [UIFont systemFontOfSize:16*HEIGHT];
        _benyueshouru.textAlignment = NSTextAlignmentCenter;
    }
    return _benyueshouru;
}
- (UILabel *)jiesuanzhong{
    if (!_jiesuanzhong) {
        _jiesuanzhong = [[UILabel alloc]init];
        _jiesuanzhong.textColor = LYColor_A3;
        _jiesuanzhong.font = [UIFont systemFontOfSize:16*HEIGHT];
        _jiesuanzhong.textAlignment = NSTextAlignmentCenter;
    }
    return _jiesuanzhong;
}
- (UILabel *)leijishouru{
    if (!_leijishouru) {
        _leijishouru = [[UILabel alloc]init];
        _leijishouru.textColor = LYColor_A3;
        _leijishouru.font = [UIFont systemFontOfSize:16*HEIGHT];
        _leijishouru.textAlignment = NSTextAlignmentCenter;
    }
    return _leijishouru;
}
#pragma mark- 我的资产
- (void)getMyZiChanData{
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":userId,@"acctType":@"20"}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"getAccount" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"========%@",responseObject);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSDictionary *dataDic = responseObject[@"output"];
            NSString *moneyStr = [NSString stringWithFormat:@"%@", dataDic[@"acctBalance"]];
            NSString *money = [NSString stringWithFormat:@"%.2f", [moneyStr floatValue] / 100 ];  //可提现
            self.moneyLabel.text = money;
            NSString *jiesuanzhongStr = [NSString stringWithFormat:@"%@", dataDic[@"acctSettSum"]];
            NSString *jiesuanzhong = [NSString stringWithFormat:@"%.2f", [jiesuanzhongStr floatValue] / 100 ];  //结算中
            self.jiesuanzhong.text = jiesuanzhong;
            NSString *benyueshouruStr = [NSString stringWithFormat:@"%@", dataDic[@"acctMonthSum"]];
            NSString *benyueshouru = [NSString stringWithFormat:@"%.2f", [benyueshouruStr floatValue] / 100 ];  //本月收入
            self.benyueshouru.text = benyueshouru;
            NSString *leijishouruStr = [NSString stringWithFormat:@"%@", dataDic[@"acctSum"]];
            NSString *leijishouru = [NSString stringWithFormat:@"%.2f", [leijishouruStr floatValue] / 100 ];  //累计收入
            self.leijishouru.text = leijishouru;
        }else{
            NSLog(@"respMsg==%@", responseObject[@"respMsg"]);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark - 折线图数据
- (void)getZheXianData{
    //初始化折线图 资产 / 平均  数组
    ziChanArr = [NSMutableArray array];
    pingJunArr = [NSMutableArray array];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"];
    NSDate *now = [NSDate date];
    NSDateFormatter *nowFormate = [[NSDateFormatter alloc] init];
    nowFormate.dateFormat = @"yyyy-MM-dd";
    NSString *nowTime = [nowFormate stringFromDate:now];
    NSString *monthStr = [nowTime substringWithRange:NSMakeRange(5, 2)];
    //生成月份数组
    NSMutableArray *myArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i ++) {
        [myArr addObject:monthStr];
        NSInteger month = [monthStr integerValue];
        month --;
        if (month == 0) {
            month = 12;
        }
        monthStr = [NSString stringWithFormat:@"%ld", month];
        
    }
    monthArr = [[myArr reverseObjectEnumerator] allObjects];//数组元素调整顺序
    NSLog(@"==%@",nowTime);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:now];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-5];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:now options:0];
    NSString *beforDate = [nowFormate stringFromDate:newdate];
    NSString *sixMonth = [beforDate stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
    NSLog(@"---前两个月 =%@",sixMonth);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":userId,@"acctType":@"20",@"beginDate":sixMonth,@"endDate":nowTime,@"pageIndex":@"1",@"pageSize":@"10"}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"getTotalIncome" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"------%@",responseObject);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSArray *arr = responseObject[@"output"][@"totalIncomeList"];
            for (NSDictionary *dic in arr) {
                NSString *money = dic[@"monthTotalAmount"];
                [ziChanArr addObject:money];
            }
            
            [self addPNChart];//添加折线图
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
