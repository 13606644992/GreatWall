//
//  HomeViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "HomeViewController.h"
#import "Header.h"
#import "HomeCell.h"
#import "HomeSiftCell.h"
#import "HomeCellModel.h"
#import "SearchController.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,AEImagePlayerViewDelegate,UISearchBarDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UILabel *titleLab;
}
@property (nonatomic ,strong) UITableView *tabView;
/** 存放所有cell的高度 */
@property (strong, nonatomic) NSMutableDictionary *heights;
@property (nonatomic, weak)AEImagePlayerView *playerView;//图片轮播器
@property (nonatomic, strong)NSMutableArray *locaImages;//图片
@property (nonatomic ,strong) UIButton *searchBtn;//搜索按钮
@property (nonatomic ,strong) UILabel *bulletinLab;//快报分割线
@property (nonatomic ,strong) UIImageView *bulletinImg;//快报图片
@property (nonatomic ,strong) UIView *bulleView;//快报背景
@property (nonatomic ,strong) UIView *farView;//状态栏背景
@property (nonatomic, strong)NSArray *farTitleArrays;//快捷栏标题数组
@property (nonatomic, strong)NSArray *farImgArrays;//快捷栏图片数组
@property (nonatomic ,strong) UIImageView *HostImg;//爆款推荐图片
@property (nonatomic ,strong) UIView *whiteView;//区头透明度图片
@property (nonatomic ,strong) UIButton *msgbutton;//通知按钮
@property (nonatomic ,strong) UIImageView *bannerConner;//轮播图遮盖图

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadViewIfNeeded];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.view addSubview:self.tabView];
    [self setViewHeader];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //状态栏颜色
    if (self.tabView.contentOffset.y>=64) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    self.navigationController.navigationBarHidden= NO;
    self.navigationItem.titleView.alpha = 0.8;
    self.searchBtn.alpha = 0.8;

}
//导航头
-(void)setViewHeader
{
    //渐变色图片
    [self.navigationController.navigationBar insertSubview:self.whiteView belowSubview:self.navigationController.view];
    //搜索按钮
    [self.navigationController.navigationBar addSubview: self.searchBtn];
    //通知按钮
    self.msgbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.msgbutton setBackgroundImage:[UIImage imageNamed:@"tongzhi"] forState:UIControlStateNormal];
    self.msgbutton.frame = CGRectMake(1.5,0,25, 25);
    [self.msgbutton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    UIView * msgView= [[UIView alloc] initWithFrame:CGRectMake(0 ,0 ,25 ,25)];
    [msgView addSubview:self.msgbutton];
    // 添加角标
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:msgView];
    self.navigationItem.rightBarButtonItem = navLeftButton;
    self.navigationItem.rightBarButtonItem.badgeValue = @"5";
    self.navigationItem.rightBarButtonItem.badgeBGColor = [LYColor colorWithHexString:@"#ff5d59"];
    //搜索图片
    UIImageView *searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo"]];
    searchImg.frame = CGRectMake(0, 5, 12*WEIGHT, 12*HEIGHT);
    [self.navigationController.navigationBar addSubview:searchImg];
    //搜索文字
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 50*WEIGHT, 12*HEIGHT)];
    titleLab.textColor =[LYColor colorWithHexString:@"f0fff9"];
    titleLab.center = CGPointMake(ScreenWindowWidth/2, 22);
    searchImg.center = CGPointMake(ScreenWindowWidth/2-37*WEIGHT, 22);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:12*WEIGHT];
    titleLab.text = @"搜索产品";
    [self.navigationController.navigationBar addSubview:titleLab];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonPress:)];
    [titleLab addGestureRecognizer:gesture];
}
//搜索按钮
-(void)searchClick
{
    self.hidesBottomBarWhenPushed=YES;
    SearchController *searchVC = [[SearchController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark ------ScrollDelegate---------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tabView]) {
        CGFloat  source =  scrollView.contentOffset.y/64;
        if (source>=0.8) {
            source = 0.8;
        }else if (source<0){
            source = 0;
        }
        self.whiteView.alpha = source;
        if (scrollView.contentOffset.y>=64) {
            self.searchBtn.backgroundColor = LYColor_A6;
             [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }else{
            self.searchBtn.backgroundColor = [UIColor whiteColor];
             [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        }
    }
}
#pragma mark -----MJRefresh----------
-(void)MJHeaderLoadTable
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2.0f];
}
-(void)MJSetFooterTable
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2.0f];
}
-(void)endRefresh{
    [self.tabView.mj_header endRefreshing];
//    [self.tabView.mj_footer endRefreshing];
}
#pragma mark -----消息中心----
-(void)buttonPress:(UIButton *)sender
{
    self.navigationItem.rightBarButtonItem.badgeValue = @"";
//    self.hidesBottomBarWhenPushed=YES;
//    SquareController *baseVC = [[SquareController alloc] init];
//    [self.navigationController pushViewController:baseVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark --------TableView-----------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132*HEIGHT;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1){
        return 3;
    }else if (section==2||section==3){
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        //爆款推荐
        HomeCellModel *mode = [[HomeCellModel alloc] init];
        HomeCell *cell = [HomeCell cellWithTableView: tableView];
        cell.model = mode;
//        NSLog(@"")
        cell.indexPathRow = indexPath.row;
        return cell;
    }
    //精选专题
    HomeCellModel *mode = [[HomeCellModel alloc] init];
    HomeSiftCell *cell = [HomeSiftCell cellWithTableView:tableView];
    cell.indexPathRow = indexPath.row;
    cell.model = mode;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 355*HEIGHT;
    }else if (section==1){
        return 50*HEIGHT;
    }
    return 140*HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 13*HEIGHT;
    }else if (section==1) {
        return 63*HEIGHT;
    }
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        //一区区头，轮播图，快报，快捷栏
        return [self setPlayerWithHeaderView];
    }else if (section==1){
        //二区区头（爆款推荐）
        return [self setSectionOneHeaderView];
    }
    ////精选专题区头
    return [self setSectionOtherViewHeaderWithSection:section];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        //精选专题（二区区足）
        return [self sectionOneView];
    }
    return nil;
}
//二区区头（爆款推荐）
-(UIView *)setSectionOneHeaderView
{
    UIView *HeaderView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 13*HEIGHT, ScreenWindowWidth-20, 50*HEIGHT)];
    HeaderView2.backgroundColor = [UIColor whiteColor];
    [HeaderView2 addSubview:self.HostImg];
    __weak UIView *hView=HeaderView2;
    //爆款图片
    [self.HostImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(hView);
        make.size.mas_equalTo(CGSizeMake(147*WEIGHT, 20*HEIGHT));
    }];
