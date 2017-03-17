//
//  DescriptionController.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DescriptionController.h"
#import "Header.h"
#import "DescriptionCell.h"
#import "DescriptionTypeTwoCell.h"
#import "DescriptionDateCell.h"
#import "DescriptionCountCell.h"
#import "ApplicantCell.h"
#import "CardTypeCell.h"
#import "CardNumberCell.h"
#import "PayViewController.h"
#import "DescriptionTimeCell.h"
#import "ProductInfoController.h"
#import "ProductFeaturesController.h"
#import "ProductDetailController.h"
#import "ProductClauseController.h"
#import "ProductHealthController.h"
#import "LYShareType.h"
#import "WXApi.h"
#import "AddressSelect.h"

@interface DescriptionController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIView *topView;
    NSString *SelectDate;
    NSMutableArray *selectArr;
    NSInteger indexSelect;
    NSInteger indexBenefit;
    NSArray *times;
    NSArray *cutTimes;
    NSInteger indexTime;
    NSString *indexTitle;
    NSMutableArray *_nameArr;
    NSString *firstFooterSelect;
    NSString *selectStartTime;
    NSInteger selectCount;
    NSInteger cardTypeOne;
    NSInteger cardTypeTwo;
    NSInteger relationType;
    NSString *touName;
    NSString *touCardNum;
    NSString *touCardType;
    NSString *touPhoneNum;
    NSString *beiType;
    NSString *beiName;
    NSString *beiCardType;
    NSString *beiCardNum;
    NSString *priceKeyWord;
    NSString *workType;
    NSMutableArray *array_s;

}
@property(nonatomic,strong)DescriptionModel *model;
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)UIButton *backButton;
@property(nonatomic ,strong)UIButton *collectButton;
@property(nonatomic ,strong)UIView *footView;
@property(nonatomic ,strong)UILabel *amountLab;
@property(nonatomic ,strong)UIButton *shareButton;
@property(nonatomic ,strong)UIImageView *shareImg;
@property(nonatomic ,strong)UILabel *shareLab;
@property(nonatomic ,strong)UILabel *lineLab;
@property(nonatomic ,strong)UIButton *insureBtn;
@property(nonatomic ,strong)UILabel *typeLab;
@property(nonatomic ,strong)UILabel *titleLab;
@property (nonatomic, strong) UIImageView *fanImg;
@property (nonatomic, strong) UILabel *fanLab;
@property (nonatomic, strong) NSArray *fourArray;
@property(nonatomic ,strong)UILabel *perpleType;
@property(nonatomic ,strong)UILabel *otherType;
@property(nonatomic ,strong)UIButton *otherTypeButton;
@property(nonatomic ,strong)UILabel *circleone;
@property(nonatomic ,strong)UILabel *circletwo;
@property(nonatomic ,strong)UIButton *moreButton;
@property(nonatomic ,strong)UIView *clicpView;
@property(nonatomic ,strong)UIImageView *clicpImage;
@property(nonatomic ,strong)UIImageView *safeGuardImage;
@property(nonatomic ,strong)UILabel *safeGuardLab;
@property(nonatomic ,strong)UIButton *moresafeButton;
@property (nonatomic, strong) UIImageView *thirdFoodImg;
@property (nonatomic, strong) UILabel *thirdTitleLab;
@property(nonatomic ,strong)UILabel *clauseLab;
@property(nonatomic ,strong)UIButton *clauseButton;
@property(nonatomic ,strong)UIView *bgView;
@property (nonatomic, strong) NSArray *relationArray;
@property (nonatomic, strong) NSArray *cardTypeArray;


@end

@implementation DescriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = LYColor_A7;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectBtnClick:) name:@"SelectCount" object:nil];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(26);
        make.left.equalTo(self.view).with.offset(18*WEIGHT);
        make.size.mas_equalTo(CGSizeMake(32*WEIGHT, 32*WEIGHT));
    }];
    [self.view addSubview:self.collectButton];
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(26);
        make.right.equalTo(self.view).with.offset(-18*WEIGHT);
        make.size.mas_equalTo(CGSizeMake(32*WEIGHT, 32*WEIGHT));
    }];
    [self setProductInfoTopView];
    [self setTheFootView];
    times = @[];
    indexSelect = 10; selectCount = 1;cardTypeOne=0;cardTypeTwo=0;relationType = 0;workType = @"请选择";
    [self getMsg];
    
    touName = @"李阳";
    touCardNum = @"411424199306122870";
    touPhoneNum = @"17682339656";
    beiName = @"李阳";
    beiCardNum = @"411424199306122870";
}

