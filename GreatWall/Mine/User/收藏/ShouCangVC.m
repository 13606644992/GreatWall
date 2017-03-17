//
//  ShouCangVC.m
//  GreatWall
//
//  Created by GJ on 2017/3/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ShouCangVC.h"
#import "Header.h"
#import "CarMallCell.h"
#import "MallCell.h"
#import "MallModel.h"
#import "ShouCangModel.h"

@interface ShouCangVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ShouCangVC

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = LYColor_A6;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    self.navigationController.navigationBar.translucent = NO;
    StatusBarBlack;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    self.navigationItem.title = @"收藏";
    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.mas_equalTo(0);
//    }];
}
#pragma mark - 数据请求 - 获取收藏列表
- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"],@"objType":@"10",@"benefitNum":@"3"}];
    [GJAFNetWork POST:URL_ZHANGHAI params:dic method:@"userFavoritesDetail" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"收藏列表responseObject=========%@",responseObject);
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            NSArray *favoritesProductsRecord = responseObject[@"output"][@"favoritesProductsRecord"];
            for (NSDictionary *dic in favoritesProductsRecord) {
                MallModel *model = [[MallModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
            }
        }
        [self.tableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MallModel *model = self.dataArray[indexPath.row];
    if (model) {
        MallProduct *model = self.dataArray[indexPath.row];
        MallCell *cell = [MallCell MallcellWithTableView:tableView];
        cell.model = model;
        return cell;
    }else{
        MallProduct *model = self.dataArray[indexPath.row];
        MallCell *cell = [MallCell MallcellWithTableView:tableView];
        cell.model = model;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
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
