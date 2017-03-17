//
//  CustomerViewController.m
//  GreatWall
//
//  Created by GJ on 2017/2/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CustomerViewController.h"
#import "Header.h"
#import "AddCustomerVC.h"
#import "RemindTableViewCell.h"
#import "CustomerTableViewCell.h"
#import "Customer.h"
@interface CustomerViewController ()

@property (nonatomic, strong) UITableView *linkmanList;//联系人
@property (nonatomic, strong) NSMutableArray *linkmanArray;
@property (nonatomic, strong) NSMutableDictionary *nameDic;
//@property (nonatomic, strong) UIView *headerView;//tableview的headerview

@end

@implementation CustomerViewController
{
    UITableView *remindList;
}

- (NSMutableArray *)linkmanArray{
    if (!_linkmanArray) {
        _linkmanArray = [[NSMutableArray alloc]init];
    }
    return _linkmanArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    StatusBarBlack;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLinkManTableView];
    [self getData];
    self.view.backgroundColor = [UIColor whiteColor];

//    [self creatWithoutCustomer];//没客户
    [self creatWithCustomer];//有客户
    [self setSegmentList];
}
#pragma mark - 联系人tableview
- (void)getLinkManTableView{
    self.linkmanList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    self.linkmanList.delegate = self;
    self.linkmanList.dataSource = self;
    self.linkmanList.sectionIndexColor = LYColor_A1;
    self.linkmanList.showsVerticalScrollIndicator = NO;
    self.linkmanList.backgroundColor = [UIColor whiteColor];
    self.linkmanList.separatorColor = [UIColor whiteColor];
//    self.linkmanList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.linkmanList];
//    if ([self.linkmanList respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.linkmanList setSeparatorInset:UIEdgeInsetsMake(0, 41*WIDTH, 0, 34*WIDTH)];
//    }
//    [self.linkmanList setSeparatorColor:LYColor_A6];
    self.linkmanList.bounces = NO;
}
#pragma mark - 数据解析（获取常用保险联系人）
- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"],@"mobile":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_mobile"],@"pageIndex":@"1",@"pageSize":@"10"}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"getInsured" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取常用保险联系人responseObject=====%@",responseObject);
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            NSArray *insuredList = responseObject[@"output"][@"insuredList"];
            for (NSDictionary *dic in insuredList) {
                Customer *model = [Customer customerWithDict:dic];
                [self.linkmanArray addObject:model];
            }
            //创建所有的keys
            self.nameDic = [NSMutableDictionary dictionary];
            BOOL found;
            for (Customer *customer in self.linkmanArray) {
                NSString *index = customer.nameIndex;
                found = NO;
                for (NSString *str in [self.nameDic allKeys]) {
                    if ([str isEqualToString:index]) {
                        found = YES;
                    }
                }
                if (!found) {
                    NSLog(@"setValue%@:",index);
                    [self.nameDic setValue:[[NSMutableArray alloc] init] forKey:index];
                }
            }
            //将所有的customer数据加载进去
            NSLog(@"===========>>>>>>>>%@%@",self.nameDic,self.linkmanArray);
            for (Customer *customer in self.linkmanArray) {
                [[self.nameDic objectForKey:customer.nameIndex] addObject:customer];
            }
            //按A-Z排序
            for (NSString *key in [self.nameDic allKeys]) {
                [[self.nameDic objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"insuredName" ascending:YES]]];
            }
            NSLog(@"self.nameDic:%@",self.nameDic);
        }
        [self.linkmanList reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark 没客户时
- (void)creatWithoutCustomer{
    self.navigationItem.title = @"客户管理";
    UIImageView *myIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kehuguanli.png"]];
    myIMG.contentMode = UIViewContentModeScaleAspectFit;
    myIMG.userInteractionEnabled = YES;
    [self.view addSubview:myIMG];
    [myIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UIButton *luruBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    luruBtn.backgroundColor = LYColor_A1;
    [luruBtn setTitle:@"通讯录录入" forState:UIControlStateNormal];
    [luruBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [luruBtn setTitleColor:LYColor_A6 forState:UIControlStateHighlighted];
    luruBtn.titleLabel.font = [UIFont systemFontOfSize:17*HEIGHT];
    luruBtn.tag = 1000;
    luruBtn.layer.cornerRadius = 44 / 2 *HEIGHT;
    luruBtn.clipsToBounds = YES;
    [myIMG addSubview:luruBtn];
    [luruBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [luruBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(410*HEIGHT);
        make.left.mas_equalTo(35*WIDTH);
        make.size.mas_equalTo(CGSizeMake(140*WIDTH, 44*HEIGHT));
    }];
    
    UIButton *tianjiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tianjiaBtn.backgroundColor = LYColor_A1;
    [tianjiaBtn setTitle:@"手动添加" forState:UIControlStateNormal];
    [tianjiaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tianjiaBtn setTitleColor:LYColor_A6 forState:UIControlStateHighlighted];
    tianjiaBtn.titleLabel.font = [UIFont systemFontOfSize:17*HEIGHT];
    tianjiaBtn.tag = 1001;
    tianjiaBtn.layer.cornerRadius = 44 / 2 *HEIGHT;
    tianjiaBtn.clipsToBounds = YES;
    [myIMG addSubview:tianjiaBtn];
    [tianjiaBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [tianjiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(410*HEIGHT);
        make.right.mas_equalTo(-35*WIDTH);
        make.size.mas_equalTo(CGSizeMake(140*WIDTH, 44*HEIGHT));
    }];
}
#pragma mark 有客户时
- (void)creatWithCustomer{
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"客户管理", @"事件提醒"]];
    segment.frame =CGRectMake(0,0,148, 27);
    self.navigationItem.titleView = segment;
    [segment addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = LYColor_A1;
    
    //右上角按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"sousuo(shancgheng).png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(btnAction:)];
    rightItem.tintColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0];
    self.navigationItem.rightBarButtonItem = rightItem;
    rightItem.tag = 1002;
}

- (void)setSegmentList{
    //事件提醒列表
    remindList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    remindList.delegate = self;
    remindList.dataSource = self;
    remindList.backgroundColor = LYColor_A7;
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 18)];
    header.backgroundColor = LYColor_A7;
    remindList.tableHeaderView = header;
    remindList.separatorStyle = NO;
}