/**************************/
-(void)getMsg{
    array_s = [NSMutableArray arrayWithCapacity:0];
    NSMutableDictionary *paramer = [NSMutableDictionary dictionaryWithDictionary:@{@"findAllFlag" : @"true"}];
    [GJAFNetWork POST:URL_ALIANG params:paramer method:@"getAreaList" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSArray *areasList = output[@"areasList"];
            
            [areasList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                AreaModel *model = [[AreaModel alloc] init];
                [model setValuesForKeysWithDictionary:obj];
                __block NSMutableArray *childs = [NSMutableArray arrayWithCapacity:0];
                [model.children enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                    AreaModel *model1 = [[AreaModel alloc] init];
                    [model1 setValuesForKeysWithDictionary:obj1];
                    __block NSMutableArray *array2 = [NSMutableArray arrayWithCapacity:0];
                    [model1.children enumerateObjectsUsingBlock:^(id  _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
                        AreaModel *model2 = [[AreaModel alloc] init];
                        [model2 setValuesForKeysWithDictionary:obj2];
                        [array2 addObject:model2];
                    }];
                    model1.children = array2;
                    [childs addObject:model1];
                }];
                model.children = childs;
                [array_s addObject:model];
            }];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    StatusBarBlack;
    [self getMsgReload];
    CGFloat  source =  self.tableView.contentOffset.y/100;
    if (source>=1) {
        source = 1;
    }else if (source<0){
        source = 0;
    }
    topView.alpha = source;
    if (self.tableView.contentOffset.y>=100) {
        self.backButton.hidden = YES;
        self.collectButton.hidden = YES;
        StatusBarBlack;
    }else{
        self.backButton.hidden = NO;
        self.collectButton.hidden = NO;
        StatusBarWhite;
    }
}
-(void)setProductInfoTopView
{
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.alpha = 0;
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"商品详情";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = LYColor_A1;
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];
    
}
#pragma mark ------ScrollDelegate---------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        if ([scrollView isEqual:self.tableView]) {
            CGFloat  source =  scrollView.contentOffset.y/100;
            if (source>=1) {
                source = 1;
            }else if (source<0){
                source = 0;
            }
            topView.alpha = source;
            if (scrollView.contentOffset.y>=64) {
                self.backButton.hidden = YES;
                self.collectButton.hidden = YES;
                StatusBarBlack;
            }else{
                self.backButton.hidden = NO;
                self.collectButton.hidden = NO;
                StatusBarWhite;
            }
        }
    [self getThePostAnyThingWithTF];
}
//数据请求
-(void)getMsgReload{
    [DataGreatWall PostTheProductContentWithProductID:self.productId WithBlock:^(NSString *respCode,NSString *respMsg,DescriptionModel *descriptionModel,NSError *error) {
        if (error) {
            
        }else if ([respCode isEqualToString:@"000000"]){
            self.model = descriptionModel;
            NSArray *array = [self.model.guaranteePeriod componentsSeparatedByString:@";"];
            times = array;
            NSMutableArray *cutArr = [NSMutableArray arrayWithCapacity:0];
            for (NSString *cut in array) {
                if (cut.length>0) {
                    NSArray *_arr = [cut componentsSeparatedByString:@"_"];
                    [cutArr addObject:_arr[0]];
                }
            }
            cutTimes = cutArr;
            SelectDate = @"请选择";
            selectStartTime = @"请选择";
            indexTime = 0;
            workType = @"请选择";
            if (self.model.planList.count>0) {
                DescriptionPlan *plan = self.model.planList[0];
                firstFooterSelect = plan.planName;
            }
            NSData *resData = [[NSData alloc] initWithData:[self.model.priceElements dataUsingEncoding:NSUTF8StringEncoding]];
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
            NSArray *price_element = resultDic[@"price_element"];
            __block NSMutableArray *nameArray = [NSMutableArray arrayWithCapacity:0];
            selectArr = [NSMutableArray arrayWithCapacity:0];
            [price_element enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DescriptionName *name = [[DescriptionName alloc] init];
                name.name = obj[@"name"];
                name.option = [obj[@"option"] componentsSeparatedByString:@","];
                [nameArray addObject:name];
                SelectDate = name.option[0];
                [selectArr addObject:name.option[0]];
            }];
            _nameArr = nameArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                indexBenefit = 0;
                [self.tableView reloadData];
            });
        }else{
            
        }
    }];
}
-(void)selectBtnClick:(NSNotification *)sender
{
    NSDictionary *dic = sender.userInfo;
    NSString *count = dic[@"count"];
    selectCount = [count integerValue];
    [self getPriceWithAnyThing];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self getPriceWithAnyThing];
}
-(void)getPriceWithAnyThing
{
    NSString *changeString = nil;
    
    changeString = [firstFooterSelect stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (NSInteger i=0; i<_nameArr.count; i++) {
        if (i==0) {
            changeString = [NSString stringWithFormat:@"%@;%@",changeString,selectArr[i]];
        }else{
            changeString = [NSString stringWithFormat:@"%@,%@",changeString,selectArr[i]];
        }
    }
    if (times.count>0) {
        changeString = [NSString stringWithFormat:@"%@;%@",changeString,cutTimes[indexTime]];
    }
    NSLog(@"----%@",changeString);
    priceKeyWord  = changeString;
    NSInteger indexCount = [[self selectTheStringWith:changeString] integerValue] *selectCount;
    self.amountLab.text = [NSString stringWithFormat:@"¥ %.01ld",indexCount/100];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(NSString *)selectTheStringWith:(NSString *)string
{
    for (DescriptionPrice *price in self.model.priceList) {
        if ([string isEqualToString:price.priceKeyword]) {
            return price.productPremium;
        }
    }
    return @"0";
}
//底部View
-(void)setTheFootView
{
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(59));
    }];
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = LYColor_A6;
    [self.footView addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.footView);
        make.height.equalTo(@(0.5f));
    }];
    
    [self.footView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.footView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.footView);
        make.width.equalTo(@(110*WIDTH));
    }];
    [self.footView addSubview:self.lineLab];
    [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right);
        make.top.bottom.equalTo(self.footView);
        make.width.equalTo(@(0.5));
    }];
    [self.footView addSubview:self.insureBtn];
    [self.insureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.footView);
        make.width.equalTo(@(114.5*WIDTH));
    }];
    [self.footView addSubview:self.shareImg];
    [self.shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right).with.offset(40*WIDTH);
        make.centerY.equalTo(self.footView);
        make.size.mas_equalTo(CGSizeMake(18*WIDTH, 18*WIDTH));
    }];
    [self.footView addSubview:self.shareLab];
    [self.shareLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shareImg.mas_right).with.offset(6*WIDTH);
        make.centerY.equalTo(self.footView);
        make.size.mas_equalTo(CGSizeMake(40*WIDTH, 18*WIDTH));
    }];
    [self.footView addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right).with.offset(1*WIDTH);
        make.right.mas_equalTo(self.insureBtn.mas_left);
        make.centerY.equalTo(self.footView);
        make.height.equalTo(@(59));
    }];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)collectBtnClick
{
    NSLog(@"收藏");
}