//    更多
    UIImageView *moreImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiayibu"]];
    [HeaderView2 addSubview:moreImg];
    [moreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(hView).with.offset(-11*WEIGHT);
        make.centerY.equalTo(hView);
        make.size.mas_equalTo(CGSizeMake(7*WEIGHT, 11*HEIGHT));
    }];
    UILabel *moreLab = [[UILabel alloc] init];
    moreLab.text = @"更多";
    moreLab.textColor = LYColor_A4;
    moreLab.font = [UIFont systemFontOfSize:11*WEIGHT];
    moreLab.textAlignment = NSTextAlignmentRight;
    [HeaderView2 addSubview:moreLab];
    [moreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moreImg.mas_left).with.offset(-11*WEIGHT);
        make.centerY.equalTo(hView);
        make.size.mas_equalTo(CGSizeMake(30*WEIGHT, 11*HEIGHT));
    }];
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [HeaderView2 addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(hView.mas_right).with.offset(-11*WEIGHT);
        make.centerY.equalTo(hView);
        make.width.equalTo(@(50*WEIGHT));
        make.height.equalTo(@(30*HEIGHT));
    }];
//    分割线
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50*HEIGHT-0.8, ScreenWindowWidth, 0.8)];
    bgImg.backgroundColor = UIColorRGBA(227, 227, 227, 1);
    [HeaderView2 addSubview:bgImg];
      return HeaderView2;
}
//精选专题区头
-(UIView *)setSectionOtherViewHeaderWithSection:(NSInteger)section
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 140*HEIGHT)];
    HeaderView.backgroundColor = [UIColor whiteColor];
//    专题图片
    UIButton *siftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [siftBtn1 addTarget:self action:@selector(siftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    siftBtn1.tag = section+1;
    siftBtn1.frame = CGRectMake(13*WEIGHT, 21*HEIGHT, ScreenWindowWidth-26*WEIGHT, 119*HEIGHT);
    [siftBtn1 sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"01.jpg"]];
//    切割图片
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:siftBtn1.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = siftBtn1.bounds;
    maskLayer.path = maskPath.CGPath;
    siftBtn1.layer.mask = maskLayer;
    [HeaderView addSubview:siftBtn1];
    return HeaderView;
}
//精选专题（二区区足）
-(UIView *)sectionOneView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 63*HEIGHT)];
    UIView *WhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 13*HEIGHT, ScreenWindowWidth, 50*HEIGHT)];
    WhiteView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:WhiteView];
//    专题图片
    UIImageView *hotImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jingxuanzhuanti"]];
    [WhiteView addSubview:hotImg];
    [hotImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(WhiteView);
        make.size.mas_equalTo(CGSizeMake(67*WEIGHT, 15*HEIGHT));
    }];
