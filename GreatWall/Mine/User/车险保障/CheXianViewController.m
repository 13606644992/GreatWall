//
//  CheXianViewController.m
//  GreatWall
//
//  Created by GJ on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CheXianViewController.h"
#import "Header.h"
#import "QuanBuCheXianVC.h"
#import "DaiChuDanCheXianVC.h"
#import "YiChuDanCheXianVC.h"
#import "YiZhongZhiCheXianVC.h"
@interface CheXianViewController ()
@property (nonatomic, strong)UIButton *quanbuBtn;
@property (nonatomic, strong)UIButton *daichudanBtn;
@property (nonatomic, strong)UIButton *yichudanBtn;
@property (nonatomic, strong)UIButton *yizhongzhiBtn;
@property (nonatomic, strong)UIView *hengXian;
@property (nonatomic, strong)UIScrollView *zoomScrollView;

@property (nonatomic, strong)QuanBuCheXianVC *quanbuVC;
@property (nonatomic, strong)DaiChuDanCheXianVC *daichudanVC;
@property (nonatomic, strong)YiChuDanCheXianVC *yichudanVC;
@property (nonatomic, strong)YiZhongZhiCheXianVC *yizhongzhiVC;
@end

@implementation CheXianViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
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
    self.navigationItem.title = @"车险保单";
    //黑线
    UIView *line_first = [[UIView alloc]init];
    line_first.backgroundColor = LYColor_A6;
    [self.view addSubview:line_first];
    [line_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = UIColorRGBA(250, 250, 250, 1);
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_first.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    //黑线2
    UIView *line_second = [[UIView alloc]init];
    line_second.backgroundColor = LYColor_A6;
    [self.view addSubview:line_second];
    [line_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [background addSubview:self.quanbuBtn];
    [self.quanbuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset(- ScreenWindowWidth / 8 * 3);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.daichudanBtn];
    [self.daichudanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset(- ScreenWindowWidth / 8);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.yichudanBtn];
    [self.yichudanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset(ScreenWindowWidth / 8);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.yizhongzhiBtn];
    [self.yizhongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset(ScreenWindowWidth / 8 * 3);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    
    //底部滑动横线
    [background addSubview:self.hengXian];
    [self.hengXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(background);
        make.centerX.mas_equalTo(self.quanbuBtn);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(55);
    }];
    
    [self.view layoutIfNeeded];
    
    //大scrollView
    [self.view addSubview:self.zoomScrollView];
    [self.zoomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_second.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.zoomScrollView layoutIfNeeded];
    self.zoomScrollView.contentSize = CGSizeMake(self.zoomScrollView.frame.size.width * 4, 0);
    self.zoomScrollView.delegate = self;
    self.zoomScrollView.showsHorizontalScrollIndicator = NO;
    //添加子试图控制器
    self.quanbuVC = [[QuanBuCheXianVC alloc]init];
    [self addChildViewController:self.quanbuVC];
    [self.quanbuVC didMoveToParentViewController:self];
    self.quanbuVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.quanbuVC.view];
    
    self.daichudanVC = [[DaiChuDanCheXianVC alloc]init];
    [self addChildViewController:self.daichudanVC];
    [self.daichudanVC didMoveToParentViewController:self];
    self.daichudanVC.view.frame = CGRectMake( ScreenWindowWidth, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.daichudanVC.view];
    
    self.yichudanVC = [[YiChuDanCheXianVC alloc]init];
    [self addChildViewController:self.yichudanVC];
    [self.yichudanVC didMoveToParentViewController:self];
    self.yichudanVC.view.frame = CGRectMake( ScreenWindowWidth * 2, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.yichudanVC.view];
    
    self.yizhongzhiVC = [[YiZhongZhiCheXianVC alloc]init];
    [self addChildViewController:self.yizhongzhiVC];
    [self.yizhongzhiVC didMoveToParentViewController:self];
    self.yizhongzhiVC.view.frame = CGRectMake( ScreenWindowWidth * 3, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.yizhongzhiVC.view];
    
     self.hidesBottomBarWhenPushed = YES;//隐藏tabbar
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.zoomScrollView) {
        CGFloat bili = (self.zoomScrollView.contentOffset.x + ScreenWindowWidth / 2 ) / self.zoomScrollView.contentSize.width;
        self.hengXian.center = CGPointMake(ScreenWindowWidth * bili, self.hengXian.center.y);
        
    }
}
- (void)selectTheViewWithButton:(UIButton *)sender{
    NSLog(@"%ld", sender.tag);
    [UIView animateWithDuration:0.2 animations:^{
        if (sender.tag == 1000) {
            [self.zoomScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }else if (sender.tag == 1001){
            [self.zoomScrollView setContentOffset:CGPointMake(ScreenWindowWidth, 0) animated:NO];
        }else if (sender.tag == 1002){
            [self.zoomScrollView setContentOffset:CGPointMake(ScreenWindowWidth * 2, 0) animated:NO];
        }else{
            [self.zoomScrollView setContentOffset:CGPointMake(ScreenWindowWidth * 3, 0) animated:NO];
        }
    }];
}
/************懒加载      *******************/
- (UIButton *)quanbuBtn{
    if (!_quanbuBtn) {
        _quanbuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _quanbuBtn.backgroundColor = [UIColor clearColor];
        [_quanbuBtn setTitle:[NSString stringWithFormat:@"全部"] forState:UIControlStateNormal];
        [_quanbuBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _quanbuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_quanbuBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _quanbuBtn.tag = 1000;
    }
    return _quanbuBtn;
}
- (UIButton *)daichudanBtn{
    if (!_daichudanBtn) {
        _daichudanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _daichudanBtn.backgroundColor = [UIColor clearColor];
        [_daichudanBtn setTitle:[NSString stringWithFormat:@"待出单"] forState:UIControlStateNormal];
        [_daichudanBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _daichudanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_daichudanBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _daichudanBtn.tag = 1001;
    }
    return _daichudanBtn;
}
- (UIButton *)yichudanBtn{
    if (!_yichudanBtn) {
        _yichudanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yichudanBtn.backgroundColor = [UIColor clearColor];
        [_yichudanBtn setTitle:[NSString stringWithFormat:@"已出单"] forState:UIControlStateNormal];
        [_yichudanBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _yichudanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_yichudanBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _yichudanBtn.tag = 1002;
    }
    return _yichudanBtn;
}
- (UIButton *)yizhongzhiBtn{
    if (!_yizhongzhiBtn) {
        _yizhongzhiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yizhongzhiBtn.backgroundColor = [UIColor clearColor];
        [_yizhongzhiBtn setTitle:[NSString stringWithFormat:@"已终止"] forState:UIControlStateNormal];
        [_yizhongzhiBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _yizhongzhiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_yizhongzhiBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _yizhongzhiBtn.tag = 1003;
    }
    return _yizhongzhiBtn;
}
- (UIView *)hengXian{
    if (!_hengXian) {
        _hengXian = [[UIView alloc]init];
        _hengXian.backgroundColor = LYColor_A1;
        
    }
    return _hengXian;
}
- (UIScrollView *)zoomScrollView{
    if (!_zoomScrollView) {
        _zoomScrollView = [[UIScrollView alloc]init];
        _zoomScrollView.backgroundColor = LYColor_A7;
        
        _zoomScrollView.contentOffset = CGPointMake(0, 0);
        _zoomScrollView.pagingEnabled = YES;
        _zoomScrollView.bounces = NO;
    }
    return _zoomScrollView;
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
