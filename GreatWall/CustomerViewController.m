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
@interface CustomerViewController ()

@end

@implementation CustomerViewController
{
    UITableView *remindList;
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatWithoutCustomer];
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
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = LYColor_A7;
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    //右上角按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"sousuo(shancgheng).png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(btnAction:)];
    rightItem.tintColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0];
    self.navigationItem.rightBarButtonItem = rightItem;
    rightItem.tag = 1002;
    //通讯录导入
    UIButton *daoruBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [daoruBtn setTitle:@"通讯录导入" forState:UIControlStateNormal];
    [daoruBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
    daoruBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
    daoruBtn.tag = 1000;
    [daoruBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:daoruBtn];
    [daoruBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom).with.offset(31*HEIGHT);
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
    [self.view addSubview:tianjiaBtn];
    [tianjiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom).with.offset(31*HEIGHT);
        make.right.mas_equalTo(-59*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 18*HEIGHT));
    }];
    //斜线 /
    UIImageView *lineIMG= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kehu-line.png"]];
    lineIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:lineIMG];
    [lineIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tianjiaBtn);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(13*WIDTH, 23*HEIGHT));
    }];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 81*HEIGHT + 13;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    RemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RemindTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
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
