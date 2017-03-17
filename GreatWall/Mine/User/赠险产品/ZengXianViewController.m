//
//  ZengXianViewController.m
//  GreatWall
//
//  Created by GJ on 2017/2/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ZengXianViewController.h"
#import "Header.h"
#import "KeLingQuVC.h"
#import "YiShiYongVC.h"
#import "YiGuoQiZengXianVC.h"
@interface ZengXianViewController ()
@property (nonatomic, strong)UIButton *kelingquBtn;
@property (nonatomic, strong)UIButton *yishiyongBtn;
@property (nonatomic, strong)UIButton *yiguoqiBtn;
@property (nonatomic, strong)UIView *hengXian;
@property (nonatomic, strong)UIScrollView *zoomScrollView;
@property (nonatomic, strong)KeLingQuVC *kelingquVC;
@property (nonatomic, strong)YiShiYongVC *yishiyongVC;
@property (nonatomic, strong)YiGuoQiZengXianVC *yiguoqizengxianVC;
@end

@implementation ZengXianViewController
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
    self.navigationItem.title = @"赠险产品";
    
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

    
    [background addSubview:self.kelingquBtn];
    [self.kelingquBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset(- ScreenWindowWidth / 3);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.yishiyongBtn];
    [self.yishiyongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.yiguoqiBtn];
    [self.yiguoqiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset( ScreenWindowWidth / 3);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    //底部滑动横线
    [background addSubview:self.hengXian];
    [self.hengXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(background);
        make.centerX.mas_equalTo(self.kelingquBtn);
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
    self.kelingquVC = [[KeLingQuVC alloc]init];
    [self addChildViewController:self.kelingquVC];
    [self.kelingquVC didMoveToParentViewController:self];
    self.kelingquVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.kelingquVC.view];
    
    self.yishiyongVC = [[YiShiYongVC alloc]init];
    [self addChildViewController:self.yishiyongVC];
    [self.yishiyongVC didMoveToParentViewController:self];
    self.yishiyongVC.view.frame = CGRectMake( ScreenWindowWidth, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.yishiyongVC.view];
    
    self.yiguoqizengxianVC = [[YiGuoQiZengXianVC alloc]init];
    [self addChildViewController:self.yiguoqizengxianVC];
    [self.yiguoqizengxianVC didMoveToParentViewController:self];
    self.yiguoqizengxianVC.view.frame = CGRectMake( ScreenWindowWidth * 2, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.yiguoqizengxianVC.view];
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
- (UIButton *)kelingquBtn{
    if (!_kelingquBtn) {
        _kelingquBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _kelingquBtn.backgroundColor = [UIColor clearColor];
        [_kelingquBtn setTitle:@"可领取" forState:UIControlStateNormal];
        [_kelingquBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _kelingquBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_kelingquBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _kelingquBtn.tag = 1000;
    }
    return _kelingquBtn;
}
- (UIButton *)yishiyongBtn{
    if (!_yishiyongBtn) {
        _yishiyongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yishiyongBtn.backgroundColor = [UIColor clearColor];
        [_yishiyongBtn setTitle:@"已使用" forState:UIControlStateNormal];
        [_yishiyongBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _yishiyongBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_yishiyongBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _yishiyongBtn.tag = 1001;
    }
    return _yishiyongBtn;
}
- (UIButton *)yiguoqiBtn{
    if (!_yiguoqiBtn) {
        _yiguoqiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yiguoqiBtn.backgroundColor = [UIColor clearColor];
        [_yiguoqiBtn setTitle:@"已过期" forState:UIControlStateNormal];
        [_yiguoqiBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _yiguoqiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_yiguoqiBtn addTarget:self action:@selector(selectTheViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _yiguoqiBtn.tag = 1002;
    }
    return _yiguoqiBtn;
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
