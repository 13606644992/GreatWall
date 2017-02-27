//
//  JieSuanViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "JieSuanViewController.h"
#import "Header.h"
#import "JieSuanTableViewCell.h"
@interface JieSuanViewController ()

@property (nonatomic, strong)UITableView *JieSuanList;
@end

@implementation JieSuanViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
     self.navigationController.navigationBar.translucent = NO;
     [self.rootBackBtn setImage:[UIImage imageNamed:@"jiantou_bai.png"] forState:UIControlStateNormal];
    self.navigationController.navigationBar.barTintColor = LYColor_A1;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"结算中";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏文字颜色及大小
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
    
    [myIMGView addSubview:self.moneyLabel];
//    self.moneyLabel.text = @"368.98";
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(myIMGView);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, HEIGHT * 40));
    }];
    
    [self.view addSubview:self.JieSuanList];
    [self.JieSuanList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myIMGView.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    //重新设置分割线
    if ([self.JieSuanList respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.JieSuanList setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [self.JieSuanList setSeparatorColor:LYColor_A6];
    [self getJieSuanListData]; //获取数据
}
- (void)getJieSuanListData{
    //获取时间
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM";
    NSString *dateString = [dateFormatter stringFromDate:date];
//    NSLog(@"%@", dateString);
   NSLog(@"%@", [self getMonthBeginAndEndWith:dateString]);
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"], @"acctType" : @"10", @"pageIndex" : @"1"}]; //pageIndex 暂时写死，这里要做分页
}
- (NSString *)getMonthBeginAndEndWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY.MM.dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];
    return s;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    JieSuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JieSuanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        cell.title.text = @"个人借款保证保险";
        cell.date.text = @"今天";
        cell.time.text = @"09:11";
        cell.money.text = @"+10.90";
    }else{
        cell.title.text = @"驾乘人员意外伤害险";
        cell.date.text = @"周一";
        cell.time.text = @"10:38";
        cell.money.text = @"+23.77";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68*HEIGHT;
}
- (void)rightBtnAction{
    NSLog(@"问号");
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42)];
    headerView.backgroundColor = LYColor_A7;
    UILabel *month = [[UILabel alloc]init];
    month.font = [UIFont systemFontOfSize:13*HEIGHT];
    month.textColor = LYColor_A3;
    month.textAlignment = NSTextAlignmentLeft;
    if (section == 0) {
        month.text = @"本月";
    }else{
        month.text = @"上个月";
    }
    [headerView addSubview:month];
    [month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18.5*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(50*WIDTH, 13*HEIGHT));
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
    return 42.0;
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
- (UITableView *)JieSuanList{
    if (!_JieSuanList) {
        _JieSuanList = [[UITableView alloc]init];
        _JieSuanList.delegate = self;
        _JieSuanList.dataSource = self;
        _JieSuanList.backgroundColor = [UIColor whiteColor];
    }
    return _JieSuanList;
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
