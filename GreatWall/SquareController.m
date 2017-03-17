//
//  SquareController.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "SquareController.h"
#import "Header.h"
#import "SquareModel.h"
#import "SquareSecondCell.h"
#import "SquareFirstCell.h"
#import "CarNumberController.h"
//Index
typedef NS_ENUM(NSInteger, UISquareType) {
    UISquareTypeone,
    UISquareTypeTwo,
    UISquareTypeThree,
    UISquareTypeFour
};
@interface SquareController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger index;
    
}
@property (nonatomic ,strong) UITableView *tabView;
@property (nonatomic ,strong) NSArray *kindArray;
@property (nonatomic ,strong) NSMutableArray *tatleArray;
@property (nonatomic ,strong) UILabel *blackLab;

@end

@implementation SquareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"发现";
    self.navigationItem.title = @"发现";
   [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[LYColor colorWithHexString:@"#2dce8f"]}];
    index = UISquareTypeTwo;
    [self setKindTypeButton];
    [self.view addSubview:self.tabView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-1, self.navigationController.navigationBar.frame.size.width, 0.5)];
    line.backgroundColor = [LYColor colorWithHexString:@"#e3e3e3"];
    [self.navigationController.navigationBar addSubview:line];
    [self.navigationController.navigationBar bringSubviewToFront:line];
    [DataGreatWall PostThesPecialProduct:@"1" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
        if (error) {
            NSLog(@"网络或系统错误----%@-",error);
        }else if ([respCode isEqualToString:@"000000"]){
            self.tatleArray = array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabView reloadData];
            });
        }else{
            NSLog(@"请求失败-----%@",respMsg);
        }

    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Home_Typeindex"]) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:[[[NSUserDefaults standardUserDefaults] objectForKey:@"Home_Typeindex"] integerValue]+1];
        [self kindBtnClick:btn];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Home_Typeindex"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void)setKindTypeButton
{
    for (NSInteger i=0; i<3; i++) {
        UIButton *kindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        kindBtn.frame = CGRectMake(i*(ScreenWindowWidth/3), 64, ScreenWindowWidth/3, 40*HEIGHT);
        [kindBtn setTitle:self.kindArray[i] forState:UIControlStateNormal];
        [kindBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [kindBtn setTitleColor:LYColor_A1 forState:UIControlStateSelected];
        if (i==0) {
            kindBtn.selected = YES;
        }
        kindBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        kindBtn.tag = i+1;
        [kindBtn addTarget:self action:@selector(kindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:kindBtn];
        if (i!=2) {
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5f, 27*HEIGHT)];
            line.center = CGPointMake(ScreenWindowWidth/3*(i+1), kindBtn.center.y);
            line.backgroundColor = LYColor_A6;
            [self.view addSubview:line];
        }
    }
}
-(void)kindBtnClick:(UIButton *)sender
{
    if (index != sender.tag) {
        UIButton *kindBtn = (UIButton *)[self.view viewWithTag:index];
        kindBtn.selected = NO;
        sender.selected = YES;
        index = sender.tag;
        switch (sender.tag) {
            case 1:
            {
                 index = UISquareTypeTwo;
                [DataGreatWall PostThesPecialProduct:@"1" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
                    if (error) {
                        NSLog(@"网络或系统错误----%@-",error);
                    }else if ([respCode isEqualToString:@"000000"]){
                        self.tatleArray = array;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tabView reloadData];
                        });
                    }else{
                        NSLog(@"请求失败-----%@",respMsg);
                    }
                    
                }];
            }
                break;
            case 2:
            {
                index = UISquareTypeThree;
                [DataGreatWall PostTheAdsListWithPageIndex:@"1" WithPageSize:@"10" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
                    if (error) {
                        NSLog(@"网络或系统错误----%@-",error);
                    }else if ([respCode isEqualToString:@"000000"]){
                        self.tatleArray = array;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tabView reloadData];
                        });
                    }else{
                        NSLog(@"请求失败-----%@",respMsg);
                    }
                }];
            }
                break;
            case 3:
            {
                 index = UISquareTypeFour;
                [DataGreatWall PostThesPecial:@"1" WithPageSize:@"10" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
                    if (error) {
                        NSLog(@"网络或系统错误----%@-",error);
                    }else if ([respCode isEqualToString:@"000000"]){
                        self.tatleArray = array;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tabView reloadData];
                        });
                    }else{
                        NSLog(@"请求失败-----%@",respMsg);
                    }
                }];
            }
                break;
            default:
                break;
        }
        
   
    }
    return;
}
#pragma mark  -----UITableViewDelegate------------

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 13*HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (index == UISquareTypeTwo){
        return 230*HEIGHT;
//    }
//    return 220;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",(unsigned long)self.tatleArray.count);
    return self.tatleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (index == UISquareTypeTwo) {
        MallProduct *mode = self.tatleArray[indexPath.row];
        SquareFirstCell *cell = [SquareFirstCell SquareFcellWithTableView:tableView];
        cell.model = mode;
        return cell;
    }else if (index == UISquareTypeThree){
        SquareModel *mode = self.tatleArray[indexPath.row];
        SquareSecondCell *cell = [SquareSecondCell SquareScellWithTableView:tableView];
        cell.model = mode;
        return cell;
    }
    SquareSpecial *mode = self.tatleArray[indexPath.row];
    SquareSecondCell *cell = [SquareSecondCell SquareScellWithTableView:tableView];
    cell.modelSpecial = mode;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (index == UISquareTypeTwo) {
        MallProduct *model = self.tatleArray[indexPath.row];
        self.hidesBottomBarWhenPushed=YES;
        DescriptionController *baseVC = [[DescriptionController alloc] init];
        baseVC.productId = model.productId;
        [self.navigationController pushViewController:baseVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;        
    }
    else{
//        self.hidesBottomBarWhenPushed=YES;
//        CarNumberController *baseVC = [[CarNumberController alloc] init];
//        //    baseVC.productId = dic[@"DescriptionVC"];
//        [self.navigationController pushViewController:baseVC animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
    }
    
}
#pragma mark -----MJRefresh----------
-(void)MJSquareHeaderLoadTable
{
    [self performSelector:@selector(endSquareRefresh) withObject:nil afterDelay:2.0f];
}
-(void)MJSetSquareFooterTable
{
    [self performSelector:@selector(endSquareRefresh) withObject:nil afterDelay:2.0f];
}
-(void)endSquareRefresh{
    [self.tabView.mj_header endRefreshing];
    [self.tabView.mj_footer endRefreshing];
}
#pragma mark  ------Controller----------
-(UILabel *)blackLab
{
    if (!_blackLab) {
        
    }
    return _blackLab;
}
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40*HEIGHT, ScreenWindowWidth, ScreenWindowHeight-64-40*HEIGHT-22) style:UITableViewStyleGrouped];
        _tabView.backgroundColor = LYColor_A7;
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.showsVerticalScrollIndicator = NO;
        _tabView.separatorColor = [UIColor clearColor];
        _tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self MJSquareHeaderLoadTable];
        }];
        _tabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self MJSetSquareFooterTable];
        }];
    }
    return _tabView;
}
-(NSArray *)kindArray
{
    if (!_kindArray) {
        _kindArray = @[@"爆款推荐",@"优选活动",@"专题列表"];
    }
    return _kindArray;
}
-(NSMutableArray *)tatleArray
{
    if (!_tatleArray) {
        _tatleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _tatleArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)SquareBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
