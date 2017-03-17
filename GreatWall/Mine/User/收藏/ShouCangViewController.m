//
//  ShouCangViewController.m
//  GreatWall
//
//  Created by GJ on 2017/3/14.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ShouCangViewController.h"
#import "ChanPinViewController.h"
#import "JiHuaShuViewController.h"
#import "XueXiViewController.h"
#import "Header.h"

@interface ShouCangViewController ()
@property (nonatomic, strong)UIButton *chanPinBtn;
@property (nonatomic, strong)UIButton *jiHuaShuBtn;
@property (nonatomic, strong)UIButton *xueXiBtn;
@property (nonatomic, strong)UIView *hengXian;
@property (nonatomic, strong)UIScrollView *zoomScrollView;
@property (nonatomic, strong)ChanPinViewController *chanPinVC;
@property (nonatomic, strong)JiHuaShuViewController *jiHuaShuVC;
@property (nonatomic, strong)XueXiViewController *xuexiVC;
@end

@implementation ShouCangViewController

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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"收藏";
    
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
        make.height.mas_equalTo(1);
    }];
    
    
    [background addSubview:self.chanPinBtn];
    [self.chanPinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset(- ScreenWindowWidth / 3);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.jiHuaShuBtn];
    [self.jiHuaShuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.xueXiBtn];
    [self.xueXiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset( ScreenWindowWidth / 3);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    //底部滑动横线
    [background addSubview:self.hengXian];
    [self.hengXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(background);
        make.centerX.mas_equalTo(self.chanPinBtn);
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
    self.chanPinVC = [[ChanPinViewController alloc]init];
    [self addChildViewController:self.chanPinVC];
    [self.chanPinVC didMoveToParentViewController:self];
    self.chanPinVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.chanPinVC.view];
    
    self.jiHuaShuVC = [[JiHuaShuViewController alloc]init];
    [self addChildViewController:self.jiHuaShuVC];
    [self.jiHuaShuVC didMoveToParentViewController:self];
    self.jiHuaShuVC.view.frame = CGRectMake( ScreenWindowWidth, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.jiHuaShuVC.view];
    
    self.xuexiVC = [[XueXiViewController alloc]init];
    [self addChildViewController:self.xuexiVC];
    [self.xuexiVC didMoveToParentViewController:self];
    self.xuexiVC.view.frame = CGRectMake( ScreenWindowWidth * 2, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.xuexiVC.view];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.zoomScrollView) {
        CGFloat bili = (self.zoomScrollView.contentOffset.x + ScreenWindowWidth / 2 ) / self.zoomScrollView.contentSize.width;
        self.hengXian.center = CGPointMake(ScreenWindowWidth * bili, self.hengXian.center.y);
        
    }
}
-(void)selectTheViewWithButton:(UIButton *)sender{
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
- (UIButton *)chanPinBtn{
    if (!_chanPinBtn) {
        _chanPinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chanPinBtn.backgroundColor = [UIColor clearColor];
        [_chanPinBtn setTitle:@"产品" forState:UIControlStateNormal];
        [_chanPinBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _chanPinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_chanPinBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _chanPinBtn.tag = 1000;
    }
    return _chanPinBtn;
}
- (UIButton *)jiHuaShuBtn{
    if (!_jiHuaShuBtn) {
        _jiHuaShuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jiHuaShuBtn.backgroundColor = [UIColor clearColor];
        [_jiHuaShuBtn setTitle:@"计划书" forState:UIControlStateNormal];
        [_jiHuaShuBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _jiHuaShuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_jiHuaShuBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _jiHuaShuBtn.tag = 1001;
    }
    return _jiHuaShuBtn;
}
- (UIButton *)xueXiBtn{
    if (!_xueXiBtn) {
        _xueXiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _xueXiBtn.backgroundColor = [UIColor clearColor];
        [_xueXiBtn setTitle:@"学习" forState:UIControlStateNormal];
        [_xueXiBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _xueXiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_xueXiBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _xueXiBtn.tag = 1002;
    }
    return _xueXiBtn;
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