//分享
-(void)shareClick:(UIButton *)sender
{
    
    [[LYShareType shareShareType] LYShareTypeShowMode];
    [[LYShareType shareShareType] LYShareTypeBackSelectBlock:^(NSString *index) {
        NSLog(@"share-------%@",index);
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = self.model.productName;
        message.description = @"描述";

        WXWebpageObject *webpageObject = [WXWebpageObject object];
        
        webpageObject.webpageUrl = @"https://open.weixin.qq.com";
        message.mediaObject = webpageObject;
        
        SendMessageToWXReq *rep = [[SendMessageToWXReq alloc] init];
        rep.bText = NO;
        rep.message = message;
        if ([index isEqualToString:@"1"]) {
            rep.scene = WXSceneSession;
        }else if([index isEqualToString:@"2"]){
            rep.scene = WXSceneTimeline;
        }
        [WXApi sendReq:rep];
    }];
    
    
    
    
}
-(void)toInsureClick:(UIButton *)sender
{
//    NSLog(@"我要投保-------");
    [self getThePostAnyThingWithTF];
    if (!touName||touName.length<=0) {
        SVProgress(@"请输入投保人姓名");
    }else if (!touCardNum||touCardNum.length<=0){
        SVProgress(@"请输入投保人证件号码");
    }else if (!touPhoneNum||touPhoneNum.length<=0){
        SVProgress(@"请输入投保人手机号码");
    }else if (!beiName||beiName.length<=0){
        SVProgress(@"请输入被保人姓名");
    }else if (!beiCardNum||beiCardNum.length<=0){
        SVProgress(@"请输入被保人证件号码");
    }else{
        if (relationType == 3) {
            relationType = 8;
        }
        if (self.model.planList.count>0) {
            DescriptionPlan *plan = self.model.planList[indexBenefit];
            [DataGreatWall PostTheOrderWithTheUserID:GJ_UserID WithTheProductID:self.productId WithThePlanID:plan.planId WithThePeriod:times[indexTime] WithThePriceKeyWord:priceKeyWord WithaTheApplicant:touName WithTheMobile:touPhoneNum WithTheidNo:touCardNum WithTheidType:[NSString stringWithFormat:@"%ld",cardTypeOne+1] WithTheInsuredName:beiName WithTheInsureNo:beiCardNum WithRelationType:[NSString stringWithFormat:@"%ld",relationType+1] WithTheInsureType:[NSString stringWithFormat:@"%ld",cardTypeTwo+1] WithCount:[NSString stringWithFormat:@"%ld",selectCount] WithStartTime:selectStartTime WithBlock:^(NSString *respCode,NSString *respMsg,PayOrderModel *model,NSError *error) {
                if (error) {
                    
                }else if ([respCode isEqualToString:@"000000"]){
                    self.hidesBottomBarWhenPushed=YES;
                    PayViewController *payVC = [[PayViewController alloc] init];
                    payVC.model = model;
                    [self.navigationController pushViewController:payVC animated:YES];
                }else{
                    SVProgress(respMsg);
                }
                
            }];
        }
    }
}
-(void)getThePostAnyThingWithTF
{
    ApplicantCell*cell  = (ApplicantCell *)[self.tableView viewWithTag:1000];
    if (cell) {
        touName = cell.detailTF.text;
    }
    CardTypeCell*typecell = (CardTypeCell *)[self.tableView viewWithTag:1001];
    if (typecell) {
         touCardType = self.cardTypeArray[cardTypeOne];
    }
    CardNumberCell*cardNumcell = (CardNumberCell *)[self.tableView viewWithTag:1002];
    if (cardNumcell) {
        touCardNum = cardNumcell.detailTF.text;
    }
    CardNumberCell*phoneNumcell = (CardNumberCell *)[self.tableView viewWithTag:1003];
    if (phoneNumcell) {
        touPhoneNum = phoneNumcell.detailTF.text;
    }
    CardTypeCell*cardcell = (CardTypeCell *)[self.tableView viewWithTag:1100];
    if (cardcell) {
        beiType = self.relationArray[relationType];
    }
    CardTypeCell*cardcelltwo = (CardTypeCell *)[self.tableView viewWithTag:1102];
    if (cardcelltwo) {
        beiCardType = self.cardTypeArray[cardTypeOne];
    }
    CardNumberCell*cardtypecell = (CardNumberCell *)[self.tableView viewWithTag:1101];
    if (cardtypecell) {
        beiName = cardtypecell.detailTF.text;
    }
    CardNumberCell*cardNumbercell = (CardNumberCell *)[self.tableView viewWithTag:1103];
    if (cardNumbercell) {
        beiCardNum = cardNumbercell.detailTF.text;
    }
}
#pragma mark  -----------Controller--------

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 427*HEIGHT;
    }else if (section ==1){
        return 136*HEIGHT;
    }
    return 43*HEIGHT;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [self setTheFirstHeaderView];
    }else if (section == 1){
        return [self setTheSecondHeaderView];
    }else if (section == 2){
        return [self setTheThirdHeaderView];
    }else if(section == 3){
        return [self setTheFourthHeaderView];
    }
    return [self setTheFivethHeaderView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        NSInteger index = self.model.planList.count;
        if (index<=1) {
            return 63*HEIGHT;
        }
        return 102*HEIGHT;
    }else if (section == 3){
        return 48*HEIGHT;
    }else if (section == 4){
        return 80*HEIGHT;
    }
    return 0.5f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return [self setFirstFooderView];
    }else if (section == 3){
        return [self setTheThidSectionFooderView];
    }else if(section == 4){
        return [self setTheFivethFooderView];
    }
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return _nameArr.count+4;
    }else if (section == 2||section == 3){
        return 4;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56*HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row ==  0) {
            DescriptionTypeTwoCell *cell = [DescriptionTypeTwoCell cellWithTableView:tableView];
            cell.titleLab.text = @"保障时间";
            if (cutTimes.count>0) {
                cell.detialLab.text = cutTimes[indexTime];
            }
            cell.tag = indexPath.row+100;
            return cell;
        }else if (indexPath.row == _nameArr.count+1){
            DescriptionTimeCell *cell = [DescriptionTimeCell cellWithTimeTableView:tableView];
            cell.tag = 66;
            if (![[NSString stringWithFormat:@"%@",self.model.effectiveType] isEqualToString:@"99"]) {
                cell.detialLab.text = self.model.effectDate;
                selectStartTime = self.model.effectDate;
            }else{
                cell.detialLab.text = selectStartTime;
            }
            return cell;
        }else if (indexPath.row == _nameArr.count+2){
            DescriptionTimeCell *cell = [DescriptionTimeCell cellWithTimeTableView:tableView];
            cell.titleLab.text = @"职业类别";
            cell.detialLab.text = workType;
            return cell;
            
        }else if (indexPath.row == _nameArr.count+3){
            DescriptionCountCell *cell = [DescriptionCountCell cellWithTableView:tableView];
            cell.mostCount = [self.model.quota integerValue];
            cell.countLab.text = [NSString stringWithFormat:@"%ld",selectCount];
                       return cell;
        }
        DescriptionName *name = _nameArr[indexPath.row-1];
        DescriptionDateCell *cell = [DescriptionDateCell cellWithTableView:tableView];
        cell.titleLab.text = name.name;
        cell.detialLab.text = selectArr[indexPath.row-1];
        cell.detialLab.textColor = LYColor_A4;
        cell.detialLab.tag = 500+indexPath.row;
        if (SelectDate.length>0||![SelectDate isEqualToString:@"请选择"]) {
            cell.detialLab.textColor = LYColor_A3;
        }
        cell.tag = indexPath.row+100;
        return cell;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            ApplicantCell*cell = [ApplicantCell cellWithTableView:tableView];
            cell.titleLab.text = @"投保人";
            cell.detailTF.placeholder = @"请输入投保人姓名";
            cell.detailTF.text = touName;
            cell.detailTF.delegate = self;

            cell.tag = 1000;
            return cell;
        }else if (indexPath.row == 1){
        CardTypeCell*cell = [CardTypeCell cellWithTableView:tableView];
        cell.titleLab.text = @"证件类型";
        cell.detailLab.text = self.cardTypeArray[cardTypeOne];
        cell.tag = 1001;
        return cell;
        }
        CardNumberCell*cell = [CardNumberCell cellWithTableView:tableView];
        cell.titleLab.text = @"证件号码";
        cell.detailTF.placeholder = @"请输入证件号码";
        cell.detailTF.delegate = self;
        cell.detailTF.text = touCardNum;
        cell.tag = 1000+indexPath.row;
        cell.selectButton.hidden = YES;
        if (indexPath.row == 3) {
            cell.detailTF.text = touPhoneNum;
            cell.titleLab.text = @"手机号码";
            cell.detailTF.placeholder = @"请输入手机号码";
        }
        return cell;
    }
    if (indexPath.row == 0 || indexPath.row == 2) {
        CardTypeCell*cell = [CardTypeCell cellWithTableView:tableView];
        cell.titleLab.text = @"与投保人关系";
        cell.detailLab.text = self.relationArray[relationType];
        cell.tag = 1100+indexPath.row;
        if (indexPath.row == 2) {
            cell.titleLab.text = @"证件类型";
            cell.detailLab.text = self.cardTypeArray[cardTypeTwo];
        }
        return cell;
    }
    CardNumberCell*cell = [CardNumberCell cellWithTableView:tableView];
    cell.titleLab.text = @"被保人";
    cell.tag = 1100+indexPath.row;
    cell.detailTF.placeholder = @"请输入被保人姓名";
    cell.detailTF.delegate = self;
    cell.detailTF.text = beiName;
    cell.selectButton.hidden = NO;
    if (indexPath.row == 3) {
        cell.selectButton.hidden = YES;
        cell.titleLab.text = @"证件号码";
        cell.detailTF.placeholder = @"请输入证件号码";
        cell.detailTF.text = beiCardNum;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1&&indexPath.row!=_nameArr.count+3) {
        if (indexPath.row!=_nameArr.count+1) {
            if (indexPath.row == 0) {
                [[LYPickerView shareShareType] PickerViewShowModeWithArray:cutTimes];
                [[LYPickerView shareShareType] PickerViewBackSelectBlock:^(NSString * string,NSInteger string_index) {
                    indexTitle = string;
                    indexTime = string_index;
                    NSIndexPath *index_Path = [NSIndexPath indexPathForRow:0 inSection:1];
                    [self.tableView reloadRowsAtIndexPaths:@[index_Path] withRowAnimation:UITableViewRowAnimationFade];
                    [self getPriceWithAnyThing];
                }];
            }else if (indexPath.row == _nameArr.count+2){

                [[AddressSelect shareShareType] AddressSelectShowModeWithArray:array_s];
                [[AddressSelect shareShareType] LYShareTypeBackSelectBlock:^(NSString * address,NSString *shi,NSString *qu,NSString *areaId) {
                    NSLog(@"--sheng-%@----shi----%@----qu----%@-----id----%@",address,shi,qu,areaId);
                    
                }];

                
            }else{
                DescriptionName *name = _nameArr[indexPath.row-1];
                [[LYPickerView shareShareType] PickerViewShowModeWithArray:name.option];
                [[LYPickerView shareShareType] PickerViewBackSelectBlock:^(NSString * string,NSInteger string_index) {
                    DescriptionName *nameT = _nameArr[indexPath.row-1];
                    [selectArr removeObjectAtIndex:indexPath.row-1];
                    [nameT.option enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isEqualToString:string]) {
                            [selectArr insertObject:string atIndex:indexPath.row-1];
                            *stop = YES;
                            return;
                        }
                    }];
                    NSIndexPath *index_Path = [NSIndexPath indexPathForRow:indexPath.row inSection:1];
                    [self.tableView reloadRowsAtIndexPaths:@[index_Path] withRowAnimation:UITableViewRowAnimationFade];
                    [self getPriceWithAnyThing];
                }];
            }
        }else{
            if ([[NSString stringWithFormat:@"%@",self.model.effectiveType] isEqualToString:@"99"]) {
                [[LGLDatePickerView shareDatePiker] datePikerShowWithMode:LGLDatePickerModeDate];
                [[LGLDatePickerView shareDatePiker] dateCallBackSelectBlock:^(NSString *date) {
                    selectStartTime = date;
                    [self getPriceWithAnyThing];
                }];
            }
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 1) {
            [[LYPickerView shareShareType] PickerViewShowModeWithArray:self.cardTypeArray];
            [[LYPickerView shareShareType] PickerViewBackSelectBlock:^(NSString * string,NSInteger string_index) {
                cardTypeOne = string_index;
                NSIndexPath *index_Path = [NSIndexPath indexPathForRow:1 inSection:2];
                [self.tableView reloadRowsAtIndexPaths:@[index_Path] withRowAnimation:UITableViewRowAnimationFade];
                [self getPriceWithAnyThing];
            }];
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            [[LYPickerView shareShareType] PickerViewShowModeWithArray:self.relationArray];
            [[LYPickerView shareShareType] PickerViewBackSelectBlock:^(NSString * string,NSInteger string_index) {
                relationType = string_index;
                NSIndexPath *index_Path = [NSIndexPath indexPathForRow:0 inSection:3];
                [self.tableView reloadRowsAtIndexPaths:@[index_Path] withRowAnimation:UITableViewRowAnimationFade];
                [self getPriceWithAnyThing];
            }];
        }else if (indexPath.row == 2){
            
            [[LYPickerView shareShareType] PickerViewShowModeWithArray:self.cardTypeArray];
            [[LYPickerView shareShareType] PickerViewBackSelectBlock:^(NSString * string,NSInteger string_index) {
                cardTypeTwo = string_index;
                NSIndexPath *index_Path = [NSIndexPath indexPathForRow:2 inSection:3];
                [self.tableView reloadRowsAtIndexPaths:@[index_Path] withRowAnimation:UITableViewRowAnimationFade];
                [self getPriceWithAnyThing];
            }];
        }
    }
}
-(void)setSelectCount:(NSInteger *)selectCount
{
    
}
#pragma mark  ----------TheFirstFooder--------
-(UIView *)setFirstFooderView
{
    NSInteger index = self.model.planList.count;
    if (index>3) {
        index=3;
    }
    if (index <= 1) {
        
        UIView *fooderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 63*HEIGHT)];
        fooderView.backgroundColor = LYColor_A7;
        [fooderView addSubview:self.clicpView];
        [self.clicpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(fooderView).with.offset(18*WIDTH);
            make.right.equalTo(fooderView).with.offset(-18*WIDTH);
            make.top.equalTo(fooderView).with.offset(13*HEIGHT);
            make.height.equalTo(@(50*HEIGHT));
        }];
        [fooderView addSubview:self.clicpImage];
        [self.clicpImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(fooderView);
            make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth, 6*HEIGHT));
        }];
        [fooderView addSubview:self.safeGuardImage];
        [self.safeGuardImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.clicpView).with.offset(20*WIDTH);
            make.top.equalTo(self.clicpView).with.offset(16*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(16*WIDTH, 18*WIDTH));
        }];
        indexSelect = 10;
        if (self.model.planList.count>0) {
              DescriptionPlan *plan = self.model.planList[0];
            self.safeGuardLab.text = plan.planName;
        }
        [fooderView addSubview:self.safeGuardLab];
        [self.safeGuardLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.safeGuardImage.mas_right).with.offset(6*WIDTH);
            make.right.equalTo(self.clicpView).with.offset(-20*WIDTH);
            make.centerY.equalTo(self.safeGuardImage);
            make.height.equalTo(@(16*HEIGHT));
        }];
        return fooderView;
    }else{
        UIView *fooderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 102*HEIGHT)];
        fooderView.backgroundColor = LYColor_A7;
        for (NSInteger i = 0; i<index; i++) {
            DescriptionPlan *plan = self.model.planList[i];
            CGFloat kuan = (ScreenWindowWidth-36*WIDTH-5*WIDTH*(index - 1))/index;
            CGFloat kuanjj = 5*WIDTH;
            if (i==0) {
                self.bgView = [[UIView alloc] init];
                self.bgView.frame = CGRectMake(18*WIDTH, 13*HEIGHT, kuan, 89*HEIGHT);
                self.bgView.backgroundColor = [UIColor whiteColor];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kuan, 2*HEIGHT)];
                lab.backgroundColor = LYColor_A1;
                [self.bgView addSubview:lab];
                [fooderView addSubview:self.bgView];
            }
            UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
            selectButton.frame = CGRectMake(i*(kuan+kuanjj)+18*WIDTH, 24*HEIGHT, kuan, 78*HEIGHT);
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:selectButton.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4*WIDTH, 4*WIDTH)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = selectButton.bounds;
            maskLayer.path = maskPath.CGPath;
            selectButton.layer.mask = maskLayer;

            [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            selectButton.tag = i+10;
            selectButton.backgroundColor = UIColorRGBA(255, 228, 214, 1);
            [fooderView addSubview:selectButton];
            UILabel*amountLab = [[UILabel alloc] init];
                        [selectButton addSubview:amountLab];
            amountLab.tag = i+10010;
            amountLab.userInteractionEnabled = NO;
            amountLab.text = [NSString stringWithFormat:@"%@¥ 起",plan.planPrice];
            amountLab.font = [UIFont systemFontOfSize:24*WIDTH];
            amountLab.textAlignment = NSTextAlignmentCenter;
            amountLab.textColor = UIColorRGBA(255, 155, 108, 1);
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:amountLab.text];
            [attrStr addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:12*WIDTH]
                            range:NSMakeRange(amountLab.text.length-3, 3)];
            amountLab.attributedText = attrStr;
            [selectButton addSubview:amountLab];
            [amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(selectButton);
                make.top.equalTo(selectButton).with.offset(13*HEIGHT);
                make.right.equalTo(selectButton);
                make.height.equalTo(@(24*HEIGHT));
            }];
            UILabel *coverageLab = [[UILabel alloc] init];
            coverageLab.text = [plan.planName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            coverageLab.textAlignment = NSTextAlignmentCenter;
            coverageLab.font = [UIFont systemFontOfSize:12*WIDTH];
            coverageLab.textColor = UIColorRGBA(255, 155, 108, 1);
            [selectButton addSubview:coverageLab];
            coverageLab.userInteractionEnabled = NO;
            coverageLab.tag = i+10086;
            [coverageLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(selectButton);
                make.top.mas_equalTo(amountLab.mas_bottom).with.offset(10*HEIGHT);
                make.right.equalTo(selectButton);
                make.height.equalTo(@(12*HEIGHT));
            }];
            if (indexSelect==selectButton.tag) {
                self.bgView.center = CGPointMake(selectButton.center.x, self.bgView.center.y);
                amountLab.textColor =LYColor_A1;
                coverageLab.textColor = LYColor_A4;
                selectButton.backgroundColor = [UIColor whiteColor];
            }
        }
        return fooderView;
    }
    
}
-(void)selectButtonClick:(UIButton *)sender
{
    if (indexSelect == sender.tag) {
        return;
    }else{
        UIButton *button = (UIButton *)[self.tableView viewWithTag:indexSelect];
        button.backgroundColor = UIColorRGBA(255, 228, 214, 1);
        UILabel *lab = (UILabel *)[self.tableView viewWithTag:button.tag+10000];
        lab.textColor = UIColorRGBA(255, 155, 108, 1);
        UILabel *label = (UILabel *)[self.tableView viewWithTag:button.tag+10076];
        label.textColor = UIColorRGBA(255, 155, 108, 1);
        sender.backgroundColor = [UIColor whiteColor];
        UILabel *labelone = (UILabel *)[self.tableView viewWithTag:sender.tag+10000];
        labelone.textColor = LYColor_A1;
        UILabel *labeltwo = (UILabel *)[self.tableView viewWithTag:sender.tag+10076];
        labeltwo.textColor = LYColor_A4;
        self.bgView.center = CGPointMake(sender.center.x, self.bgView.center.y);
        indexSelect = sender.tag;
        indexBenefit = sender.tag-10;
        DescriptionPlan *plan = self.model.planList[indexBenefit];
        firstFooterSelect = plan.planName;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        });
        [self getPriceWithAnyThing];
    }
}
#pragma mark  ----------TextFieldDelegate------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self getThePostAnyThingWithTF];
    return YES;
}
#pragma mark  ----------TheThirdFooder--------
-(UIView *)setTheThidSectionFooderView
{
    UIView *fooderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 48*HEIGHT)];
    [fooderView addSubview:self.thirdFoodImg];
    [self.thirdFoodImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fooderView).with.offset(18*WIDTH);
        make.centerY.equalTo(fooderView);
        make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*WIDTH));
    }];
    [fooderView addSubview:self.thirdTitleLab];
    [self.thirdTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thirdFoodImg.mas_right).with.offset(11*WIDTH);
        make.centerY.equalTo(fooderView);
        make.right.equalTo(fooderView).with.offset(-20*WIDTH);
        make.height.equalTo(@(12*WIDTH));
    }];
    return fooderView;
}
#pragma mark  ----------TheFivethFooder--------
-(UIView *)setTheFivethFooderView
{
    UIView *fooderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 80*HEIGHT)];
    [fooderView addSubview:self.clauseButton];
    [self.clauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fooderView).with.offset(18*WIDTH);
        make.top.equalTo(fooderView).with.offset(24*WIDTH);
        make.size.mas_equalTo(CGSizeMake(15*WIDTH, 15*WIDTH));
    }];
    [fooderView addSubview:self.clauseLab];
    
    if ([[NSString stringWithFormat:@"%@",self.model.isProductPrompt] isEqualToString:@"1"]) {
        NSString *str = @"我已阅读《投保须知》《保险条款》《健康告知》并同意上述协议约定";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:LYColor_A1
                        range:NSMakeRange(4, 18)];
        self.clauseLab.attributedText = attrStr;
        [self.clauseLab sizeToFit];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 addTarget:self action:@selector(clauseTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag = 1;
        button1.frame = CGRectMake(50*WIDTH, 0, 70*WIDTH, 13*WIDTH);
        [self.clauseLab addSubview:button1];
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 addTarget:self action:@selector(clauseTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag = 2;
        button2.frame = CGRectMake(120*WIDTH, 0, 70*WIDTH, 13*WIDTH);
        [self.clauseLab addSubview:button2];
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button3 addTarget:self action:@selector(clauseTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        button3.tag = 3;
        button3.frame = CGRectMake(195*WIDTH, 0, 70*WIDTH, 13*WIDTH);
        
        [self.clauseLab addSubview:button3];

    }else{
        
        NSString *str = @"我已阅读《投保须知》《保险条款》并同意上述协议约定";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:LYColor_A1
                        range:NSMakeRange(4, 12)];
        self.clauseLab.attributedText = attrStr;
        [self.clauseLab sizeToFit];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 addTarget:self action:@selector(clauseTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag = 1;
        button1.frame = CGRectMake(50*WIDTH, 0, 70*WIDTH, 13*WIDTH);
        [self.clauseLab addSubview:button1];
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 addTarget:self action:@selector(clauseTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag = 2;
        button2.frame = CGRectMake(120*WIDTH, 0, 70*WIDTH, 13*WIDTH);
        [self.clauseLab addSubview:button2];
        
    }
    [self.clauseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.clauseButton.mas_right).with.offset(5*WIDTH);
        make.top.equalTo(self.clauseButton);
        make.right.equalTo(fooderView).with.offset(-20*WIDTH);
        make.height.equalTo(@(30*HEIGHT));
        
    }];
    
    return fooderView;
}
-(void)clauseButtonSelect:(UIButton *)sender
{
    if (sender.selected == NO) {
        sender.selected = YES;
    }else{
        sender.selected = NO;
    }
}
//条款
-(void)clauseTypeClick:(UIButton *)sender
{
    NSLog(@"---%ld",sender.tag);
    switch (sender.tag) {
        case 1:
        {
         
            self.hidesBottomBarWhenPushed=YES;
            ProductInfoController *baseVC = [[ProductInfoController alloc] init];
            baseVC.productId = self.productId;
            [self.navigationController pushViewController:baseVC animated:YES];
            
        }
            break;
        case 2:
        {
            self.hidesBottomBarWhenPushed=YES;
            ProductClauseController *baseVC = [[ProductClauseController alloc] init];
            baseVC.productId = self.productId;
            [self.navigationController pushViewController:baseVC animated:YES];

        }
            break;
        case 3:
        {
            self.hidesBottomBarWhenPushed=YES;
            ProductHealthController *baseVC = [[ProductHealthController alloc] init];
            baseVC.productId = self.productId;
            [self.navigationController pushViewController:baseVC animated:YES];

        }
            break;
        default:
            break;
    }
    
    
    
}
#pragma mark  ----------TheFirstHeader--------

