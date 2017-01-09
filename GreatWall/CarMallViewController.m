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


@end

@implementation CarMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tabView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = YES;

}
#pragma mark ----------TableViewDelegate---------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallModel *mode = [[MallModel alloc] init];
    CarMallCell *cell = [CarMallCell MallcellWithTableView:tableView];
    cell.model = mode;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"DescriptionVC" object:nil userInfo:@{@"1":@"DescriptionVC"}]];
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
        _tabView.separatorColor = LYColor_A6;
        _tabView.showsVerticalScrollIndicator = NO;
    }
    return _tabView;
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
