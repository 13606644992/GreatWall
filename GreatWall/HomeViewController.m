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
#import "HomeCellModel.h"
#import "HomeBangDingPhoneVC.h"
#import "MallTabBarViewController.h"
#import "MallViewController.h"
#import "LYMD5.h"
#import "MessageCenterController.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,AEImagePlayerViewDelegate,UISearchBarDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UILabel *titleLab;
    NSInteger indexSelect;//防止状态栏变色
    NSInteger isfirst;//
    NSInteger UADfirst;//
    UIView *bottomline;
}
@property (nonatomic ,strong) HomeCellModel *model;

@property (nonatomic ,strong) UITableView *tabView;
/** 存放所有cell的高度 */
@property (strong, nonatomic) NSMutableArray *headers;
@property (strong, nonatomic) NSMutableArray *productSpecials;
@property (strong, nonatomic) NSMutableArray *banners;
@property (strong, nonatomic) NSMutableArray *xhbs;
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
@property (nonatomic ,strong) UIImageView *searchImg;//搜索图标
@property (nonatomic ,strong) UIButton *upBtn;//
@property (nonatomic ,strong) UIView *upView;//



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self loadViewIfNeeded];
       [self.view addSubview:self.tabView];
    [self setViewHeader];
    isfirst = 0;UADfirst=0;
    [self getMessageWithTheFirstRequest];
    [self setTheUpView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    indexSelect = 0;
    self.navigationController.navigationBarHidden= NO;
    CGFloat  source =  self.tabView.contentOffset.y/64;
    if (source>=0.9) {
        source = 0.9;
    }else if (source<0){
        source = 0;
    }
    self.whiteView.alpha = source;
    if (self.tabView.contentOffset.y>=64) {
        self.searchBtn.backgroundColor = LYColor_A6;
        self.msgbutton.selected = YES;
        self.searchImg.image = [UIImage imageNamed:@"sousuo(2)"];
        titleLab.textColor = LYColor_A5;
        bottomline.hidden = NO;
        StatusBarBlack;
    }else{
        self.searchBtn.backgroundColor = LYColor_A7;
        self.searchImg.image = [UIImage imageNamed:@"sousuohome"];
        titleLab.textColor = [UIColor whiteColor];
        StatusBarWhite;
        self.msgbutton.selected = NO;
        bottomline.hidden = YES;
    }
    self.navigationItem.titleView.alpha = 0.9;
    self.searchBtn.alpha = 0.9;
    [self selectTheUserIsUpToB];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

//导航头
-(void)setViewHeader
{
    //渐变色图片
    [self.navigationController.navigationBar insertSubview:self.whiteView belowSubview:self.navigationController.view];
    [self.navigationController.navigationBar sendSubviewToBack:self.whiteView];
    
    //搜索按钮
    [self.navigationController.navigationBar addSubview: self.searchBtn];

    //搜索图片
    self.searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuohome"]];
    self.searchImg.frame = CGRectMake(0, 5, 12*WEIGHT, 12*HEIGHT);
    [self.navigationController.navigationBar addSubview:self.searchImg];
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 50*WEIGHT, 12*HEIGHT)];
    //    titleLab.textColor =[LYColor colorWithHexString:@"f0fff9"];
    titleLab.textColor =[UIColor whiteColor];
    titleLab.center = CGPointMake(ScreenWindowWidth/2, 22);
    self.searchImg.center = CGPointMake(ScreenWindowWidth/2-37*WEIGHT, 22);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:12*WEIGHT];
    titleLab.text = @"搜索产品";
    [self.navigationController.navigationBar addSubview:titleLab];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonPress:)];
    [titleLab addGestureRecognizer:gesture];
    
    
    //通知按钮
    self.msgbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.msgbutton setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [self.msgbutton setBackgroundImage:[UIImage imageNamed:@"message(zhuse)"] forState:UIControlStateSelected];
    self.msgbutton.frame = CGRectMake(1.5,0,25, 25);
    [self.msgbutton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    UIView * msgView= [[UIView alloc] initWithFrame:CGRectMake(0 ,0 ,25 ,25)];
    [msgView addSubview:self.msgbutton];
    // 添加角标
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:msgView];
    self.navigationItem.rightBarButtonItem = navLeftButton;
    self.navigationItem.rightBarButtonItem.badgeValue = @"";
    self.navigationItem.rightBarButtonItem.badgeBGColor = [LYColor colorWithHexString:@"#ff5d59"];
    

    bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-1, self.navigationController.navigationBar.frame.size.width, 0.5)];
    bottomline.backgroundColor = [LYColor colorWithHexString:@"#e3e3e3"];
    [self.navigationController.navigationBar addSubview:bottomline];
    [self.navigationController.navigationBar bringSubviewToFront:bottomline];
}
//搜索按钮
-(void)searchClick
{
    self.navigationController.navigationBarHidden= NO;
    self.hidesBottomBarWhenPushed=YES;
    SearchController *searchVC = [[SearchController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

//-(void)
-(void)getMessageWithTheFirstRequest
{
    dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue3, ^{
        //Message
        [DataGreatWall PostTheFirstMessageWith:nil Block:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
            if (error) {
                NSLog(@"网络或系统错误----%@-",error);
            }else if ([respCode isEqualToString:@"000000"]){
                self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%@",totalCount];
            }else{
                NSLog(@"请求失败-----%@",respMsg);
            }
        }];

    });
    dispatch_async(queue3, ^{
        //Banner
        [DataGreatWall PostTheBannerListWith:nil WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
            
            if (error) {
                
                NSLog(@"网络或系统错误----%@-",error);
                
            }else if ([respCode isEqualToString:@"000000"]){
                
                self.banners = array;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tabView reloadData];
                });
                
            }else{
                
                NSLog(@"请求失败-----%@",respMsg);
                
            }
        }];

    });
    dispatch_async(queue3, ^{
        //XHB
        [DataGreatWall PostTheXHBMessageWith:nil WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
            if (error) {
                
                NSLog(@"网络或系统错误----%@-",error);
                
            }else if ([respCode isEqualToString:@"000000"]){
                
                self.xhbs = array;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tabView reloadData];     
                });
                
            }else{
                
                NSLog(@"请求失败-----%@",respMsg);
                
            }
            
        }];

    });
    dispatch_async(queue3, ^{
        
        //首页快捷入口
        [DataGreatWall PostTheProductTypeWithTheFirst:nil WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
            if (error) {
                
                NSLog(@"网络或系统错误----%@-",error);
                
            }else if ([respCode isEqualToString:@"000000"]){
                
                self.productSpecials = array;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tabView reloadData];
                });
                
            }else{
                
                NSLog(@"请求失败-----%@",respMsg);
                
            }
        }];

    });
    dispatch_async(queue3, ^{
        //首页商品
        [DataGreatWall PostTheFistProductWith:nil WithBlcok:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
            if (error) {
                
                NSLog(@"网络或系统错误----%@-",error);
                
            }else if ([respCode isEqualToString:@"000000"]){
                
                self.headers = array;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tabView reloadData];
                });
                
            }else{
                
                NSLog(@"请求失败-----%@",respMsg);
                
            }
        }];
    });
}