//第一区（标题图片，返回，收藏）
-(UIView *)setTheFirstHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth,  342*HEIGHT)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImg = [[UIImageView alloc] init];
//    bgImg.contentMode = UIViewContentModeScaleAspectFit;
    [bgImg sd_setImageWithURL:[NSURL URLWithString:self.model.productLogo] placeholderImage:PlaceImage];
    [headerView addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(headerView);
        make.height.equalTo(@(281*HEIGHT));
    }];
    [headerView addSubview:self.typeLab];
    NSString *modelString1 = self.model.insurerName;
    if (!self.model.insurerName) {
        modelString1 = @"";
    }
    NSString *modelString2 =self.model.totalAmount;
    if (!self.model.totalAmount) {
        modelString2 = @"";
    }
    NSString *type = [NSString stringWithFormat:@"%@ | 销量%@",modelString1,modelString2];
    self.typeLab.text = type;
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).with.offset(-18*WIDTH);
        make.bottom.equalTo(bgImg).with.offset(-20*HEIGHT);
        make.left.equalTo(headerView).with.offset(100*WIDTH);
        make.height.equalTo(@(14*HEIGHT));
    }];
    [headerView addSubview:self.titleLab];
    self.titleLab.text = self.model.productName;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView).with.offset(18*WEIGHT);
        make.right.mas_equalTo(headerView).with.offset(-130*WIDTH);
        make.top.mas_equalTo(bgImg.mas_bottom).with.offset(22*HEIGHT);
        make.height.equalTo(@(19*HEIGHT));
    }];
    [headerView addSubview:self.fanImg];
    [self.fanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView).with.offset(-18*WEIGHT);
        make.bottom.equalTo(self.titleLab);
        make.height.equalTo(@(16.5*HEIGHT));
        make.width.equalTo(@(96*WEIGHT));
    }];
    //    返现金额比例
    [headerView addSubview:self.fanLab];
    self.fanLab.text = [NSString stringWithFormat:@"推广费最高%@%@",self.model.commisionValue1,@"%"];
    [self.fanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.fanImg);
        make.size.mas_equalTo(CGSizeMake(80*WEIGHT, 11*HEIGHT));
    }];
    if ([IS_Bclient integerValue] == 0) {
        self.fanImg.hidden = YES;
        self.fanLab.hidden = YES;
    }else{
        self.fanImg.hidden = NO;
        self.fanLab.hidden = NO;
    }
    [headerView addSubview:self.circleone];
    [self.circleone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(18.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(4*WIDTH, 4*WIDTH));
    }];
    [headerView addSubview:self.perpleType];
    self.perpleType.text = self.model.productFeature;
    [self.perpleType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.circleone.mas_right).with.offset(11*WIDTH);
        make.centerY.equalTo(self.circleone);
        make.right.equalTo(headerView).with.offset(-18*WIDTH);
        make.height.equalTo(@(13*HEIGHT));
    }];
    [headerView addSubview:self.circletwo];
    [self.circletwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.top.mas_equalTo(self.perpleType.mas_bottom).with.offset(17.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(4*WIDTH, 4*WIDTH));
    }];
    [headerView addSubview:self.otherType];
    self.otherType.text = self.model.perferWords;
    [self.otherType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.circletwo.mas_right).with.offset(11*WIDTH);
        make.centerY.equalTo(self.circletwo);
        make.right.equalTo(headerView).with.offset(-18*WIDTH);
        make.height.equalTo(@(13*HEIGHT));
    }];
    [headerView addSubview:self.moreButton];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.top.mas_equalTo(self.otherType.mas_bottom).with.offset(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
    }];
    return headerView;
}
-(void)moreButtonClick
{
    NSLog(@"CHAKANGENGDUOTESE----");
}
#pragma mark  --------TheSecondHeader--------------------

