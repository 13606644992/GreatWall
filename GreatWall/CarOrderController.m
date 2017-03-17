//
//  CarOrderController.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/8.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CarOrderController.h"
#import "Header.h"

@interface CarOrderController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *payButton;

}
@property (nonatomic ,strong) UITableView *tabView;

@end

@implementation CarOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYColor_A7;

    [self LoadTheCarInsureTopView];
}
-(void)LoadTheCarInsureTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"订单确认";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = LYColor_A1;
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(carOrderbackClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)setThePerInsureBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(59*HEIGHT+0.5));
    }];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 0.5)];
    line.backgroundColor = [LYColor colorWithHexString:@"#e3e3e3"];
    [bottomView addSubview:line];
    payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.backgroundColor = LYColor_A1;
    payButton.layer.cornerRadius = 2.0f;
    payButton.clipsToBounds = YES;
    [payButton addTarget:self action:@selector(payOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [payButton setTitle:@"去支付" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).with.offset(18*WIDTH);
        make.right.equalTo(bottomView).with.offset(-18*WIDTH);
        make.top.equalTo(@(5*HEIGHT));
        make.bottom.equalTo(@(-5*HEIGHT));
    }];
    
}

-(void)carOrderbackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -------Controller---------
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWindowWidth, ScreenWindowHeight - 59*HEIGHT - 64.5) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        //        _tabView.backgroundColor = LYColor_A7;
        _tabView.rowHeight = 56*HEIGHT;
        _tabView.separatorColor = [UIColor clearColor];
    }
    return _tabView;
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
