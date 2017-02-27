//
//  WodedingdanViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/18.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "WodedingdanViewController.h"
#import "Header.h"
#import "QuanBuVC.h"
#import "DaiZhiFuVC.h"
#import "YiWanChengVC.h"
@interface WodedingdanViewController ()
@property (nonatomic, strong)UIButton *quanbuBtn;
@property (nonatomic, strong)UIButton *daizhifuBtn;
@property (nonatomic, strong)UIButton *yiwanchengBtn;
@property (nonatomic, strong)UIView *hengXian;
@property (nonatomic, strong)UIScrollView *zoomScrollView;
@property (nonatomic, strong)QuanBuVC *quanbuVC;
@property (nonatomic, strong)DaiZhiFuVC *daizhifuVC;
@property (nonatomic, strong)YiWanChengVC *yiwanchengVC;

@end

@implementation WodedingdanViewController

- (void)viewWillAppear:(BOOL)animated{
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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的订单";
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
    //切换按钮
    
    [background addSubview:self.quanbuBtn];
    [self.quanbuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset(- ScreenWindowWidth / 3);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.daizhifuBtn];
    [self.daizhifuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.yiwanchengBtn];
    [self.yiwanchengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset( ScreenWindowWidth / 3);
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
    self.zoomScrollView.contentSize = CGSizeMake(self.zoomScrollView.frame.size.width * 3, 0);
    self.zoomScrollView.delegate = self;
    self.zoomScrollView.showsHorizontalScrollIndicator = NO;
    
    //添加子试图控制器
    self.quanbuVC = [[QuanBuVC alloc]init];
    [self addChildViewController:self.quanbuVC];
    [self.quanbuVC didMoveToParentViewController:self];
    self.quanbuVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.quanbuVC.view];
    
    self.daizhifuVC = [[DaiZhiFuVC alloc]init];
    [self addChildViewController:self.daizhifuVC];
    [self.daizhifuVC didMoveToParentViewController:self];
    self.daizhifuVC.view.frame = CGRectMake( ScreenWindowWidth, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.daizhifuVC.view];

    self.yiwanchengVC = [[YiWanChengVC alloc]init];
    [self addChildViewController:self.yiwanchengVC];
    [self.yiwanchengVC didMoveToParentViewController:self];
    self.yiwanchengVC.view.frame = CGRectMake( ScreenWindowWidth * 2, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.yiwanchengVC.view];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.zoomScrollView) {
        CGFloat bili = (self.zoomScrollView.contentOffset.x + ScreenWindowWidth / 2 ) / self.zoomScrollView.contentSize.width;
        self.hengXian.center = CGPointMake(ScreenWindowWidth * bili, self.hengXian.center.y);
        
    }
}
- (void)selectTheViewWithButton:(UIButton *)sender{
    [UIView animateWithDuration:0.2 animations:^{
        if (sender.tag == 1000) {
            [self.zoomScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }else if (sender.tag == 1001){
            [self.zoomScrollView setContentOffset:CGPointMake(ScreenWindowWidth, 0) animated:NO];
        }else{
            [self.zoomScrollView setContentOffset:CGPointMake(ScreenWindowWidth * 2, 0) animated:NO];
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
- (UIButton *)daizhifuBtn{
    if (!_daizhifuBtn) {
        _daizhifuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _daizhifuBtn.backgroundColor = [UIColor clearColor];
        [_daizhifuBtn setTitle:[NSString stringWithFormat:@"待支付"] forState:UIControlStateNormal];
        [_daizhifuBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _daizhifuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_daizhifuBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _daizhifuBtn.tag = 1001;
    }
    return _daizhifuBtn;
}
- (UIButton *)yiwanchengBtn{
    if (!_yiwanchengBtn) {
        _yiwanchengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yiwanchengBtn.backgroundColor = [UIColor clearColor];
        [_yiwanchengBtn setTitle:[NSString stringWithFormat:@"已完成"] forState:UIControlStateNormal];
        [_yiwanchengBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _yiwanchengBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_yiwanchengBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _yiwanchengBtn.tag = 1002;
    }
    return _yiwanchengBtn;
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