//第二区（动态cell，内容选择）
-(UIView *)setTheSecondHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth,  87.5*HEIGHT)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *firstContentLab = [[UILabel alloc] init];
    firstContentLab.textColor = LYColor_A4;
    firstContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
    [headerView addSubview:firstContentLab];
    [firstContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.top.equalTo(headerView).with.offset(21*HEIGHT);
        make.width.equalTo(@(250*WIDTH));
        make.height.equalTo(@(13*WIDTH));
    }];
    UILabel *secondContentLab = [[UILabel alloc] init];
    secondContentLab.textColor = LYColor_A4;
    secondContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
//    secondContentLab.text = @"意外医疗费用（免赔额100元，90%赔)";
//    secondContentLab.backgroundColor = [UIColor redColor];
    [headerView addSubview:secondContentLab];
    [secondContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.top.mas_equalTo(firstContentLab.mas_bottom).with.offset(13*HEIGHT);
        make.height.equalTo(@(13*WIDTH));
        make.width.equalTo(@(250*WIDTH));
    }];

    UILabel *thirdContentLab = [[UILabel alloc] init];
    thirdContentLab.textColor = LYColor_A4;
    thirdContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
//    thirdContentLab.text = @"银行卡盗刷";
    [headerView addSubview:thirdContentLab];
    [thirdContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.top.mas_equalTo(secondContentLab.mas_bottom).with.offset(13*HEIGHT);
//        make.right.equalTo(headerView).with.offset(-107*WIDTH);
        make.width.equalTo(@(250*WIDTH));
        make.height.equalTo(@(13*WIDTH));
    }];
    UILabel *firstDetailContentLab = [[UILabel alloc] init];
    firstDetailContentLab.textColor = LYColor_A3;
    firstDetailContentLab.textAlignment = NSTextAlignmentRight;
    firstDetailContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