#pragma mark ------ScrollDelegate---------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (indexSelect == 0) {
        if ([scrollView isEqual:self.tabView]) {
            CGFloat  source =  scrollView.contentOffset.y/64;
            if (source>=0.9) {
                source = 0.9;
            }else if (source<0){
                source = 0;
            }
            self.whiteView.alpha = source;
            if (scrollView.contentOffset.y>=64) {
                self.searchBtn.backgroundColor = LYColor_A6;
                titleLab.textColor = LYColor_A5;
                self.msgbutton.selected = YES;
                self.searchImg.image = [UIImage imageNamed:@"sousuo(2)"];
                bottomline.hidden = NO;
                StatusBarBlack;
            }else{
                self.searchBtn.backgroundColor = LYColor_A7;
                self.searchImg.image = [UIImage imageNamed:@"sousuohome"];
                titleLab.textColor = [UIColor whiteColor];
                StatusBarWhite;
                self.msgbutton.selected = NO;
                bottomline.hidden = YES;
            }
        }
     }
}
#pragma mark -----MJRefresh----------
-(void)MJHeaderLoadTable
{
    [self getMessageWithTheFirstRequest];
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:1.0f];
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
    self.hidesBottomBarWhenPushed=YES;
    MessageCenterController *baseVC = [[MessageCenterController alloc] init];
    [self.navigationController pushViewController:baseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark --------TableView-----------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132*HEIGHT;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headers.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0){
        return 0;
    }
    HomeHeader *header = self.headers[section-1];
    return header.productList.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        //爆款推荐
        HomeHeader *header = self.headers[indexPath.section-1];
        HomeProduct *model = header.productList[indexPath.row];
        HomeCell *cell = [HomeCell cellWithTableView: tableView];
        cell.model = model;
        cell.lineView.hidden = NO;
        if (indexPath.row==header.productList.count-1) {
            cell.lineView.hidden = YES;
        }
        return cell;
    }
    //精选专题
    HomeHeader *header = self.headers[indexPath.section-1];
    HomeProduct *model = header.productList[indexPath.row];
    HomeSiftCell *cell = [HomeSiftCell cellWithTableView:tableView];
    if (indexPath.row==header.productList.count-1) {
        cell.lineView.hidden = YES;cell.bezierView.hidden = NO;
    }else{
        cell.lineView.hidden = NO;cell.bezierView.hidden = YES;
    }

    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
