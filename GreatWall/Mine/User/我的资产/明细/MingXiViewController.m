//
//  MingXiViewController.m
//  GreatWall
//
//  Created by GJ on 2017/3/1.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "MingXiViewController.h"
#import "Header.h"
#import "MingXiTableViewCell.h"
#import "MingXiModel.h"

@interface MingXiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *listView;
@property (nonatomic, strong) UIButton *alphBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *zhiChuDataSource;
@property (nonatomic, strong) NSMutableArray *shouRuDataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) NSInteger senderTag;
@property (nonatomic, strong) NSString *tradeType;
@end

@implementation MingXiViewController
{
    UIView *navBar;
    UIButton *listBtn;
    NSArray *array;
    UILabel *titleLabel;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
- (NSMutableArray *)zhiChuDataSource{
    if (!_zhiChuDataSource) {
        _zhiChuDataSource = [[NSMutableArray alloc]init];
    }
    return _zhiChuDataSource;
}
- (NSMutableArray *)shouRuDataSource{
    if (!_shouRuDataSource) {
        _shouRuDataSource = [[NSMutableArray alloc]init];
    }
    return _shouRuDataSource;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.senderTag = 1;
    self.tradeType = @"0";
    self.page = 1;
    [self getData];
    array = @[@"全部明细",@"支出明细",@"收入明细"];
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowHeight, 64)];
    [self.view addSubview:View];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(View.mas_bottom);
    }];
    //重新设置分割线
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [self.tableView setSeparatorColor:LYColor_A6];
    [self setNaviBar];
}
#pragma mark -----MJRefresh----------
-(void)MJHeaderLoadTable
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2.0f];
}
-(void)MJSetFooterTable
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2.0f];
}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark - 数据请求-明细
- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"],@"acctType":@"20",@"pageIndex":[NSString stringWithFormat:@"%ld",self.page],@"pageSize":@"10",@"tradeType":self.tradeType}];
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>===================%@",self.tradeType);
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"getAccountDetail" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"明细responseObject========%@",responseObject);
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            [self endRefresh];
            if (_isTop) {
                self.dataSource =[NSMutableArray arrayWithCapacity:0];
//                self.zhiChuDataSource =[NSMutableArray arrayWithCapacity:0];
//                self.shouRuDataSource =[NSMutableArray arrayWithCapacity:0];
            }
            NSArray *accountDetailList = responseObject[@"output"][@"accountDetailList"];
            for (NSDictionary *dictionary in accountDetailList) {
                MingXiModel *model = [[MingXiModel alloc]init];
                [model setValuesForKeysWithDictionary:dictionary];
                [self.dataSource addObject:model];
            }

            NSLog(@"=======>>>>>>>>>%ld,%@",self.dataSource.count,self.dataSource);
            [self.tableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


#pragma mark - tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celling = @"celling";
    MingXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celling];
    if (!cell) {
        cell = [[MingXiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celling];
    }
    if (indexPath.row == self.dataSource.count) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWindowWidth);
    }
     cell.mingXiModel = self.dataSource[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68*HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 13*HEIGHT)];
    view.backgroundColor = LYColor_A6;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13*HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

#pragma mark - 自定义navigationBar
- (void)setNaviBar{
    navBar = [[UIView alloc]init];
    navBar.backgroundColor = LYColor_A1;
    [self.view addSubview:navBar];
    
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = LYColor_A1;
    [btn setBackgroundImage:[UIImage imageNamed:@"jiantou_bai"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.bottom.mas_equalTo(-12.5);
        make.size.mas_equalTo(CGSizeMake(10, 18));
    }];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"全部明细";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    [navBar addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(139*WIDTH);
        make.bottom.mas_equalTo(-12.5);
        make.size.mas_equalTo(CGSizeMake(70, 18));
    }];
    
    UIImageView *xiaLaIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiala-mingxi"]];
    [navBar addSubview:xiaLaIMG];
    xiaLaIMG.contentMode = UIViewContentModeScaleAspectFit;
    [xiaLaIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).offset(18*WIDTH);
        make.centerY.mas_equalTo(titleLabel);
        make.size.mas_equalTo(CGSizeMake(12, 7));
    }];
    listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [listBtn addTarget:self action:@selector(xiaLa:) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:listBtn];
    [listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel);
        make.centerY.mas_equalTo(titleLabel);
        make.right.mas_equalTo(xiaLaIMG);
        make.height.equalTo(titleLabel);
    }];
    [self SetalphBtn];
    [self setListView];
    self.alphBtn.hidden = YES;
    [self.view bringSubviewToFront:navBar];
}
#pragma mark - 下拉点击事件
- (void)xiaLa:(UIButton *)sender{
    listBtn.selected = !listBtn.selected;
    if (listBtn.isSelected) {
        NSLog(@"下拉");
        [UIView animateWithDuration:(0.3) animations:^{
            [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(navBar).with.offset(49*3*HEIGHT);
            }];
            [self.view layoutIfNeeded];
        } completion:nil];
        self.alphBtn.hidden = NO;
    }else{
        NSLog(@"收起");
        [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(navBar);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
        self.alphBtn.hidden = YES;
//        self.listView 
    }
}
#pragma mark - 创建下拉视图
- (void)setListView{
    self.listView = [[UIView alloc]init];
    self.listView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(navBar);
        make.height.mas_equalTo(49*3*HEIGHT);
    }];
    for (int i = 1; i < 3; i++) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = LYColor_A6;
        [self.listView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(49*HEIGHT*i);
            make.height.mas_equalTo(1);
        }];
    }
    
    for (int i = 0; i < 3; i++) {
        UIButton *listTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [listTitleBtn setTitle:array[i] forState:UIControlStateNormal];
        listTitleBtn.titleLabel.font = [UIFont systemFontOfSize:17*HEIGHT];
        [listTitleBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        listTitleBtn.tag = 1000 + i;
        [listTitleBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.listView addSubview:listTitleBtn];
        listTitleBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -30 *WIDTH, 0, 0);
        [listTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(49*i*HEIGHT);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(49*HEIGHT);
        }];
    }
}
#pragma mark - 半透明背景
- (void)SetalphBtn{
    self.alphBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.alphBtn.backgroundColor = [UIColor blackColor];
    self.alphBtn.backgroundColor = UIColorRGBA(51, 51, 51, 0.7);
    [self.alphBtn addTarget:self action:@selector(xiaLa:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.alphBtn];
    
    [self.alphBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
}
#pragma mark - 下拉式图选择分类按钮
- (void)changeAction:(UIButton *)sender{
    self.page = 1;
    [self.dataSource removeAllObjects];
    switch (sender.tag) {
        case 1000:
            titleLabel.text = @"全部明细";
            self.tradeType = @"0";
            
            break;
        case 1001:
            titleLabel.text = @"支出明细";
            self.tradeType = @"30";
            break;
        case 1002:
            titleLabel.text = @"收入明细";
            self.tradeType = @"31";
            break;
        default:
            break;
    }
    [self getData];
    [self xiaLa:nil];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64 *13) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.backgroundColor = LYColor_A7;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _isTop = YES;
            self.page = 1;
            [self MJHeaderLoadTable];
            [self getData];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _isTop = NO;
            self.page++;
            [self MJSetFooterTable];
            [self getData];
        }];
    }
    return _tableView;
}

- (void)btnAction{
    [self.navigationController popViewControllerAnimated:YES];
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