//    更多
    UIImageView *moreImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiayibu"]];
    [WhiteView addSubview:moreImg];
    [moreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(WhiteView).with.offset(-11*WEIGHT);
        make.centerY.equalTo(WhiteView);
        make.size.mas_equalTo(CGSizeMake(7*WEIGHT, 11*HEIGHT));
    }];
    UILabel *moreLab = [[UILabel alloc] init];
    moreLab.text = @"更多";
    moreLab.textColor = LYColor_A4;
    moreLab.font = [UIFont systemFontOfSize:11*WEIGHT];
    moreLab.textAlignment = NSTextAlignmentRight;
    [WhiteView addSubview:moreLab];
    [moreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moreImg.mas_left).with.offset(-11*WEIGHT);
        make.centerY.equalTo(WhiteView);
        make.size.mas_equalTo(CGSizeMake(30*WEIGHT, 11*HEIGHT));
    }];
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn addTarget:self action:@selector(othermoreClick) forControlEvents:UIControlEventTouchUpInside];
    [WhiteView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WhiteView.mas_right).with.offset(-11*WEIGHT);
        make.centerY.equalTo(WhiteView);
        make.width.equalTo(@(50*WEIGHT));
        make.height.equalTo(@(30*HEIGHT));
    }];
//    分割线
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63*HEIGHT-0.8, ScreenWindowWidth, 0.8)];
    bgImg.backgroundColor = UIColorRGBA(227, 227, 227, 1);
    [footView addSubview:bgImg];
    return footView;
}
#pragma mark ----更多------------------
//爆款更多
-(void)moreClick{
    
    NSLog(@"---更多");
    SVProgress(@"更多");
    
}
//精选更多
-(void)othermoreClick
{
    NSLog(@"--jingxuan-更多");
    
    SVProgress(@"精选加载更多");
}
#pragma mark -----ScrollViewDelegate---UADScroll------
//一区区头，轮播图，快报，快捷栏
-(UIView *)setPlayerWithHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 362.5*HEIGHT)];
    headerView.backgroundColor = LYColor_A7;
//    轮播图
    AEImagePlayerView *playerView = [[AEImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 192.5*HEIGHT)];
    _playerView = playerView;
    playerView.images = self.locaImages;//设置默认图片
    playerView.delegate = self;
    playerView.pageLocation = AEPageViewLocationCenter;
    [headerView addSubview:playerView];
//    状态按钮
    [headerView addSubview:self.farView];
    [self.farView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(0);
        make.top.mas_equalTo(playerView.mas_bottom).with.offset(0);
        make.right.equalTo(headerView).with.offset(0);
        make.height.equalTo(@(119*HEIGHT));
    }];
    [self setFarViewWith:self.farView];
//    轮播图遮盖图
    [headerView addSubview:self.bannerConner];
    [self.bannerConner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView);
        make.bottom.mas_equalTo(playerView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(375*WEIGHT, 32*HEIGHT));
    }];
//    广播
    [headerView addSubview:self.bulleView];
    [self.bulleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headerView).with.offset(0);
        make.top.mas_equalTo(self.farView.mas_bottom).with.offset(1*HEIGHT);
        make.right.equalTo(headerView).with.offset(0);
        make.height.equalTo(@(43*HEIGHT));
    }];
    [self.bulleView addSubview:self.bulletinImg];
//    小汇报图片
    [self.bulletinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bulleView).with.offset(18*WEIGHT);
        make.centerY.mas_equalTo(self.bulleView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(56*WEIGHT, 14*HEIGHT));
    }];
    [self.bulleView addSubview:self.bulletinLab];
//    小汇报文字
    [self.bulletinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bulletinImg.mas_right).with.offset(11*WEIGHT);
        make.centerY.mas_equalTo(self.bulleView.mas_centerY);
        make.height.equalTo(@(15*HEIGHT));
        make.width.equalTo(@(1*WEIGHT));
    }];
    CGFloat kuan = ScreenWindowWidth-114*WEIGHT;
    NSInteger height = 43*HEIGHT;
//    汇报轮播图
    UADScrollView *ccpView = [[UADScrollView alloc] initWithFrame:CGRectMake(0, 0, kuan,height)];
    ccpView.titleArray = [NSArray arrayWithObjects:@"亲爱的朋友们2016年还有100天就要过去了,2017年您准备好了吗?",@"今年双11您预算了几个月的工资？",@"高德与百度互掐，你更看好哪方？", nil];
    ccpView.titleColor = LYColor_A3;
    ccpView.BGColor = [UIColor whiteColor];
    ccpView.titleFont = 13*HEIGHT;
