//
//  CarMallViewController.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/3.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CarMallViewController.h"
#import "Header.h"
#import "MallModel.h"
#import "CarMallCell.h"

@interface CarMallViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tabView;
@property (nonatomic ,strong)NSMutableArray *dataArray;


@end

@implementation CarMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tabView];

    [self getReload];

}

-(void)getReload{
    [DataGreatWall PostTheProductTypeWith:self.indexSelectVC WithThePageIndex:@"1" WithThePageSize:@"10" WithTheKey:@"" WithTheTargetID:@"" isGetDefault:@"0" WithDefaultNum:@"0" WithSortCode:@"0" WithBenefitNum:@"0" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
        if (error) {
            
        }else if ([respCode isEqualToString:@"000000"]){
            self.dataArray = array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabView reloadData];
            });
        }else{
            
        }
    }];

}

-(void)endRefresh{
    [self.tabView.mj_header endRefreshing];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = YES;

}
#pragma mark ----------TableViewDelegate---------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallProduct *model = self.dataArray[indexPath.row];
    CarMallCell *cell = [CarMallCell MallcellWithTableView:tableView];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallProduct *model = self.dataArray[indexPath.row];
    NSMutableDictionary *dictory = [NSMutableDictionary dictionary];
    [dictory setObject:[NSString stringWithFormat:@"%@",model.productId] forKey:@"productId"];
    [dictory setObject:[NSString stringWithFormat:@"%@",model.insurerId] forKey:@"insurerId"];
    [dictory setObject:[NSString stringWithFormat:@"%@",model.insurerName] forKey:@"insurerName"];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"DescriptionCarVC" object:nil userInfo:dictory]];
}
#pragma mark -----------Controller----------
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight-40*HEIGHT-130) style:UITableViewStylePlain];
        //        _tabView.backgroundColor = [UIColor redColor];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.rowHeight = 132*HEIGHT;
        _tabView.separatorColor = [UIColor clearColor];
        _tabView.showsVerticalScrollIndicator = NO;
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self getReload];
            [self performSelector:@selector(endRefresh) withObject:nil afterDelay:1.0f];
        }];
    }
    return _tabView;
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
