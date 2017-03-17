//
//  SelectController.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "SelectController.h"
#import "Header.h"

@interface SelectController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArrays;
    NSMutableArray *widths;
    NSInteger indexSelect;
    CGFloat AllWidth;
    NSMutableArray *insureArrays;
    NSMutableArray *productID;
    CGFloat firstHeight;
    CGFloat secondHeight;
}
@property (nonatomic ,strong)UITableView *tabView;
@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *sureBtn;



@end

@implementation SelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectItem = 0;
    firstHeight = 88*HEIGHT;secondHeight = 88*HEIGHT;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTheSearchTopView];
//    self.edgesForExtendedLayout=UIRectEdgeBottom;
  
    [self.view addSubview:self.titleScrollView];

    insureArrays = [NSMutableArray arrayWithCapacity:0];
    productID = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.tabView];
    [self.view addSubview:self.resetBtn];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth/2, 59*HEIGHT));
    }];
    [self.view addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth/2, 59*HEIGHT));
    }];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 63.5+50*HEIGHT, ScreenWindowWidth, 0.5)];
    line.backgroundColor = LYColor_A6;
    [self.view addSubview:line];

}
-(void)setTheSearchTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"筛选";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = LYColor_A1;
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(SearchbackClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 63.5, ScreenWindowWidth, 0.5)];
    line.backgroundColor = LYColor_A6;
    [topView addSubview:line];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.selectItem = [[NSUserDefaults standardUserDefaults] objectForKey:@"index"];
    [self setScrollWithArrays:nil];
    self.navigationController.navigationBarHidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)SearchbackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setScrollWithArrays:(NSArray *)arrays
{
//    dispatch_queue_t queue = dispatch_queue_create("zidingyi", DISPATCH_QUEUE_SERIAL);
//    
//    dispatch_async(queue, ^{
        [DataGreatWall PostTheProductTypeWithparentId:@"0" WithBlock:^(NSString *respCode, NSString *respMsg, MallProductType *type, NSError *error) {
            if (error) {
                
            }else if ([respCode isEqualToString:@"000000"]){
                __block NSMutableArray *titles = [NSMutableArray arrayWithCapacity:0];
                __block NSMutableArray *ids = [NSMutableArray arrayWithCapacity:0];
                [type.typeList enumerateObjectsUsingBlock:^(MallProductType *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [titles addObject:obj.typeName];
                    [ids addObject:obj.typeId];
                    NSLog(@"********************%@",obj.typeId);
                }];
                productID = ids;
                if (productID.count>0) {
                    [self setInsureTypeWithSelect:[self.selectItem integerValue]];
                }
                titleArrays = titles;
                indexSelect = 1;
                if (titleArrays.count>4) {
                    [self getTitlesWidthWithArray:titleArrays];
                }
                [self setTitlesWithArrays:titleArrays];
            }else{
            }
        }];
}
-(void)setInsureTypeWithSelect:(NSInteger)select
{
    [DataGreatWall PostTheInsureWithparentId:productID[select] WithInsureID:nil WithinsurerType:@"10" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
        if (error) {
            
        }else if ([respCode isEqualToString:@"000000"]){
            insureArrays = array;
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
            [self.tabView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        }else{
        }
    }];
}
-(void)setTitlesWithArrays:(NSArray *)array
{
    for (UILabel *view in self.titleScrollView.subviews) {
        [view removeFromSuperview];
    }
    UIButton *SelectBtn = nil;
    CGFloat zongKuan = 18*WIDTH;
    for (int index = 0; index < array.count; index ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(zongKuan, 0, [widths[index] floatValue], 50*HEIGHT);
        btn.tag = index+1;
        btn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
        zongKuan = zongKuan + [widths[index] floatValue] +18*WIDTH;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titleArrays[index] forState:UIControlStateNormal];
        [btn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        btn.selected = NO;
        [btn setTitleColor:LYColor_A1 forState:UIControlStateSelected];
        [self.titleScrollView addSubview:btn];
        if (index == [self.selectItem integerValue]) {
            btn.selected = YES;
            indexSelect = btn.tag;
            [self.titleScrollView addSubview:self.lineView];
            CGRect rect = self.lineView.frame;
            rect.size.width = [widths[btn.tag-1] floatValue];
            self.lineView.frame = rect;
            self.lineView.center = CGPointMake(btn.center.x, self.lineView.center.y);
            SelectBtn = btn;
        }
    }
    AllWidth = zongKuan;
    self.titleScrollView.contentSize = CGSizeMake(zongKuan, 0);
    [self setTitleLocationCenter:SelectBtn];

}
-(void)btnClick:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }else{
        UIButton *btn = (UIButton *)[self.view viewWithTag:indexSelect];
        btn.selected = NO;
        sender.selected = YES;
        indexSelect = sender.tag;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.lineView.frame;
            rect.size.width = [widths[sender.tag-1] floatValue];
            self.lineView.frame = rect;
            self.lineView.center = CGPointMake(sender.center.x, self.lineView.center.y);
            [self setTitleLocationCenter:sender];
        }];
        [self setInsureTypeWithSelect:indexSelect-1];
    }
}
- (void)setTitleLocationCenter:(UIButton *)selected {
    if (AllWidth <= ScreenWindowWidth) return;
    CGFloat offsetX = MAX(0, (selected.center.x - ScreenWindowWidth * 0.5));
    CGFloat maxOffsetX = MAX(0, (self.titleScrollView.contentSize.width - ScreenWindowWidth));
    offsetX = MIN(offsetX, maxOffsetX);
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
-(void)getTitlesWidthWithArray:(NSArray *)array
{
    NSMutableArray *arrayWidth = [NSMutableArray arrayWithCapacity:0];
    for (NSString *key in array) {
        CGRect tempRectHot = [key  boundingRectWithSize:CGSizeMake(200*WIDTH,14*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*WEIGHT]}context:nil];
        [arrayWidth addObject:[NSString stringWithFormat:@"%f",tempRectHot.size.width+
                               5]];
    }
    widths = arrayWidth;
}
-(void)backClick
{
    NSArray *arrays = self.navigationController.viewControllers;
    MallTabBarViewController *tabBarVC = arrays[0];
    tabBarVC.itemSelect = self.selectItem;
    [self.navigationController popToViewController:tabBarVC animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 61*HEIGHT;
    }
    return 48*HEIGHT;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 61*HEIGHT)];
        headerView.backgroundColor = LYColor_A7;
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 13*HEIGHT, ScreenWindowWidth, 48*HEIGHT)];
        whiteView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(18*WIDTH, 18*HEIGHT, 100*WIDTH, 12*WIDTH)];
        titleLab.text = @"公司类型";
        titleLab.textColor = LYColor_A4;
        titleLab.font = [UIFont systemFontOfSize:12*WIDTH];
        [whiteView addSubview:titleLab];
        [headerView addSubview:whiteView];
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreButton addTarget:self action:@selector(insuremoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:moreButton];
        [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(whiteView);
            make.width.equalTo(@(100*WIDTH));
        }];
        UIImageView *firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xialaicon"]];
        [moreButton addSubview:firstImageView];
        firstImageView.userInteractionEnabled = NO;
        [firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(moreButton).with.offset(-18*WIDTH);
            make.centerY.equalTo(moreButton);
            make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*WIDTH));
        }];
        UILabel *moreLab = [[UILabel alloc] init];
        moreLab.text = @"查看更多";
        moreLab.font = [UIFont systemFontOfSize:12*WIDTH];
        moreLab.textColor = LYColor_A4;
        moreLab.textAlignment = NSTextAlignmentRight;
        moreLab.userInteractionEnabled =NO;
        [moreButton addSubview:moreLab];
        [moreLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(firstImageView.mas_left).with.offset(-7*WIDTH);
            make.centerY.equalTo(firstImageView);
            make.left.equalTo(moreButton);
            make.height.equalTo(@(12*HEIGHT));
        }];
        return headerView;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 48*HEIGHT)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(18*WIDTH, 18*HEIGHT, 100*WIDTH, 12*WIDTH)];
    titleLab.text = @"保险类型";
    titleLab.textColor = LYColor_A4;
    titleLab.font = [UIFont systemFontOfSize:12*WIDTH];
    [headerView addSubview:titleLab];

    return headerView;
}
-(void)insuremoreBtnClick
{
    if (firstHeight == 88*HEIGHT) {
        if (insureArrays.count>8) {
            CGFloat gao = (insureArrays.count-8)/4*42*HEIGHT;
            firstHeight = gao;
        }
        firstHeight = 88*HEIGHT;
    }else{
        firstHeight = 88*HEIGHT;
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tabView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return firstHeight;
    }
    return secondHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 59*HEIGHT)];
    footerView.backgroundColor = [UIColor whiteColor];
    NSInteger count = insureArrays.count;
    if (firstHeight == 88*HEIGHT) {
        if (count>8) {
            count = 8;
        }
    }
    __block UIButton *lastBtn = nil;
    int intes = 18*HEIGHT;
    int num = 4;
    for (int i = 0; i < count; i++) {
        MallInsure *insure = insureArrays[i];
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:13*HEIGHT];
        [searchBtn setTitle:insure.insurerName forState:UIControlStateNormal];
        [searchBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        searchBtn.layer.cornerRadius = 2.0f;
        [searchBtn setBackgroundColor:LYColor_A7];
        searchBtn.clipsToBounds = YES;
        [searchBtn addTarget:self action:@selector(insureClick:) forControlEvents:UIControlEventTouchUpInside];
        searchBtn.tag = i+1;
        [footerView addSubview:searchBtn];
        // 添加约束
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(29*HEIGHT);
            if (lastBtn) {
                make.width.equalTo(lastBtn);
            } else {
                if (i % num != 0) {
                    make.width.mas_equalTo((searchBtn.superview.frame.size.width - (num + 1)* intes)/4);
                }
            }
            if (i % num == 0) {
                make.left.mas_equalTo(searchBtn.superview).offset(intes);
            } else {
                make.left.mas_equalTo(lastBtn.mas_right).offset(intes);
            }
            if (i % num == (num - 1)) {
                make.right.mas_equalTo(searchBtn.superview).offset(-intes);
            }
            if (i / num == 0) {
                make.top.mas_equalTo(searchBtn.superview).offset(0);
            } else {
                make.top.mas_equalTo(0 + ( i / num )* (25*HEIGHT + intes));
            }
        }];
        lastBtn = searchBtn;
    }
    
    return footerView;
}
-(void)insureClick:(UIButton *)sender
{
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndifire = @"cellIndifire";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndifire];
    }
    return cell;
}
-(void)resetBtnClick:(UIButton *)sender
{
    NSLog(@"------+++++++++");
}
-(void)sureBtnClick:(UIButton *)sender
{
    NSLog(@"------");
}
#pragma mark  ---Controller--
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+50*HEIGHT, ScreenWindowWidth, ScreenWindowHeight-64-50*HEIGHT) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.backgroundColor = LYColor_A7;
        _tabView.separatorColor = [UIColor clearColor];
    }
    return _tabView;
}
- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWindowWidth, 50*HEIGHT)];
        _titleScrollView.backgroundColor = UIColorRGBA(250, 250, 250, 1);
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.delegate = self;
    }
    return _titleScrollView;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView    = [[UIView alloc] initWithFrame:CGRectMake(18*WIDTH, 50*HEIGHT-2, [widths[0] floatValue], 2)];
        _lineView.backgroundColor = LYColor_A1;
    }
    return _lineView;
}
-(UIButton *)resetBtn
{
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn addTarget:self action:@selector(resetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH];

        [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        _resetBtn.backgroundColor = [UIColor whiteColor];
        [_resetBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];

    }
    return _resetBtn;
}
-(UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _sureBtn.backgroundColor = LYColor_A1;
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH];
    }
    return _sureBtn;
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
