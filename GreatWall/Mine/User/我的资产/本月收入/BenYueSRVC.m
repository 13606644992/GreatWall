//
//  BenYueSRVC.m
//  GreatWall
//
//  Created by GJ on 2017/3/1.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "BenYueSRVC.h"
#import "Header.h"
#import "BenYueSRTableViewCell.h"
#import "BenYueModel.h"

@interface BenYueSRVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *leijiList;
@property (nonatomic, strong)NSMutableArray *listArray;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic, strong) NSString *monthStr;
//@property (nonatomic, strong) UIView *headerView;

@end

@implementation BenYueSRVC

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
    self.view.backgroundColor = LYColor_A1;
    [self getData];
    self.navigationItem.title = [NSString stringWithFormat:@"%@月账单",self.monthStr];
    
    
    [self.view addSubview:self.leijiList];
    [self.leijiList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
//        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    //tableviewHeaderView
//    self.leijiList.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, (148+13)*HEIGHT)];
    
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
    NSString *yearStr = [nowTime substringWithRange:NSMakeRange(0, 4)];
    self.monthStr = [nowTime substringWithRange:NSMakeRange(5, 2)];
    NSString *yueChuStr = [NSString stringWithFormat:@"%@-%@-01",yearStr,self.monthStr];
    NSLog(@"本月1号具体日期：%@",yueChuStr);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":userId,@"acctType":@"20",@"beginDate":yueChuStr,@"endDate":nowTime,@"pageIndex":@"1",@"pageSize":@"10"}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"getTotalIncomeDetail" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"------%@",responseObject);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            self.moneyLabel.text =  [NSString stringWithFormat:@"%.2f",[responseObject[@"output"][@"totalAmount"] floatValue] / 100];
            NSArray *arr = responseObject[@"output"][@"totalIncomeList"];
            for (NSDictionary *dic in arr) {
                BenYueModel *model = [[BenYueModel alloc]init];
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
    BenYueSRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BenYueSRTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.benYueModel = self.listArray[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68*HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, (148+13) *HEIGHT)];
    headerView.backgroundColor = LYColor_A7;
    UIImageView *myIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiesuan-shouru.png"]];
    myIMGView.backgroundColor = LYColor_A7;
    //    myIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:myIMGView];
    [myIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(148*HEIGHT);
    }];
    
    [myIMGView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(myIMGView);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, HEIGHT * 40));
    }];
    
    return headerView;
}

#pragma mark - 控制tableview的上下滑动
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.y < 0) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }
//}
//自定义section头部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (148+13)*HEIGHT;
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
        _leijiList.showsVerticalScrollIndicator = NO;
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
