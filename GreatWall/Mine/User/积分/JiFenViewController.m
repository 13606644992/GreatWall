//
//  JiFenViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "JiFenViewController.h"
#import "Header.h"
#import "JiFenTableViewCell.h"
#import "JiFenModel.h"
@interface JiFenViewController ()
@property (nonatomic, strong)UIButton *qiandaoBtn;
@property (nonatomic, strong)UILabel *tixingLabel;
@end

@implementation JiFenViewController
{
    UITableView *jifenList;
    NSMutableArray *dataArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.rootBackBtn setImage:[UIImage imageNamed:@"jiantou_bai.png"] forState:UIControlStateNormal];
    self.navigationController.navigationBar.barTintColor = LYColor_A1;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏文字颜色及大小
    self.navigationController.navigationBar.translucent = NO;
    StatusBarWhite;
    NSLog(@"2");
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的积分";
    //右上角按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"baiwenhao-bai.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction)];
    backItem.tintColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0];
    self.navigationItem.rightBarButtonItem = backItem;
    
    UIImageView *myIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiesuan-shouru.png"]];
    myIMGView.backgroundColor = LYColor_A7;
    //    myIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:myIMGView];
    [myIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(148*HEIGHT);
    }];
    myIMGView.userInteractionEnabled = YES;
    [myIMGView addSubview:self.jifenLabel];
    [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20*HEIGHT);
        make.centerX.mas_equalTo(myIMGView);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 37*HEIGHT));
    }];
    
    [myIMGView addSubview:self.qiandaoBtn];
    [self.qiandaoBtn setTitle:@"签到" forState:UIControlStateNormal];
    [self.qiandaoBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [self.qiandaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jifenLabel.mas_bottom).with.offset(20*HEIGHT);
        make.centerX.mas_equalTo(myIMGView);
        make.size.mas_equalTo(CGSizeMake(74*WIDTH, 24*HEIGHT));
    }];
    
    [myIMGView addSubview:self.tixingLabel];
    self.tixingLabel.text = @"签到可获得10积分";
    [self.tixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.qiandaoBtn.mas_bottom).with.offset(13*HEIGHT);
        make.centerX.mas_equalTo(myIMGView);
        make.size.mas_equalTo(CGSizeMake(300*WIDTH, 13*HEIGHT));
    }];
    
    //列表
    jifenList = [[UITableView alloc]init];
    jifenList.backgroundColor = [UIColor whiteColor];
    jifenList.delegate = self;
    jifenList.dataSource = self;
    [self.view addSubview:jifenList];
    [jifenList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myIMGView.mas_bottom);
        make.left.and.right.bottom.mas_equalTo(0);
    }];
    jifenList.showsVerticalScrollIndicator = NO;
    //重新设置分割线
    if ([jifenList respondsToSelector:@selector(setSeparatorInset:)]) {
        [jifenList setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [jifenList setSeparatorColor:LYColor_A6];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GJ_isLogin"]) {
        [self getJiFenListData]; //获取积分数据
    }
    //初始化数组
    dataArray = [NSMutableArray array];
}
/**
 获取积分数据
 */
- (void)getJiFenListData{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"], @"acctType" : @"10", @"pageIndex" : @"1"}]; //pageIndex 暂时写死，这里要做分页
    [GJAFNetWork POST:URL_ALIANG params:params method:@"getAccountDetail" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"积分%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSArray *arr = responseObject[@"output"][@"accountDetailList"];
            for (NSDictionary *dic in arr) {
                JiFenModel *model = [[JiFenModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
            }
            [jifenList reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    JiFenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JiFenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    JiFenModel *model = [dataArray objectAtIndex:indexPath.row];
    cell.title.text = model.tradeDesc;
    cell.jifen.text = [NSString stringWithFormat:@"%@", model.tradeAmount];
//    时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.logTime integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    cell.date.text = [dateFormatter stringFromDate:date];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68*HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42)];
    headerView.backgroundColor = LYColor_A7;
    UILabel *title = [[UILabel alloc]init];
    title.font = [UIFont systemFontOfSize:13*HEIGHT];
    title.textColor = LYColor_A3;
    title.textAlignment = NSTextAlignmentLeft;
    title.text = @"收支明细";
    [headerView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
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


- (void)rightBtnAction{
    NSLog(@"问号");
    
}
- (void)qiandaoBtnAction:(UIButton *)sender{
    NSLog(@"签到");
}

/*   懒加载*/
- (UILabel *)jifenLabel{
    if (!_jifenLabel) {
        _jifenLabel = [[UILabel alloc]init];
        _jifenLabel.font = [UIFont systemFontOfSize:36*HEIGHT];
        _jifenLabel.textColor = [UIColor whiteColor];
        _jifenLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _jifenLabel;
}
- (UIButton *)qiandaoBtn{
    if (!_qiandaoBtn) {
        _qiandaoBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        _qiandaoBtn.backgroundColor = [UIColor whiteColor];
        _qiandaoBtn.layer.cornerRadius = 2.0;
        [_qiandaoBtn addTarget:self action:@selector(qiandaoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _qiandaoBtn.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    }
    return _qiandaoBtn;
}
- (UILabel *)tixingLabel{
    if (!_tixingLabel) {
        _tixingLabel = [[UILabel alloc]init];
        _tixingLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        _tixingLabel.textColor = [UIColor whiteColor];
        _tixingLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tixingLabel;
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
