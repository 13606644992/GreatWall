//
//  CarSelectController.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/2.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CarSelectController.h"
#import "Header.h"
#import "CarSelectCell.h"
#import "CarTypeController.h"

@interface CarSelectController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger indexSelect;
}
@property (nonatomic ,strong) UITableView *tabView;
@end

@implementation CarSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择车型";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[LYColor colorWithHexString:@"#2dce8f"]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 10, 17.5);
    [backBtn addTarget:self action:@selector(CarSelectbackClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    indexSelect = 0;
    [self setTheBottomView];
    
    [self.view addSubview:self.tabView];
    
}

-(void)setTheBottomView{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(59*HEIGHT));
    }];
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = LYColor_A6;
    [bottomView addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bottomView);
        make.height.equalTo(@(0.5));
    }];
    
    UIButton *tiJiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tiJiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tiJiaoBtn setTitle:@"确认车型" forState:UIControlStateNormal];
    tiJiaoBtn.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH];
    [tiJiaoBtn addTarget:self action:@selector(queBtnClick) forControlEvents:UIControlEventTouchUpInside];
    tiJiaoBtn.backgroundColor = LYColor_A1;
    tiJiaoBtn.layer.cornerRadius = 4.0f;
    tiJiaoBtn.clipsToBounds = YES;
    [bottomView addSubview:tiJiaoBtn];
    [tiJiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(self.view).with.offset(-18*WIDTH);;
        make.top.equalTo(@(5*HEIGHT));
        make.bottom.equalTo(@(-5*HEIGHT));
    }];
}
//确认车型
-(void)queBtnClick{
    self.hidesBottomBarWhenPushed=YES;
    CarTypeController *baseVC = [[CarTypeController alloc] init];
    [self.navigationController pushViewController:baseVC animated:YES];
}
//不是以上车型
-(void)changeClick:(UIButton *)sender
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13*HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 138*HEIGHT;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self setTheFooterView];
}
-(UIView *)setTheFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 138*HEIGHT)];
    UILabel *xuanLab = [[UILabel alloc] init];
    xuanLab.text = @"请选择与您的车辆最匹配的车型";
    xuanLab.textColor = LYColor_A4;
    xuanLab.textAlignment = NSTextAlignmentCenter;
    xuanLab.font = [UIFont systemFontOfSize:12*WIDTH];
    [footerView addSubview:xuanLab];
    [xuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footerView);
        make.top.equalTo(@(27*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 12*HEIGHT));
    }];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.backgroundColor = [UIColor whiteColor];
    [changeBtn setTitle:@"不是以上车型" forState:UIControlStateNormal];
    [changeBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
    changeBtn.layer.cornerRadius = 4.0f;
    changeBtn.layer.borderWidth = 1.0f;
    changeBtn.layer.borderColor = LYColor_A1.CGColor;
    changeBtn.clipsToBounds = YES;
    [footerView addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footerView);
        make.top.mas_equalTo(xuanLab.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(159*WIDTH, 44*HEIGHT));
    }];
    return footerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarSelectCell *cell = [CarSelectCell CarSelectcellWithTableView:tableView];
    cell.xuanImg.hidden = YES;
    if (indexPath.row == indexSelect) {
        cell.xuanImg.hidden = NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexSelect = indexPath.row;
    [self.tabView reloadData];
    
    
    
}

-(void)CarSelectbackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------Controller-------
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWindowWidth, ScreenWindowHeight-64-59*HEIGHT) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.rowHeight = 108*HEIGHT;
        _tabView.showsVerticalScrollIndicator = NO;
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
