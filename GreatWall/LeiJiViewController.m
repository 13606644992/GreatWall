//
//  LeiJiViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/12.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "LeiJiViewController.h"
#import "Header.h"
#import "LeijiTableViewCell.h"
@interface LeiJiViewController ()
@property (nonatomic, strong)UITableView *leijiList;

@end

@implementation LeiJiViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏文字颜色及大小
    [self.rootBackBtn setImage:[UIImage imageNamed:@"jiantou_bai.png"] forState:UIControlStateNormal];
    self.navigationController.navigationBar.barTintColor = LYColor_A1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"累计收入";
    
    UIImageView *myIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiesuan-shouru.png"]];
    myIMGView.backgroundColor = LYColor_A7;
    //    myIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:myIMGView];
    [myIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(148*HEIGHT);
    }];
    
    [myIMGView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(myIMGView);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, HEIGHT * 40));
    }];
    
    [self.view addSubview:self.leijiList];
    [self.leijiList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myIMGView.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    //重新设置分割线
    if ([self.leijiList respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.leijiList setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [self.leijiList setSeparatorColor:LYColor_A6];
}
- (void)getData{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
     LeijiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LeijiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.date.text  = @"2016年12月";
    cell.money.text = @"1290.87";

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49*HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42)];
    headerView.backgroundColor = LYColor_A7;
    UILabel *month = [[UILabel alloc]init];
    month.font = [UIFont systemFontOfSize:13*HEIGHT];
    month.textColor = LYColor_A3;
    month.textAlignment = NSTextAlignmentLeft;
    month.text = @"最近6个月收入";
    [headerView addSubview:month];
    [month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18.5*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 13*HEIGHT));
    }];
    
    return headerView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}
//自定义section头部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42.0*HEIGHT;
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
- (UITableView *)leijiList{
    if (!_leijiList) {
        _leijiList = [[UITableView alloc]init];
        _leijiList.delegate = self;
        _leijiList.dataSource = self;
        _leijiList.backgroundColor = [UIColor whiteColor];
        //        _JieSuanList.bounces = NO;
    }
    return _leijiList;
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