//    firstDetailContentLab.text = @"10，000";
    [headerView addSubview:firstDetailContentLab];
    [firstDetailContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).with.offset(21*HEIGHT);
        make.right.equalTo(headerView).with.offset(-13*WIDTH);
        make.height.equalTo(@(13*HEIGHT));
        make.width.equalTo(@(80*WIDTH));
    }];
    UILabel *secondDetailContentLab = [[UILabel alloc] init];
    secondDetailContentLab.textColor = LYColor_A3;
    secondDetailContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
//    secondDetailContentLab.text = @"5000，000";
    secondDetailContentLab.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:secondDetailContentLab];
    [secondDetailContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).with.offset(-13*WIDTH);
        make.top.mas_equalTo(firstDetailContentLab.mas_bottom).with.offset(13*HEIGHT);
        make.height.equalTo(@(13*WIDTH));
        make.width.equalTo(@(80*WIDTH));
    }];
    UILabel *thirdDetailContentLab = [[UILabel alloc] init];
    thirdDetailContentLab.textColor = LYColor_A3;
    thirdDetailContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
    thirdDetailContentLab.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:thirdDetailContentLab];
    [thirdDetailContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(secondDetailContentLab.mas_bottom).with.offset(13*HEIGHT);
        make.right.equalTo(headerView).with.offset(-13*WIDTH);
        make.height.equalTo(@(13*WIDTH));
        make.width.equalTo(@(80*WIDTH));
    }];
    [headerView addSubview:self.moresafeButton];
    [self.moresafeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.top.mas_equalTo(thirdContentLab.mas_bottom).with.offset(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
    }];
    if (self.model.planList.count>0&&self.model.planList.count!=1) {
        DescriptionPlan *plan = self.model.planList[indexBenefit];
        if (plan.classNameList.count>0) {
            DescriptionBenefitList *list = plan.classNameList[0];
                for (NSInteger i=0; i<list.benefitList.count; i++) {
                    DescriptionBenefit *bene = list.benefitList[i];
                    if (i==0) {
                        firstContentLab.text = bene.benefitName;
                        firstDetailContentLab.text = [bene.insuredAmount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    }else if (i==1){
                        secondContentLab.text = bene.benefitName;
                        secondDetailContentLab.text = [bene.insuredAmount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    }else{
                        thirdContentLab.text = bene.benefitName;
                        thirdDetailContentLab.text = [bene.insuredAmount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    }
            }
        }
    }else if (self.model.planList.count==1){
        DescriptionPlan *plan = self.model.planList[0];
        if (plan.classNameList.count>0) {
            DescriptionBenefitList *list = plan.classNameList[0];
            for (NSInteger i=0; i<list.benefitList.count; i++) {
                DescriptionBenefit *bene = list.benefitList[i];
                if (i==0) {
                    firstContentLab.text = bene.benefitName;
                    firstDetailContentLab.text = [bene.insuredAmount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                }else if (i==1){
                    secondContentLab.text = bene.benefitName;
                    secondDetailContentLab.text = [bene.insuredAmount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                }else{
                    thirdContentLab.text = bene.benefitName;
                    thirdDetailContentLab.text = [bene.insuredAmount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                }
            }
        }
    }
        return headerView;
}
-(void)moresafeButtonClick
{
    NSLog(@"---chaKANGENGDUOBAOZHANGXIANGQING----");
}
#pragma mark  --------TheThirdHeader--------------------
-(UIView *)setTheThirdHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth,  39*HEIGHT)];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"投保人信息";
    titleLab.textColor = LYColor_A4;
    titleLab.font = [UIFont systemFontOfSize:13*WIDTH];
    [headerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.centerY.equalTo(headerView);
        make.height.equalTo(@(13*HEIGHT));
    }];
    return headerView;
}
#pragma mark  --------TheFourthHeader--------------------

-(UIView *)setTheFourthHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth,  39*HEIGHT)];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"被保人信息";
    titleLab.textColor = LYColor_A4;
    titleLab.font = [UIFont systemFontOfSize:13*WIDTH];
    [headerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.centerY.equalTo(headerView);
        make.height.equalTo(@(13*HEIGHT));
    }];
    return headerView;

}
#pragma mark  --------TheFivethHeader--------------------
-(UIView *)setTheFivethHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth,  39*HEIGHT)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"理赔流程";
    titleLab.textColor = LYColor_A3;
    titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
    [headerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.centerY.equalTo(headerView);
        make.height.equalTo(@(13*HEIGHT));
    }];
    UIImageView *rightImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiayibu"]];
    [headerView addSubview:rightImg];
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).with.offset(-18*WIDTH);
        make.centerY.equalTo(titleLab);
        make.size.mas_equalTo(CGSizeMake(7*WIDTH, 11*WIDTH));
    }];
    return headerView;
}
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    [self.view endEditing:YES];
}
#pragma mark  -----------Controller--------

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -59, ScreenWindowWidth, ScreenWindowHeight) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorColor = LYColor_A6;
        _tableView.showsVerticalScrollIndicator = NO;
        
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        singleRecognizer.cancelsTouchesInView = NO;
        [_tableView addGestureRecognizer:singleRecognizer];
    }
    return _tableView;
}
-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"fanhui(chanpingxinagqingye)"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _backButton;
}
-(UIButton *)collectButton
{
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [_collectButton addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}
-(UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] init];
        _amountLab.textColor = LYColor_A2;
        _amountLab.font = [UIFont systemFontOfSize:21*WIDTH];
        _amountLab.textAlignment = NSTextAlignmentCenter;
        _amountLab.text = @"¥ 0";
    }
    return _amountLab;
}
-(UIImageView *)shareImg
{
    if (!_shareImg) {
        _shareImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenxiang"]];
    }
    return _shareImg;
}
-(UILabel *)shareLab
{
    if (!_shareLab) {
        _shareLab = [[UILabel alloc] init];
        _shareLab.textColor = LYColor_A1;
        _shareLab.text = @"分享";
        _shareLab.font = [UIFont systemFontOfSize:18*WIDTH];
    }
    return _shareLab;
}
-(UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}
-(UIButton *)insureBtn
{
    if (!_insureBtn) {
        _insureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_insureBtn addTarget:self action:@selector(toInsureClick:) forControlEvents:UIControlEventTouchUpInside];
        [_insureBtn setTitle:@"我要投保" forState:UIControlStateNormal];
        _insureBtn.backgroundColor = LYColor_A1;
        [_insureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _insureBtn;
}
-(UILabel *)lineLab
{
    if (!_lineLab) {
        _lineLab = [[UILabel alloc] init];
        _lineLab.backgroundColor = LYColor_A7;
    }
    return _lineLab;
}

-(UILabel *)typeLab
{
    if (!_typeLab) {
        _typeLab = [[UILabel alloc] init];
        _typeLab.textColor = [UIColor whiteColor];
        _typeLab.text = @"大西洋保险 | 销量133759";
        _typeLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _typeLab.textAlignment = NSTextAlignmentRight;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:_typeLab.text];
        NSShadow *shadow = [[NSShadow alloc]init];
        _typeLab.shadowColor = [UIColor colorWithWhite:0.1f alpha:0.39f];
        shadow.shadowOffset = CGSizeMake(0, 0);
        shadow.shadowBlurRadius = 4*WIDTH;
        [AttributedStr addAttribute:NSShadowAttributeName
                              value:shadow
                              range:NSMakeRange(0, _typeLab.text.length)];
        _typeLab.attributedText = AttributedStr;
    }
    return _typeLab;
}
-(UIImageView *)fanImg
{
    if (!_fanImg) {
        _fanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tuiguangfeibiaoqian"]];
    }
    return _fanImg;
}
-(UILabel *)fanLab
{
    if (!_fanLab) {
        _fanLab =[[UILabel alloc] init];
        _fanLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _fanLab.textColor = [LYColor colorWithHexString:@"ffffff"];
        _fanLab.textAlignment = NSTextAlignmentCenter;
        _fanLab.text = @"推广费最高20%";
    }
    return _fanLab;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab =[[UILabel alloc] init];
//        _titleLab.backgroundColor = [UIColor redColor];
        _titleLab.font = [UIFont systemFontOfSize:19*WEIGHT];
        _titleLab.textColor = LYColor_A3;
        _titleLab.text = @"成人综合意外险";
    }
    return _titleLab;
}
-(UILabel *)circleone
{
    if (!_circleone) {
        _circleone = [[UILabel alloc] init];
        _circleone.backgroundColor = LYColor_A6;
        _circleone.layer.cornerRadius = 2.0f;
        _circleone.clipsToBounds = YES;
    }
    return _circleone;
}
-(UILabel *)circletwo
{
    if (!_circletwo) {
        _circletwo = [[UILabel alloc] init];
        _circletwo.backgroundColor = LYColor_A6;
        _circletwo.layer.cornerRadius = 2.0f;
        _circletwo.clipsToBounds = YES;
    }
    return _circletwo;
}