//    汇报轮播点击按钮
    [ccpView clickTitleLabel:^(NSInteger index,NSString *titleString) {
        NSLog(@"%ld-----%@",index,titleString);
    }];
    [self.bulleView addSubview:ccpView];
    [ccpView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bulletinLab.mas_right).with.offset(11*WEIGHT);
        make.top.equalTo(self.bulleView).with.offset(0);
        make.height.equalTo(@(height));
        make.width.equalTo(@(kuan));
    }];
    [self.view layoutIfNeeded];
    return headerView;
}
//快捷栏（一区）
-(void)setFarViewWith:(UIView *)view{
//    快捷栏图片
    NSInteger count = 5;//设置一排view的个数
    NSInteger height = 119*HEIGHT;//设置view的高度
    CGFloat kuan = ScreenWindowWidth/5;
    CGFloat imageKuan = 46*WEIGHT;
    for (int i = 0; i < count; i ++) {
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*kuan, imageKuan+37*HEIGHT, kuan, 13*HEIGHT)];
        typeLabel.font = [UIFont systemFontOfSize:13*WEIGHT];
        typeLabel.text = self.farTitleArrays[i];
        typeLabel.textColor = LYColor_A3;
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:typeLabel];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23*HEIGHT, imageKuan, imageKuan)];
        imageView.center = CGPointMake(typeLabel.center.x, imageView.center.y);
        imageView.image = [UIImage imageNamed:self.farImgArrays[i]];
        [view addSubview:imageView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*kuan, 0, kuan, height);
        button.tag = i+1;
        [button addTarget:self action:@selector(farClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
}
//精选专题更多
-(void)siftBtnClick:(UIButton *)sender
{
    NSLog(@"----%ld",sender.tag);
    SVProgress(@"精选专题");
}
//快捷通道按钮
-(void)farClick:(UIButton *)sender
{
    NSLog(@"-----%ld",sender.tag-1);
    
    SVProgress(self.farTitleArrays[sender.tag-1]);
    
}
//图片轮播器代理
- (void)imagePlayerView:(AEImagePlayerView *)playerview didClickIndex:(long long)index{
    //    NSLog(@"---%lld",index);
    NSString *str = [NSString stringWithFormat:@"第%lld张",index];
    
    SVProgress(str);
}
#pragma mark ----------Anything--------------------
-(UIImageView *)HostImg
{
    if (!_HostImg) {
        _HostImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baokuantuijian"]];
    }
    return _HostImg;
}
-(UIImageView *)bulletinImg
{
    if (!_bulletinImg) {
        _bulletinImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xioahuibao"]];
    }
    return _bulletinImg;
}
-(UILabel *)bulletinLab
{
    if (!_bulletinLab) {
        _bulletinLab = [[UILabel alloc] init];
        _bulletinLab.backgroundColor = LYColor_A6;
    }
    return _bulletinLab;
}
-(UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setBackgroundColor:[UIColor whiteColor]];
        _searchBtn.frame = CGRectMake(18*WEIGHT, 5, 306*WEIGHT, 32);
        [_searchBtn setTitleColor:[LYColor colorWithHexString:@"f0fff9"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_searchBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15, 15)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _searchBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        _searchBtn.layer.mask = maskLayer;
    }
    return _searchBtn;
}
-(NSMutableArray *)locaImages
{
    if (!_locaImages) {
        _locaImages = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"01.jpg"],[UIImage imageNamed:@"222.jpg"],[UIImage imageNamed:@"01.jpg"],[UIImage imageNamed:@"222.jpg"], nil];
    }
    return _locaImages;
}
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, ScreenWindowWidth, ScreenWindowHeight+5) style:UITableViewStyleGrouped];
        _tabView.backgroundColor = LYColor_A7;
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.showsVerticalScrollIndicator = NO;
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self MJHeaderLoadTable];
        }];
    }
    return _tabView;
}
- (NSMutableDictionary *)heights
{
    if (!_heights) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}
-(UIView *)bulleView
{
    if (!_bulleView) {
        _bulleView = [[UIView alloc] init];
        _bulleView.backgroundColor = [UIColor whiteColor];
    }
    return _bulleView;
}
-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ScreenWindowWidth,64)];
        _whiteView.backgroundColor = [UIColor whiteColor ];
        _whiteView.alpha = 0;
        _whiteView.userInteractionEnabled = NO;
    }
    return _whiteView;
}
-(UIView *)farView
{
    if (!_farView) {
        _farView = [[UIView alloc] init];
        _farView.backgroundColor = [UIColor whiteColor];
    }
    return _farView;
}
-(NSArray *)farTitleArrays
{
    if (!_farTitleArrays) {
        _farTitleArrays = @[@"车险",@"人寿险",@"健康险",@"意外险",@"财产险"];
    }
    return _farTitleArrays;
}
-(NSArray *)farImgArrays
{
    if (!_farImgArrays) {
        _farImgArrays = @[@"chexian",@"renshouxian",@"jiankangxian",@"yiwaixian",@"caichanxian"];
    }
    return _farImgArrays;
}
-(UIImageView *)bannerConner
{
    if (!_bannerConner) {
        _bannerConner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bannerConner.png"]];
    }
    return _bannerConner;
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
