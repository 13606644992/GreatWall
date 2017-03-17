//
//  PerInsureController.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/17.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "PerInsureController.h"
#import "Header.h"
#import "ChitInfoCell.h"
#import "PolicyholderCell.h"
#import "InsuredPerCell.h"
#import "InsureNameCell.h"
#import "CollectionViewCell.h"
#import "ReducePayCell.h"
#import "RealPayCell.h"

@interface PerInsureController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *headerTitles;
    UIColor *typeColor;
    UIButton *payButton;
}
@property (nonatomic ,strong) UITableView *tabView;
@property (nonatomic ,strong) PayTrade *trade;

@end

@implementation PerInsureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYColor_A7;
    typeColor = LYColor_A3;
    headerTitles = @[@"保单信息",@"投保人信息",@"被保人信息",@"保障内容"];
    [self setThePerInsureTopView];
    [self setThePerInsureBottomView];
    [self.view addSubview:self.tabView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    typeColor = LYColor_A3;
    payButton.backgroundColor = LYColor_A1;
    [payButton setTitle:@"去支付" forState:UIControlStateNormal];
    payButton.userInteractionEnabled = YES;
    [DataGreatWall PostTheTradeDetailWithTheTradeID:self.tradeId WithTheDetailId:@"" WithTheBlock:^(NSString *respCode, NSString *respMsg, PayTrade *model, NSError *error) {
        if (error) {
            
        }else if ([respCode isEqualToString:@"000000"]){
            self.trade = model;
            if ([self.trade.sts isEqualToString:@"-11"]) {
                typeColor = LYColor_A4;
                payButton.backgroundColor = LYColor_A4;
                [payButton setTitle:@"已失效" forState:UIControlStateNormal];
                payButton.userInteractionEnabled = NO;
            }else if ([self.trade.sts isEqualToString:@"20"]){
                typeColor = LYColor_A4;
                payButton.backgroundColor = LYColor_A1;
                [payButton setTitle:@"再次购买" forState:UIControlStateNormal];
                payButton.userInteractionEnabled = YES;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabView reloadData];
            });
            
        }else{
            
        }
    }];
}
-(void)setThePerInsureTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"订单详情";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = LYColor_A1;
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(orderbackClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];
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
-(void)payOrderClick:(UIButton *)sender
{
    NSLog(@"--zaici");
}
-(void)orderbackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 4) {
        return 13*HEIGHT;
    }
    return 40*HEIGHT;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0||section == 1||section == 2) {
        return 1;
    }else if (section == 3||section == 4){
        return 2;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 160*HEIGHT;
    }else if (indexPath.section == 1){
        return 135*HEIGHT;
    }else if (indexPath.section == 2){
        return 56*HEIGHT;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            return 65*HEIGHT;
        }
        if (self.trade.typeList.count>0) {
            OrderType *type = self.trade.typeList[0];
            return 139*HEIGHT+type.insureList.count*41*HEIGHT;
        }
        return 139*HEIGHT;
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            return 108*HEIGHT;
        }
        return 56*HEIGHT;
    }
    return 65*HEIGHT;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 4) {
        return [self setTheTitleViewWithTitle:headerTitles[section]];
    }
    return nil;
}
-(UIView *)setTheTitleViewWithTitle:(NSString *)title
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 40*HEIGHT)];
    //    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:12*WIDTH];
    titleLab.textColor = LYColor_A4;
    titleLab.text = title;
    [headerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.centerY.equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 12*HEIGHT));
    }];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 110*HEIGHT;
    }
    return 0.1f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return [self setTheFourthFooderView];
    }
    return nil;
}
-(UIView *)setTheFourthFooderView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 110*HEIGHT)];
    UIImageView *footerImg = [[UIImageView alloc] init];
    footerImg.image = [UIImage imageNamed:@"tishi"];
    [footerView addSubview:footerImg];
    [footerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).with.offset(18*WIDTH);
        make.top.equalTo(footerView).with.offset(12*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*HEIGHT));
    }];
    UILabel *tishiLab = [[UILabel alloc] init];
    tishiLab.textColor = LYColor_A4;
    tishiLab.text = @"温馨提示：本产品由平安健康保险股份有限公司承保。";
    tishiLab.font = [UIFont systemFontOfSize:12*WIDTH];
    [footerView addSubview:tishiLab];
    [tishiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footerImg.mas_right).with.offset(11.5f*WIDTH);
        make.top.bottom.equalTo(footerImg);
        make.right.equalTo(footerView).with.offset(-18*WIDTH);
    }];
    UILabel *phoneLab = [[UILabel alloc] init];
    phoneLab.textColor = LYColor_A4;
    phoneLab.text = @"联系电话：95588";
    phoneLab.font = [UIFont systemFontOfSize:12*WIDTH];
    [footerView addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footerImg.mas_right).with.offset(11.5f*WIDTH);
        make.top.mas_equalTo(footerImg.mas_bottom).with.offset(11*WIDTH);
        make.height.equalTo(@(12*HEIGHT));
        make.right.equalTo(footerView).with.offset(-18*WIDTH);
    }];
    return footerView;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ChitInfoCell *cell = [ChitInfoCell cellWithTheChitInfoTableView:tableView];
        cell.trade = self.trade;
        return cell;
    }else if (indexPath.section == 1){
        PolicyholderCell *cell = [PolicyholderCell cellWithThePolicyHoderTableView:tableView];
        cell.trade = self.trade;
        return cell;
    }else if (indexPath.section == 2){
        InsuredPerCell *cell = [InsuredPerCell cellWithTheInsureTableView:tableView];
        cell.trade = self.trade;
        return cell;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            InsureNameCell *cell = [InsureNameCell cellWithTheInsureNameTableView:tableView];
            cell.trade = self.trade;
            return cell;
        }
        CollectionViewCell *cell = [CollectionViewCell cellWithTheCollectionViewTableView:tableView];
        cell.trade = self.trade;
        return cell;
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            ReducePayCell *cell = [ReducePayCell cellWithTheReducePayCellTableView:tableView];
            cell.trade = self.trade;
            return cell;
        }
        RealPayCell *cell = [RealPayCell cellWithTheRealPayTableView:tableView];
        cell.trade = self.trade;
        return cell;
    }
    return nil;
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