//        NSLog(@"%@",IS_Bclient);
        if ([IS_Bclient integerValue] == 0) {
            return 307*HEIGHT;
        }
        return 355*HEIGHT;
    }else if (section==1){
        return 50*HEIGHT;
    }
    return 156*HEIGHT;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeHeader *header = self.headers[indexPath.section-1];
    HomeProduct *model = header.productList[indexPath.row];
    indexSelect = 1;
    self.hidesBottomBarWhenPushed=YES;
    DescriptionController *baseVC = [[DescriptionController alloc] init];
    baseVC.productId = model.productId;
    [self.navigationController pushViewController:baseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
        make.right.equalTo(moreImg.mas_left).with.offset(-6.5*WEIGHT);
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
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 156*HEIGHT)];
    HeaderView.backgroundColor = [UIColor whiteColor];
//    专题图片
    UIButton *siftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [siftBtn1 addTarget:self action:@selector(siftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    siftBtn1.tag = section+1;
    siftBtn1.frame = CGRectMake(13*WEIGHT, 21*HEIGHT, ScreenWindowWidth-26*WEIGHT, 135*HEIGHT);
    HomeHeader *header = self.headers[section-1];
    [siftBtn1 sd_setImageWithURL:[NSURL URLWithString:header.specialLogo] forState:UIControlStateNormal placeholderImage:PlaceImage];
//    切割图片
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:siftBtn1.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2)];
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
        make.right.equalTo(WhiteView).with.offset(-6.5*WEIGHT);
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
//    SVProgress(@"更多");
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"Home_Typeindex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.tabBarController.selectedIndex=2;
    

}
//精选更多
-(void)othermoreClick
{
    NSLog(@"--jingxuan-更多");
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"Home_Typeindex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    SVProgress(@"精选加载更多");
    self.tabBarController.selectedIndex=2;

}
#pragma mark -----ScrollViewDelegate---UADScroll------
//一区区头，轮播图，快报，快捷栏
-(UIView *)setPlayerWithHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 362.5*HEIGHT)];
    headerView.backgroundColor = LYColor_A7;
    __block NSMutableArray *imageArays = [NSMutableArray arrayWithCapacity:0];
    [self.banners enumerateObjectsUsingBlock:^(HomeScroll *obj, NSUInteger idx, BOOL * _Nonnull
      stop) {
        [imageArays addObject:obj.adURL];
    }];

    //    轮播图
  
    AEImagePlayerView *playerView = [[AEImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 192.5*HEIGHT)];
    _playerView = playerView;
    
    if (imageArays.count>0) {
        playerView.imageUrls = imageArays;//设置默认图片
    }
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
    if (self.farView.subviews.count==0) {
        [self setFarViewWith:self.farView];
    }