-(NSArray *)fourArray
{
    if (!_fourArray) {
        _fourArray = @[@"投保须知",@"理赔流程",@"常见问题",@"案例分析"];
    }
    return _fourArray;
}
-(UILabel *)perpleType
{
    if (!_perpleType) {
        _perpleType = [[UILabel alloc] init];
        _perpleType.font = [UIFont systemFontOfSize:13*WIDTH];
        _perpleType.textColor = LYColor_A3;
        _perpleType.text = @"投保人群广，18-65岁均可投保";
    }
    return _perpleType;
}
-(UILabel *)otherType
{
    if (!_otherType) {
        _otherType = [[UILabel alloc] init];
        _otherType.font = [UIFont systemFontOfSize:13*WIDTH];
        _otherType.text = @"意外医疗，加量不加价";
        _otherType.textColor = LYColor_A3;
    }
    return _otherType;
}
-(UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _moreButton.titleLabel.backgroundColor = [UIColor redColor];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:13*WIDTH];
        [_moreButton setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setTitle:@"查看更多特色" forState:UIControlStateNormal];
        _moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _moreButton;
}
-(UIView *)clicpView
{
    if (!_clicpView) {
        _clicpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth-36*WIDTH, 50*HEIGHT)];
        _clicpView.backgroundColor =UIColorRGBA(255, 228, 214, 1);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_clicpView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4*WIDTH, 4*WIDTH)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _clicpView.bounds;
        maskLayer.path = maskPath.CGPath;
        _clicpView.layer.mask = maskLayer;
    }
    return _clicpView;
}
-(UIImageView *)clicpImage
{
    if (!_clicpImage) {
        _clicpImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touying"]];
    }
    return _clicpImage;
}
-(UIImageView *)safeGuardImage
{
    if (!_safeGuardImage) {
        _safeGuardImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baozhang"]];
    }
    return _safeGuardImage;
}
-(UILabel *)safeGuardLab
{
    if (!_safeGuardLab) {
        _safeGuardLab = [[UILabel alloc]init];
        _safeGuardLab.font = [UIFont systemFontOfSize:16*WIDTH];
        _safeGuardLab.textColor = UIColorRGBA(255, 155, 108, 1);
        _safeGuardLab.text = @"保障清单";
    }
    return _safeGuardLab;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton *)moresafeButton
{
    if (!_moresafeButton) {
        _moresafeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moresafeButton.titleLabel.font = [UIFont systemFontOfSize:13*WIDTH];
        [_moresafeButton setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        [_moresafeButton addTarget:self action:@selector(moresafeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_moresafeButton setTitle:@"查看保障详情" forState:UIControlStateNormal];
        _moresafeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _moresafeButton;
}
-(UIImageView *)thirdFoodImg
{
    if (!_thirdFoodImg) {
        _thirdFoodImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tishi"]];
    }
    return _thirdFoodImg;
}
-(UILabel *)thirdTitleLab
{
    if (!_thirdTitleLab) {
        _thirdTitleLab = [[UILabel alloc] init];
        _thirdTitleLab.text = @"保险受益人为法定受益人";
        _thirdTitleLab.font = [UIFont systemFontOfSize:12*WIDTH];
        _thirdTitleLab.textColor = LYColor_A4;
    }
    return _thirdTitleLab;
}
-(UIButton *)clauseButton
{
    if (!_clauseButton) {
        _clauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _clauseButton.backgroundColor = [UIColor redColor];
        [_clauseButton setImage:[UIImage imageNamed:@"gouxuan"] forState:UIControlStateNormal];
        [_clauseButton setImage:[UIImage imageNamed:@"Rectanglearrondi16copie"] forState:UIControlStateSelected];
        [_clauseButton addTarget:self action:@selector(clauseButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clauseButton;
}
-(UILabel *)clauseLab
{
    if (!_clauseLab) {
        _clauseLab = [[UILabel alloc] init];
        _clauseLab.font = [UIFont systemFontOfSize:12*WIDTH];
        _clauseLab.textColor = LYColor_A3;
        _clauseLab.userInteractionEnabled = YES;
        _clauseLab.numberOfLines = 0;
    }
    return _clauseLab;
}
-(NSArray *)relationArray
{
    if (!_relationArray) {
        _relationArray = @[@"父母",@"子女",@"配偶",@"其他关系"];
    }
    return _relationArray;
}
-(NSArray *)cardTypeArray
{
    if (!_cardTypeArray) {
        _cardTypeArray = @[@"身份证",@"军官证",@"护照",@"驾驶证",@"港澳台通行证",@"回乡证"];
    }
    return _cardTypeArray;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
