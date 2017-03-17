//
//  ChangeCarTypeController.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ChangeCarTypeController.h"
#import "Header.h"
#import "ChangeCarTypeCell.h"

@interface ChangeCarTypeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSArray *titArr;
@property (nonatomic ,strong) NSArray *zongArr;
@property (nonatomic ,strong) UITableView *tabView;
@end

@implementation ChangeCarTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setTheChangeCarTypeTopView];
    [self.view addSubview:self.tabView];

}

-(void)setTheChangeCarTypeTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"调整投保方案";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = LYColor_A1;
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(ChangeCarTypeSelectbackClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)ChangeCarTypeSelectbackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  ---TableViewDelegate----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 5;
    }else if (section == 2){
        return 4;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43*HEIGHT;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 43*HEIGHT)];
    UILabel *titleLabn = [[UILabel alloc] init];
    titleLabn.textColor = LYColor_A4;
    titleLabn.font = [UIFont systemFontOfSize:12*WIDTH];
    titleLabn.text = self.titArr[section];
    [HeaderView addSubview:titleLabn];
    [titleLabn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.centerY.equalTo(HeaderView);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 12*WIDTH));
    }];
    return HeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 120*HEIGHT;
    }
    return 0.1f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 120*HEIGHT)];
        
        UIButton *huiFuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [huiFuBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        [huiFuBtn setTitle:@"恢复初始方案" forState:UIControlStateNormal];
        
        huiFuBtn.layer.borderColor = LYColor_A1.CGColor;
        huiFuBtn.layer.borderWidth = 1.0f;
        huiFuBtn.layer.cornerRadius = 4.0f;
        huiFuBtn.clipsToBounds = YES;
        [huiFuBtn addTarget:self action:@selector(huifuCLick) forControlEvents:UIControlEventTouchUpInside];
        huiFuBtn.backgroundColor = [UIColor whiteColor];

        [footerView addSubview:huiFuBtn];
        [huiFuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(18*WIDTH));
            make.top.equalTo(@(31*HEIGHT));
            make.size.mas_equalTo(CGSizeMake(159*WIDTH, 44*HEIGHT));
        }];
        
        UIButton *xunBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [xunBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        [xunBtn setTitle:@"立即询价" forState:UIControlStateNormal];
        xunBtn.layer.borderColor = LYColor_A1.CGColor;
        xunBtn.layer.borderWidth = 1.0f;
        xunBtn.layer.cornerRadius = 4.0f;
        xunBtn.clipsToBounds = YES;
        [xunBtn addTarget:self action:@selector(xunBtnCLick) forControlEvents:UIControlEventTouchUpInside];
        xunBtn.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:xunBtn];
        [xunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-18*WIDTH));
            make.top.equalTo(@(31*HEIGHT));
            make.size.mas_equalTo(CGSizeMake(159*WIDTH, 44*HEIGHT));
        }];
        
        return footerView;

    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArray = self.zongArr[indexPath.section];
    ChangeCarTypeCell *cell = [ChangeCarTypeCell ChangeCarTypecellWithTableView:tableView];
    cell.titleLab.text = titleArray[indexPath.row];
    cell.mianBtn.tag = indexPath.section*10+indexPath.row+1;
    [cell.mianBtn addTarget:self action:@selector(mianBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.mianBtn.hidden = NO;
    if (indexPath.section == 0) {
        cell.mianBtn.hidden = YES;
    }
    return cell;
}
-(void)xunBtnCLick{
    
}
-(void)huifuCLick{
    
}
-(void)mianBtnClick:(UIButton *)sender{
    if (sender.selected == YES) {
        sender.selected = NO;
    }else{
        sender.selected =YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableView *)tabView{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWindowWidth, ScreenWindowHeight-64) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.rowHeight = 56*HEIGHT;
        _tabView.showsVerticalScrollIndicator = NO;
        _tabView.separatorColor = LYColor_A6;
    }
    return _tabView;
    
}
-(NSArray *)titArr{
    if (!_titArr) {
        _titArr = @[@"交强险调整",@"商业险调整",@"附加险调整",@"其他附加险调整"];
    }
    return _titArr;
}
-(NSArray *)zongArr{
    if (!_zongArr) {
        _zongArr = @[@[@"交强险"],@[@"机动车损失险",@"第三者责任险",@"司机责任险",@"乘客责任险",@"盗抢险"],@[@"涉水险",@"玻璃险",@"划痕险",@"自燃损失险"],@[@"指定专修厂险",@"第三者逃逸险"]];
    }
    return _zongArr;
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