//    轮播图遮盖图
    [headerView addSubview:self.bannerConner];
    [self.bannerConner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView);
        make.bottom.mas_equalTo(playerView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(375*WEIGHT, 32*HEIGHT));
    }];
    if ([IS_Bclient integerValue] == 1) {
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
        //    汇报轮播图
        __block NSMutableArray *xhbtitleArray = [NSMutableArray arrayWithCapacity:0];
        [self.xhbs enumerateObjectsUsingBlock:^(HomeXHBList *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [xhbtitleArray addObject:obj.msgContent];
        }];
        if (UADfirst == 0) {
            if (xhbtitleArray.count>0) {
                UADfirst = 10;
                CGFloat kuan = ScreenWindowWidth-114*WEIGHT;
                 NSInteger height = 43*HEIGHT;
                UADScrollView *ccpView = [[UADScrollView alloc] initWithFrame:CGRectMake(0, 0, kuan,height)];
                ccpView.titleArray = [[NSArray alloc]initWithArray:xhbtitleArray];
                ccpView.titleFont = 13*WIDTH;
                ccpView.titleColor = LYColor_A3;
                ccpView.BGColor = [UIColor whiteColor];
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
            }
        }
    }
     return headerView;
}
//快捷栏（一区）
-(void)setFarViewWith:(UIView *)view{
//    快捷栏图片
    NSInteger count = self.productSpecials.count;//设置一排view的个数
//    NSLog(@"----%ld",count);

    if (count>5) {
        count=5;
    }
    NSInteger height = 119*HEIGHT;//设置view的高度
    CGFloat kuan = ScreenWindowWidth/count;
    CGFloat imageKuan = 46*WEIGHT;
    for (int i = 0; i < count; i ++) {
        HomeSpecial *special = self.productSpecials[i];
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*kuan, imageKuan+37*HEIGHT, kuan, 13*HEIGHT)];
        typeLabel.font = [UIFont systemFontOfSize:13*WEIGHT];
        typeLabel.text = special.insurerTypeName;
        typeLabel.textColor = LYColor_A3;
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:typeLabel];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23*HEIGHT, imageKuan, imageKuan)];
        imageView.center = CGPointMake(typeLabel.center.x, imageView.center.y);
        [imageView sd_setImageWithURL:[NSURL URLWithString:special.insurerTypeLogo] placeholderImage:PlaceImage];
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
    HomeSpecial *special = self.productSpecials[sender.tag -1];
    [[NSUserDefaults standardUserDefaults] setObject:special.insurerTypeName forKey:@"Home_index"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.tabBarController.selectedIndex=1;
}
//图片轮播器代理
- (void)imagePlayerView:(AEImagePlayerView *)playerview didClickIndex:(long long)index{
    //    NSLog(@"---%lld",index);
    NSString *str = [NSString stringWithFormat:@"第%lld张",index];
    
    SVProgress(str);
}