- (void)btnAction:(UIButton *)sender{
    if (sender.tag == 1000) {
        NSLog(@"通讯录导入");
        AddCustomerVC *addCustomerVC = [[AddCustomerVC alloc]init];
        [self.navigationController presentViewController:addCustomerVC animated:NO completion:nil];
        [addCustomerVC daoruBtnAction:nil];
    }else if (sender.tag == 1001){
        NSLog(@"手动添加");
        AddCustomerVC *addCustomerVC = [[AddCustomerVC alloc]init];
        [self.navigationController presentViewController:addCustomerVC animated:YES completion:nil];
    }else{
        NSLog(@"搜索");
    }
}
- (void)segmentControlAction:(UISegmentedControl *)sender{
    NSLog(@"%ld", (long)sender.selectedSegmentIndex);
    if (sender.selectedSegmentIndex == 0) {
        if (remindList) {
            [remindList removeFromSuperview];
        }
    }else{
        [self.view addSubview:remindList];
    }
}
#pragma mark - tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.linkmanList]) {
        NSLog(@"section.count=========%ld",[self.nameDic allKeys].count);
        return [self.nameDic allKeys].count;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.linkmanList]) {
        NSArray *arr = [self.nameDic valueForKey:[[[self.nameDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]];
        NSLog(@"arr====%@,%ld,%ld",arr,self.nameDic.count,arr.count);
        return arr.count;
    }else{
        
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.linkmanList]) {
        return 56*HEIGHT;
    }else{
        return 81*HEIGHT + 13;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.linkmanList]) {
        static NSString *celling = @"celling";
        CustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celling];
        if (cell == nil) {
            cell = [[CustomerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celling];
        }
        Customer *customer = [[self.nameDic valueForKey:[[[self.nameDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        cell.nameLabel.text = customer.insuredName;
        return cell;
    }else{
        static NSString *identifier = @"cell";
        RemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[RemindTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
}
//返回每组标题索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.linkmanList]) {
        NSLog(@"标题===================%@",[[self.nameDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]);
        return [[self.nameDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.linkmanList]) {
        
        if (section == 0) {
            //headerView
            UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 104*HEIGHT)];
            headerView.backgroundColor = LYColor_A7;
            
            //“通讯录导入”/“手动添加”背景view
            UIView *backView = [[UIView alloc]init];
            backView.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:backView];
            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(13*HEIGHT);
                make.left.right.bottom.mas_equalTo(0);
            }];
            //通讯录导入
            UIButton *daoruBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [daoruBtn setTitle:@"通讯录导入" forState:UIControlStateNormal];
            [daoruBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
            daoruBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
            daoruBtn.tag = 1000;
            [daoruBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:daoruBtn];
            [daoruBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(31*HEIGHT);
                make.left.mas_equalTo(55*WIDTH);
                make.size.mas_equalTo(CGSizeMake(100*WIDTH, 18*HEIGHT));
            }];
            //手动添加
            UIButton *tianjiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [tianjiaBtn setTitle:@"手动添加" forState:UIControlStateNormal];
            [tianjiaBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
            tianjiaBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
            tianjiaBtn.tag = 1001;
            [tianjiaBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:tianjiaBtn];
            [tianjiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(31*HEIGHT);
                make.right.mas_equalTo(-59*WIDTH);
                make.size.mas_equalTo(CGSizeMake(100*WIDTH, 18*HEIGHT));
            }];
            //斜线 /
            UIImageView *lineIMG= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kehu-line.png"]];
            lineIMG.contentMode = UIViewContentModeScaleAspectFit;
            [backView addSubview:lineIMG];
            [lineIMG mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(tianjiaBtn);
                make.centerX.mas_equalTo(backView);
                make.size.mas_equalTo(CGSizeMake(13*WIDTH, 23*HEIGHT));
            }];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(41*WIDTH, 103*HEIGHT+0.5, ScreenWindowWidth - 70*WIDTH, 0.5)];
            line.backgroundColor = LYColor_A6;
            [headerView addSubview:line];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(18*WIDTH, 87*HEIGHT, 13*WIDTH, 13*HEIGHT)];
            title.textColor = LYColor_A1;
            title.text = [[self.nameDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)][0];
            [backView addSubview:title];
            return headerView;
        }else{
            UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(41*WIDTH, 0, ScreenWindowWidth, 0.5)];
            sectionView.backgroundColor = [UIColor whiteColor];
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(18*WIDTH, -6.5*HEIGHT, 13*WIDTH, 13*HEIGHT)];
            title.text = [[self.nameDic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)][section];
            title.textColor = LYColor_A1;
            [sectionView addSubview:title];
            return sectionView;
        }
    }else{
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:self.linkmanList]) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        return view;
    }else{
        
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.linkmanList]) {
        
        if (section == 0) {
            return 104*HEIGHT;
        }else{
            
            return 1;
        }
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.linkmanList]) {
        
    }else{
        
    }
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
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
