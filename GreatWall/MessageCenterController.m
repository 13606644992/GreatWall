//
//  MessageCenterController.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/14.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "MessageCenterController.h"
#import "Header.h"
#import "JSBadgeView.h"
#import "MessageCenterCell.h"

@interface MessageCenterController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *topView;
    NSString *indexType;
    NSMutableArray *zongArrays;
    NSMutableDictionary *heights;
}
/*
 *  表
 */
@property (nonatomic ,strong) UITableView *tabView;
@end

@implementation MessageCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYColor_A7;
    heights = [NSMutableDictionary dictionaryWithObject:@"0" forKey:@"0"];
    [self setTheMessageCenterTopView];
    [self setUpTheView];
    [self.view addSubview:self.tabView];
    indexType = @"10";
    [self getReload];
}
-(void)getReload{
    [DataGreatWall PostTheMessageWithMsgType:indexType Withsts:@"0" WithpageIndex:@"1" WithBlock:^(NSString *respCode,NSString *respMsg,NSString *pageSize,NSString *totalCount,NSString *unReadCount,NSMutableArray *array,NSError *error) {
        if (error) {
        
        }else if ([respCode isEqualToString:@"000000"]){
            zongArrays = array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabView reloadData];
            });
        }else{
            SVProgress(respMsg);
            [zongArrays removeAllObjects];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabView reloadData];
            });
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)setTheMessageCenterTopView
{
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"消息中心";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = LYColor_A1;
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(MessageCenterbackClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@"全标已读"  forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake(ScreenWindowWidth-88, 33, 75*WIDTH, 25);
    [sendBtn addTarget:self action:@selector(allRead) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
    [topView addSubview:sendBtn];
}
-(void)setUpTheView{
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(topView.mas_bottom);
        make.height.equalTo(@(63*HEIGHT));
    }];
    
    NSArray *segmentedArray = @[@"我的消息",@"系统消息"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = LYColor_A1;
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:)               forControlEvents:UIControlEventValueChanged];
    [whiteView addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(9*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(264*WIDTH, 36*HEIGHT));
    }];
}
-(void)allRead{
    
}
-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            if ([indexType isEqualToString:@"10"]) {
                return;
            }else{
                indexType = @"10";
                [self getReload];
            }
        }
            break;
        case 1:
        {
            if ([indexType isEqualToString:@"1"]) {
                return;
            }else{
                indexType = @"1";
                [self getReload];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark  ---TableViewDelegate-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return zongArrays.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[heights objectForKey:@(indexPath.row)] floatValue];
//    return 104*HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 11*HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = zongArrays[indexPath.row];
    MessageCenterCell *cell = [MessageCenterCell cellWithMessageCenterView:tableView];
    cell.model = model;
    [heights setObject:@([cell getHeights]) forKey:@(indexPath.row)];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexType isEqualToString:@"1"]) {
        
    }else{
        
    }
}
-(void)MessageCenterbackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---Controller-----
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 63*HEIGHT+64, ScreenWindowWidth, ScreenWindowHeight-63*HEIGHT-64) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
//        _tabView.rowHeight = 104*HEIGHT;
        
    }
    return _tabView;
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