#pragma mark  -----签约代理人--------------
-(void)upToQianYueClick{
    self.upBtn.hidden = YES;
    [UIView animateWithDuration:0.5f animations:^{
        self.upView.frame = CGRectMake(18*WIDTH, ScreenWindowHeight-59-245*HEIGHT, ScreenWindowWidth-36*WIDTH, 245*HEIGHT);
    }];
}
-(void)selectTheUserIsUpToB
{
    [DataGreatWall PostTheUserUpToBWithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
        if (error) {
            
        }else if ([respCode isEqualToString:@"000000"]){
            
            
            NSLog(@"----%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Is_First"]);
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"Is_First"] isEqualToString:@"Y"]) {
                self.upBtn.hidden = NO;
                //xiao
            }else{
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setValue:@"Y" forKey:@"Is_First"];
                [user synchronize];
                [UIView animateWithDuration:0.5f animations:^{
                    self.upView.frame = CGRectMake(18*WIDTH, ScreenWindowHeight-59-245*HEIGHT, ScreenWindowWidth-36*WIDTH, 245*HEIGHT);
                }];
                //da
            }
        }else{
         
            
            
            
        }
    }];
}
-(void)setTheUpView
{
    [self.view addSubview:self.upBtn];
    [self.upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(135*WIDTH, 22*HEIGHT));
    }];
    [self.view addSubview:self.upView];
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b2c-bg"]];
    [self.upView addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.upView);
    }];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:12*WIDTH];
    [self.upView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.equalTo(@(10*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(45*WIDTH, 27*HEIGHT));
    }];
    UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [upBtn setTitle:@"马上升级" forState:UIControlStateNormal];
    upBtn.backgroundColor = UIColorRGBA(36, 160, 112, 1);
    upBtn.layer.cornerRadius = 2.0f;
    upBtn.clipsToBounds = YES;
    [upBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [upBtn addTarget:self action:@selector(upToClick) forControlEvents:UIControlEventTouchUpInside];
    upBtn.titleLabel.font = [UIFont systemFontOfSize:12*WIDTH];
    [self.upView addSubview:upBtn];
    [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10*WIDTH);
        make.top.equalTo(@(10*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(72*WIDTH, 27*HEIGHT));
    }];
    
    //成为签约代理人
    UILabel *beDaiLab = [[UILabel alloc] init];
    beDaiLab.textColor = [UIColor whiteColor];
    beDaiLab.text = @"成为签约代理人";
    beDaiLab.textAlignment = NSTextAlignmentCenter;
    beDaiLab.font = [UIFont fontWithName:JiaCu size:21*WIDTH];
    [self.upView addSubview:beDaiLab];
    [beDaiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.upView);
        make.top.equalTo(@(55*HEIGHT));
        make.height.equalTo(@(21*HEIGHT));
    }];
    
    //升级资格
    UILabel *betypeLab = [[UILabel alloc] init];
    betypeLab.textColor = [UIColor whiteColor];
    betypeLab.text = @"您有升级资格，从此赚钱不愁";
    betypeLab.textAlignment = NSTextAlignmentCenter;
    betypeLab.font = [UIFont systemFontOfSize:12*WIDTH];
    [self.upView addSubview:betypeLab];
    [betypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.upView);
        make.top.mas_equalTo(beDaiLab.mas_bottom).with.offset(7*HEIGHT);
        make.height.equalTo(@(21*HEIGHT));
    }];
    
    UIImageView *typeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b2c-zhanshi"]];
    [self.upView addSubview:typeImg];
    [typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(@(-18*WIDTH));
        make.top.mas_equalTo(betypeLab.mas_bottom).with.offset(18*HEIGHT);
        make.bottom.equalTo(@(-18*HEIGHT));
    }];
    
    
}
-(void)upToClick{
    
    if (GJ_Mobile) {
        [DataGreatWall PostUpToBWithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
            if (error) {
            }else if ([respCode isEqualToString:@"000000"]){
                self.result = @"1";
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"GJ_isBClient"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tabView reloadData];
                });
            }else{
                
            };
        }];
    }else{
        NSLog(@"去升级");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"成为签约代理人必须先绑定手机号码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"马上绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.hidesBottomBarWhenPushed=YES;
            HomeBangDingPhoneVC *searchVC = [[HomeBangDingPhoneVC alloc] init];
            [self.navigationController pushViewController:searchVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
-(void)setResult:(NSString *)result
{
    if ([result isEqualToString:@"1"]) {
        self.upBtn.hidden = YES;
        for (UIView *view in self.upView.subviews) {
            [view removeFromSuperview];
        }
        UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b2c-bg"]];
        [self.upView addSubview:bgImg];
        [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.upView);
        }];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:12*WIDTH];
        [self.upView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.top.equalTo(@(10*HEIGHT));
            make.size.mas_equalTo(CGSizeMake(45*WIDTH, 27*HEIGHT));
        }];
        UIImageView *succerrImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b2c-chenggong"]];
        [self.upView addSubview:succerrImg];
        [succerrImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.upView);
            make.top.equalTo(@(35*HEIGHT));
            make.size.mas_equalTo(CGSizeMake(54*WIDTH, 63*HEIGHT));
        }];
        
        //升级成功
        UILabel *beDaiLab = [[UILabel alloc] init];
        beDaiLab.textColor = [UIColor whiteColor];
        beDaiLab.text = @"升级成功";
        beDaiLab.textAlignment = NSTextAlignmentCenter;
        beDaiLab.font = [UIFont fontWithName:JiaCu size:21*WIDTH];
        [self.upView addSubview:beDaiLab];
        [beDaiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.upView);
            make.top.mas_equalTo(succerrImg.mas_bottom).with.offset(21*HEIGHT);
            make.height.equalTo(@(21*HEIGHT));
        }];
        
        //成为签约代理人
        UILabel *betypeLab = [[UILabel alloc] init];
        betypeLab.textColor = [UIColor whiteColor];
        betypeLab.text = @"您已升级成签约代理人";
        betypeLab.textAlignment = NSTextAlignmentCenter;
        betypeLab.font = [UIFont systemFontOfSize:12*WIDTH];
        [self.upView addSubview:betypeLab];
        [betypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.upView);
            make.top.mas_equalTo(beDaiLab.mas_bottom).with.offset(7*HEIGHT);
            make.height.equalTo(@(21*HEIGHT));
        }];
        
        
        UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [upBtn setTitle:@"马上去赚钱" forState:UIControlStateNormal];
        upBtn.backgroundColor = [UIColor whiteColor];
        upBtn.layer.cornerRadius = 2.0f;
        upBtn.clipsToBounds = YES;
        [upBtn setTitleColor:LYColor_A1  forState:UIControlStateNormal];
        [upBtn addTarget:self action:@selector(goupToMakeClick) forControlEvents:UIControlEventTouchUpInside];
        upBtn.titleLabel.font = [UIFont systemFontOfSize:12*WIDTH];
        [self.upView addSubview:upBtn];
        [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.upView);
            make.top.mas_equalTo(betypeLab.mas_bottom).with.offset(23*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(207*WIDTH, 45*HEIGHT));
        }];
    }
}
-(void)goupToMakeClick{
    
    NSLog(@"zhuanqian--------");
    self.hidesBottomBarWhenPushed=YES;
    MallViewController *mallVC = [[MallViewController alloc]init];
    [self.navigationController pushViewController:mallVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
-(void)backAction
{
    [UIView animateWithDuration:0.5f animations:^{
        self.upView.frame = CGRectMake(18*WIDTH, ScreenWindowHeight, ScreenWindowWidth-36*WIDTH, 245*HEIGHT);
    }];
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
        [_searchBtn setBackgroundColor:LYColor_A7];
        _searchBtn.frame = CGRectMake(18*WEIGHT, 5, 306*WEIGHT, 32);
        [_searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
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
        _locaImages = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _locaImages;
}
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, ScreenWindowWidth, ScreenWindowHeight+5) style:UITableViewStyleGrouped];
        _tabView.tag = 10086;
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
- (NSMutableArray *)banners
{
    if (!_banners) {
        _banners = [NSMutableArray arrayWithCapacity:0];
    }
    return _banners;
}
- (NSMutableArray *)xhbs
{
    if (!_xhbs) {
        _xhbs = [NSMutableArray arrayWithCapacity:0];
    }
    return _xhbs;
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
        _whiteView.backgroundColor = [UIColor whiteColor];
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
-(NSMutableArray *)productSpecials
{
    if (!_productSpecials) {
        _productSpecials = [NSMutableArray arrayWithCapacity:0];
    }
    return _productSpecials;
}
-(NSMutableArray *)headers
{
    if (!_headers) {
        _headers = [NSMutableArray arrayWithCapacity:0];
    }
    return _headers;
}
-(UIView *)upView{
    if (!_upView) {
        _upView = [[UIView alloc] initWithFrame:CGRectMake(18*WIDTH, ScreenWindowHeight, ScreenWindowWidth-36*WIDTH, 245*HEIGHT)];
    }
    return _upView;
}
-(UIButton *)upBtn{
    if (!_upBtn) {
        _upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_upBtn setImage:[UIImage imageNamed:@"c2b-shengji"] forState:UIControlStateNormal];
        [_upBtn setBackgroundImage:[UIImage imageNamed:@"c2b-shengji"] forState:UIControlStateNormal];
        [_upBtn setTitle:@"升级成签约代理人" forState:UIControlStateNormal];
        [_upBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_upBtn addTarget:self action:@selector(upToQianYueClick) forControlEvents:UIControlEventTouchUpInside];
        _upBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
        _upBtn.hidden = YES;
    }
    return _upBtn;
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
