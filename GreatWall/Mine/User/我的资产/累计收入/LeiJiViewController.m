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
#import "LeiJiShouRuModel.h"
@interface LeiJiViewController ()
@property (nonatomic, strong)UITableView *leijiList;
@property (nonatomic, strong)NSMutableArray *listArray;

@end

@implementation LeiJiViewController

-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏文字颜色及大小
    [self.rootBackBtn setImage:[UIImage imageNamed:@"jiantou_bai.png"] forState:UIControlStateNormal];
    self.navigationController.navigationBar.barTintColor = LYColor_A1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"累计收入";
    [self getData];
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
#pragma mark - 数据解析
- (void)getData{
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
    //    monthArr = [[myArr reverseObjectEnumerator] allObjects];//数组元素调整顺序
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
            self.moneyLabel.text =  [NSString stringWithFormat:@"%.2f",[responseObject[@"output"][@"totalAmount"] floatValue] / 100];
            NSArray *arr = responseObject[@"output"][@"totalIncomeList"];
            for (NSDictionary *dic in arr) {
                LeiJiShouRuModel *model = [[LeiJiShouRuModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.listArray addObject:model];
            }
            [self.leijiList reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
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
    cell.leiJiModel = self.listArray[indexPath.row];

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
        _leijiList.tableFooterView= [[UIView alloc]initWithFrame:CGRectZero];
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
