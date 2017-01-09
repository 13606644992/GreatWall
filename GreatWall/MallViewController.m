//
//  MallViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "MallViewController.h"
#import "Header.h"
#import "MallCell.h"
#import "MallModel.h"


//筛选选择状态状态
typedef NS_ENUM(NSInteger, MallSelectStyle) {
    MallSelectStyleone,//未选中
    MallSelectStyleTwo,//从低到高
    MallSelectStyleThree,//从高到低
    MallSelectStyleFour
};






@interface MallViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger indexSelect;
    NSInteger filStyle;
    NSInteger filSelect;

}
@property (nonatomic ,strong)NSArray *styleArray;
@property (nonatomic ,strong)UITableView *tabView;
@property (nonatomic ,strong)UILabel *lineLab;


@end

@implementation MallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    indexSelect = 1;
    filSelect = 0;
    filStyle = MallSelectStyleone;
    [self.view addSubview:self.tabView];
}

//排序条件
-(void)FiltrateButtonClick:(UIButton *)sender
{
    if (filSelect != 0) {
        UIButton *button = (UIButton *)[self.view viewWithTag:filSelect];
        button.selected = NO;
    }
    sender.selected = YES;
    filSelect = sender.tag;
    switch (sender.tag) {
        case 1000:{
            if (filStyle == MallSelectStyleone) {
                filStyle = MallSelectStyleTwo;
                [sender setTitle:@"从高到低" forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"paixu(shang)"] forState:UIControlStateSelected];

                
            }else if (filStyle == MallSelectStyleTwo){
                filStyle = MallSelectStyleThree;
                [sender setTitle:@"从低到高" forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"paixu(xia)"] forState:UIControlStateSelected];
                
            }else if (filStyle == MallSelectStyleThree){
                filStyle = MallSelectStyleone;
                sender.selected = NO;
                [sender setTitle:@"价格排序" forState:UIControlStateNormal];
                
            }else{
                
            }
        }
            break;
        case 1001:{
            filStyle = MallSelectStyleone;
            UIButton *button1 = (UIButton *)[self.view viewWithTag:1000];
            [button1 setTitle:@"价格排序" forState:UIControlStateNormal];

        }
            break;
        case 1002:{
            filStyle = MallSelectStyleone;
            UIButton *button2 = (UIButton *)[self.view viewWithTag:1000];
            [button2 setTitle:@"价格排序" forState:UIControlStateNormal];

        }
            break;
        default:
            break;
    }
    
}



#pragma mark ------TableViewDelegate-----------
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36*HEIGHT;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 50;
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self FiltrateButtonAndTableViewWithMall];
}
-(UIView *)FiltrateButtonAndTableViewWithMall
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 36*HEIGHT)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 36*HEIGHT-0.5f, ScreenWindowWidth, 0.5f)];
    lineLab.backgroundColor = LYColor_A6 ;
    [headerView addSubview:lineLab];
    for (int i = 0; i < self.styleArray.count; i++) {
        UIButton *filBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        filBtn.frame = CGRectMake(i*ScreenWindowWidth/3, 0, ScreenWindowWidth/3, 36*HEIGHT);
        filBtn.titleLabel.font = [UIFont systemFontOfSize:14*WEIGHT];
        [filBtn setTitle:self.styleArray[i] forState:UIControlStateNormal];
        [filBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
        [filBtn setTitleColor:LYColor_A3 forState:UIControlStateSelected];
        [filBtn addTarget:self action:@selector(FiltrateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [filBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [filBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -filBtn.imageView.image.size.width-10*WEIGHT, 0, filBtn.imageView.image.size.width+10*WEIGHT)];
            [filBtn setImageEdgeInsets:UIEdgeInsetsMake(-5, filBtn.titleLabel.bounds.size.width+6*WEIGHT, -5, -filBtn.titleLabel.bounds.size.width)];
        }
        if (i==self.styleArray.count-1) {
            [filBtn setImage:[UIImage imageNamed:@"sanxuan(shancgheng)"] forState:UIControlStateNormal];
            [filBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -filBtn.imageView.image.size.width, 0, filBtn.imageView.image.size.width)];
            [filBtn setImageEdgeInsets:UIEdgeInsetsMake(0, filBtn.titleLabel.bounds.size.width+6*WEIGHT,0, -filBtn.titleLabel.bounds.size.width)];
        }
        filBtn.tag = i+1000;
        [headerView addSubview:filBtn];
    }
    return headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallModel *mode = [[MallModel alloc] init];
    MallCell *cell = [MallCell MallcellWithTableView:tableView];
    cell.model = mode;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"DescriptionVC" object:nil userInfo:@{@"0":@"DescriptionVC"}]];
}
#pragma mark -----------Controller----------
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight-40*HEIGHT-130) style:UITableViewStylePlain];
//        _tabView.backgroundColor = [UIColor redColor];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.rowHeight = 190*HEIGHT;
        _tabView.separatorColor = LYColor_A6;
        _tabView.showsVerticalScrollIndicator = NO;
    }
    return _tabView;
}
-(NSArray *)styleArray
{
    if (!_styleArray) {
        _styleArray = @[@"价格排序",@"销量最高",@"筛选"];
    }
    return _styleArray;
}
-(UILabel *)lineLab
{
    if (!_lineLab) {
        _lineLab = [[UILabel alloc] init];
    }
    return _lineLab;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
