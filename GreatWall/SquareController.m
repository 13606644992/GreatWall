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
@property (nonatomic ,strong) UIView *kindGrayView;
@property (nonatomic ,strong) UILabel *blackLab;

@end

@implementation SquareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发现";
    index = UISquareTypeone+1;
    [self setKindTypeButton];
    [self.view addSubview:self.tabView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-1, self.navigationController.navigationBar.frame.size.width, 0.5)];
    line.backgroundColor = [LYColor colorWithHexString:@"#e3e3e3"];
    [self.navigationController.navigationBar addSubview:line];
    [self.navigationController.navigationBar bringSubviewToFront:line];
}

-(void)setKindTypeButton
{
    for (NSInteger i=0; i<3; i++) {
        UIButton *kindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        kindBtn.frame = CGRectMake(i*(ScreenWindowWidth/3), 64, ScreenWindowWidth/3, 40*HEIGHT);
        [kindBtn setTitle:self.kindArray[i] forState:UIControlStateNormal];
        [kindBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [kindBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        if (i==0) {
            kindBtn.selected = YES;
            [self.view addSubview:self.kindGrayView];
        }
        kindBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        kindBtn.tag = i+1;
        [kindBtn addTarget:self action:@selector(kindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:kindBtn];
    }
}
-(void)kindBtnClick:(UIButton *)sender
{
    if (index != sender.tag) {
        UIButton *kindBtn = (UIButton *)[self.view viewWithTag:index];
        kindBtn.selected = NO;
        sender.selected = YES;
        index = sender.tag;
        [UIView animateWithDuration:0.3 animations:^{
            self.kindGrayView.center = CGPointMake(sender.center.x, self.kindGrayView.center.y);
        } completion:^(BOOL finished) {
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabView reloadData];
        });
    }
    return;
}
#pragma mark  -----UITableViewDelegate------------
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (index == UISquareTypeTwo){
        return 205;
    }
    return 185;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (index == UISquareTypeTwo) {
        SquareModel *mode = [[SquareModel alloc] init];
        SquareFirstCell *cell = [SquareFirstCell SquareFcellWithTableView:tableView];
        cell.model = mode;
        return cell;
    }
    SquareModel *mode = [[SquareModel alloc] init];
    SquareSecondCell *cell = [SquareSecondCell SquareScellWithTableView:tableView];
    cell.model = mode;
    return cell;
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
#pragma mark  ------Controller---------
-(UILabel *)blackLab
{
    if (!_blackLab) {
        
    }
    return _blackLab;
}
-(UIView *)kindGrayView
{
    if (!_kindGrayView) {
        _kindGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 61+40*HEIGHT, 80*HEIGHT, 3)];
        _kindGrayView.center = CGPointMake(ScreenWindowWidth/6, _kindGrayView.center.y);
        _kindGrayView.backgroundColor = [UIColor lightGrayColor];
    }
    return _kindGrayView;
}
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40*HEIGHT, ScreenWindowWidth, ScreenWindowHeight-64-40*HEIGHT) style:UITableViewStyleGrouped];
        _tabView.backgroundColor = UIColorRGBA(242, 242, 242, 1);
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.showsVerticalScrollIndicator = NO;
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
