//
//  CarTypeController.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/2.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CarTypeController.h"
#import "NewPagedFlowView.h"
#import "Header.h"
#import "PGIndexBannerSubiew.h"
#import "ChangeCarTypeController.h"
#import "CarOrderController.h"

@interface CarTypeController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
{
    NSInteger indexSelect;
    UIView *topView;
}
/**
 *  轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation CarTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYColor_A1;
    [self setTheCarTypeTopView];
    [self setUpTheViewWithTypePage];
    indexSelect = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTypeClick:) name:@"changeType" object:nil];
    
    
    
}
-(void)setTheCarTypeTopView
{
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = LYColor_A1;
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"选择投保方案";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"jiantou_bai"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(CarTypeSelectbackClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}


-(void)CarTypeSelectbackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setUpTheViewWithTypePage{

//    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 20*HEIGHT, ScreenWindowWidth,445*HEIGHT)];
    pageFlowView.backgroundColor =LYColor_A1;
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.7;
    pageFlowView.minimumPageScale = 0.9;
    pageFlowView.orginPageCount = 3;
    pageFlowView.isOpenAutoScroll = NO;

    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 475*HEIGHT, ScreenWindowWidth, 6)];
    pageControl.clipsToBounds = YES;
//    pageControl.backgroundColor = [UIColor redColor];
    pageFlowView.pageControl = pageControl;
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWindowWidth, ScreenWindowHeight-64)];
    [pageFlowView reloadData];
    
    [bottomScrollView addSubview:pageControl];

    [bottomScrollView addSubview:pageFlowView];
    [self.view addSubview:bottomScrollView];

    
    self.pageFlowView = pageFlowView;
    
    [self.view addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-21*HEIGHT);
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(44*HEIGHT));
    }];

}
-(void)sureClick{
    NSLog(@"---------");
    
    self.hidesBottomBarWhenPushed=YES;
    CarOrderController *baseVC = [[CarOrderController alloc] init];
    [self.navigationController pushViewController:baseVC animated:YES];

    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)changeTypeClick:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed=YES;
    ChangeCarTypeController *baseVC = [[ChangeCarTypeController alloc] init];
    [self.navigationController pushViewController:baseVC animated:YES];
}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(259*WIDTH, 410*HEIGHT);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    indexSelect = subIndex;
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return 3;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, 259*WIDTH, 410*HEIGHT)];
        bannerView.backgroundColor = [UIColor whiteColor];
        bannerView.layer.cornerRadius = 4.0f;
    }

    return bannerView;
}
#pragma mark --旋转屏幕改变newPageFlowView大小之后实现该方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [coordinator animateAlongsideTransition:^(id context) { [self.pageFlowView reloadData]; } completion:NULL];
    }
}
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"TestViewController 滚动到了第%ld页",(long)pageNumber);
    indexSelect = pageNumber;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = [UIColor whiteColor];
        _sureBtn.layer.cornerRadius = 4.0f;
        _sureBtn.clipsToBounds = YES;
        [_sureBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH];
    }
    return _sureBtn;
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
