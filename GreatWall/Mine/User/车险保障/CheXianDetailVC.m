//
//  CheXianDetailVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CheXianDetailVC.h"
#import "Header.h"
#import "CheXianDetailCell.h"
#import "BaoDanDetailModel.h"
@interface CheXianDetailVC ()
@property (nonatomic, strong)UITableView *cheXianList;
@property (nonatomic, strong)UIImageView *logoIMG;
@property (nonatomic, strong)UIImageView *stateIMG;
@property (nonatomic, strong)UILabel *baoDanHaoLab;
@property (nonatomic, assign)BOOL isCellSelected;
@property (nonatomic, strong)BaoDanDetailModel *detailModel;
@end

@implementation CheXianDetailVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    [self getData];
    self.navigationItem.title = @"保单详情";
    UIView *footBackground = [[UIView alloc]init];
    footBackground.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footBackground];
    [footBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(59);
    }];
    
    UIImageView *lianXiKeFu = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"baodan-lianxikefu.png"]];
    lianXiKeFu.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *dianZiBaoDan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"baodan-dianzibaodan.png"]];
    lianXiKeFu.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *woYaoLiPei = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"baodan-woyaolipei.png"]];
    lianXiKeFu.contentMode = UIViewContentModeScaleAspectFit;
    [footBackground addSubview:lianXiKeFu];
    [footBackground addSubview:dianZiBaoDan];
    [footBackground addSubview:woYaoLiPei];
    [lianXiKeFu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footBackground);
        make.left.mas_equalTo(20*WIDTH);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    [dianZiBaoDan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footBackground);
        make.left.mas_equalTo(147*WIDTH);
        make.size.mas_equalTo(CGSizeMake(20, 22));
    }];
    [woYaoLiPei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footBackground);
        make.left.mas_equalTo(272*WIDTH);
        make.size.mas_equalTo(CGSizeMake(18, 22));
    }];
    UILabel *lianxikefuLab = [[UILabel alloc]init];
    lianxikefuLab.text = @"联系客服";
    lianxikefuLab.textColor = LYColor_A3;
    lianxikefuLab.font = [UIFont systemFontOfSize:14.0f];
    UILabel *dianzibaodanLab = [[UILabel alloc]init];
    dianzibaodanLab.text = @"电子保单";
    dianzibaodanLab.textColor = LYColor_A3;
    dianzibaodanLab.font = [UIFont systemFontOfSize:14.0f];
    UILabel *woyaolipeiLab = [[UILabel alloc]init];
    woyaolipeiLab.text = @"我要理赔";
    woyaolipeiLab.textColor = LYColor_A3;
    woyaolipeiLab.font = [UIFont systemFontOfSize:14.0f];
    [footBackground addSubview:lianxikefuLab];
    [footBackground addSubview:dianzibaodanLab];
    [footBackground addSubview:woyaolipeiLab];
    [lianxikefuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footBackground);
        make.left.mas_equalTo(lianXiKeFu.mas_right).with.offset(8*WIDTH);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 17));
    }];
    [dianzibaodanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footBackground);
        make.left.mas_equalTo(dianZiBaoDan.mas_right).with.offset(8*WIDTH);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 17));
    }];
    [woyaolipeiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footBackground);
        make.left.mas_equalTo(woYaoLiPei.mas_right).with.offset(8*WIDTH);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 17));
    }];
    //底部按钮
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(footgroundBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [footBackground addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ScreenWindowWidth * i / 3);
            make.centerY.mas_equalTo(footBackground);
            make.width.mas_equalTo(ScreenWindowWidth / 3);
            make.height.mas_equalTo(footBackground).with.offset(-20);
        }];
    }
    //添加list
    [self.view addSubview:self.cheXianList];
    [self.cheXianList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.bottom.mas_equalTo(footBackground.mas_top);
    }];
    self.cheXianList.showsVerticalScrollIndicator = NO;
    //tabbar黑线
    UIView *foot_line = [[UIView alloc]init];
    foot_line.backgroundColor = UIColorRGBA(171, 171, 171, 1);
    [self.view addSubview:foot_line];
    [foot_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(footBackground.mas_top);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(0.3);
    }];
    //重新设置分割线
    if ([self.cheXianList respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.cheXianList setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [self.cheXianList setSeparatorColor:LYColor_A6];
    //默认选中状态
    self.isCellSelected = NO;
    
}

#pragma mark - 数据解析
- (void)getData{
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":userId,@"detailId":self.detailID,@"classType":@"1"}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"getTradeDetail" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"车保详情responseObject===========%@",responseObject);
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            self.detailModel = [[BaoDanDetailModel alloc]init];
            [self.detailModel setValuesForKeysWithDictionary:output];
            
            __block NSMutableArray *listArray = [NSMutableArray array];
            [self.detailModel.insuredList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BeiBaoXianRen *Model = [[BeiBaoXianRen alloc]init];
                [Model setValuesForKeysWithDictionary:obj];
                [listArray addObject:Model];
                
                carInfoModel *carInfo = [[carInfoModel alloc]init];
                [carInfo setValuesForKeysWithDictionary:Model.carInfo];
                NSLog(@"🍌Model.carInfo=======%@",Model.carInfo);
            }];
            self.detailModel.insuredList = listArray;
            
            NSLog(@"output====%@",self.detailModel.insuredList);
            
            __block NSMutableArray *array = [NSMutableArray array];
            [self.detailModel.typeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BaoZhangNeiRongFenLeiModel *fenleiModel = [[BaoZhangNeiRongFenLeiModel alloc]init];
                [fenleiModel setValuesForKeysWithDictionary:obj];
                __block NSMutableArray *arr = [NSMutableArray array];
                [fenleiModel.insureList enumerateObjectsUsingBlock:^(id  _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
                    BaoZhangNeiRongModel *baoZhangModel = [[BaoZhangNeiRongModel alloc]init];
                    [baoZhangModel setValuesForKeysWithDictionary:obj2];
                    [arr addObject:baoZhangModel];
                }];
                fenleiModel.insureList = arr;
                [array addObject:fenleiModel];
            }];
            self.detailModel.typeList = array;
            [self.logoIMG sd_setImageWithURL:[NSURL URLWithString:self.detailModel.insurerLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]] ;
            if ([self.detailModel.policySts isEqualToString:@"10"]) {
                self.stateIMG.image = [UIImage imageNamed:@"baodan-daichudan"];
            }else if ([self.detailModel.policySts isEqualToString:@"20"]){
                self.stateIMG.image = [UIImage imageNamed:@"baodan-baozhangzhong"];
                
            }else if ([self.detailModel.policySts isEqualToString:@"40"]){
                self.stateIMG.image = [UIImage imageNamed:@"baodan-yiguoqi"];
            }
            
//            self.titleLab.text = self.detailModel.productName;
//            self.baoDanHaoLab.text = self.detailModel.policyId;
        }
        [self.cheXianList reloadData];
        BeiBaoXianRen *bbb = self.detailModel.insuredList[0];
        NSLog(@"++++++------%@,%@",self.detailModel,bbb);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    CheXianDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CheXianDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    BeiBaoXianRen *beiBaoXianRen = self.detailModel.insuredList[0];
    carInfoModel *carInfo = [[carInfoModel alloc]init];
    [carInfo setValuesForKeysWithDictionary:beiBaoXianRen.carInfo];
    cell.contentLab.text = @"占位";
    cell.contentLab.hidden = NO;
    cell.jiantouIMG.hidden = YES;
    cell.background.hidden = YES;
    cell.selectBtn.userInteractionEnabled = NO;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.titleLab.text = @"车牌号码";
            cell.contentLab.text = carInfo.licenseNo;
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"姓名";
            cell.contentLab.text = beiBaoXianRen.insuredName;
        }else if (indexPath.row == 2){
            cell.titleLab.text = @"证件类型";
            if ([beiBaoXianRen.idType isEqualToString:@"1"]) {
                cell.contentLab.text = @"身份证";
            }else if ([beiBaoXianRen.idType isEqualToString:@"2"]){
                cell.contentLab.text = @"军官证";
            }else if ([beiBaoXianRen.idType isEqualToString:@"3"]){
                cell.contentLab.text = @"护照";
            }else if ([beiBaoXianRen.idType isEqualToString:@"4"]){
                cell.contentLab.text = @"驾驶证";
            }else if ([beiBaoXianRen.idType isEqualToString:@"5"]){
                cell.contentLab.text = @"港澳台通行证/回乡证";
            }else if ([beiBaoXianRen.idType isEqualToString:@"0"]){
                cell.contentLab.text = @"其他";
            }
        }else if (indexPath.row == 3){
            cell.titleLab.text = @"证件号码";
            cell.contentLab.text = beiBaoXianRen.idNo;
        }else if (indexPath.row == 4){
            cell.titleLab.text = @"手机号";
            cell.contentLab.text = beiBaoXianRen.mobile;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            cell.titleLab.text = @"交强险起期";
            cell.contentLab.text = [NSString stringWithFormat:@"%@ ~ %@",self.detailModel.jqxStartTime,self.detailModel.jqxEndTime];
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"商业险起期";
            NSString *start = [self.detailModel.startTime substringToIndex:10];
            NSString *end = [self.detailModel.endTime substringToIndex:10];
            cell.contentLab.text = [NSString stringWithFormat:@"%@ ~ %@",start,end];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0){
            cell.titleLab.text = @"交强险";
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"车船税";
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0){
            cell.titleLab.text = @"车辆损失保险";
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"第三者责任保险";
        }else if (indexPath.row == 2){
            cell.titleLab.text = @"司机座位险";
        }else if (indexPath.row == 3){
            cell.titleLab.text = @"乘客座位险";
        }else if (indexPath.row == 4){
            cell.titleLab.text = @"盗抢险";
        }else if (indexPath.row == 5){
            cell.titleLab.text = @"玻璃破碎险";
        }else if (indexPath.row == 6){
            cell.titleLab.text = @"附加不计免赔";
            cell.jiantouIMG.image = self.isCellSelected ? [UIImage imageNamed:@"baodan-jiantou-shang.png"] : [UIImage imageNamed:@"baodan-jiantou-xia.png"];
            cell.background.hidden = self.isCellSelected ? NO : YES;
            cell.selectBtn.userInteractionEnabled = YES;
            cell.contentLab.hidden = YES;
            cell.jiantouIMG.hidden = NO;
            cell.backCheLiangLabel.text = @"车辆损失保险不计免赔";
            cell.backCheLiangDetailLabel.text = @"投保";
            cell.backDiSanZheLabel.text = @"第三者责任保险不计免赔";
            cell.backDiSanZheDetailLabel.text = @"投保";
            cell.backSiJiLabel.text = @"司机座位险不计免赔";
            cell.backSiJiDetailLabel.text = @"投保";
            cell.backChengKeLabel.text = @"乘客座位险不计免赔";
            cell.backChengKeDetailLabel.text = @"投保";
            cell.backDaoQiangLabel.text = @"盗抢险不计免赔";
            cell.backDaoQiangDetailLabel.text = @"投保";
        }
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            cell.titleLab.text = @"车辆型号";
            cell.contentLab.text = carInfo.vehicleModel;
        }else  if (indexPath.row == 1) {
            cell.titleLab.text = @"车架号";
            cell.contentLab.text = carInfo.vehicleFrameNo;
        }else  if (indexPath.row == 2) {
            cell.titleLab.text = @"发动机号";
            cell.contentLab.text = carInfo.engineNo;
        }else  if (indexPath.row == 3) {
            cell.titleLab.text = @"登记日期";
            cell.contentLab.text = carInfo.registerDate;
        }
    }else if (indexPath.section == 5){
        cell.titleLab.text = @"过户车辆";
        if ([[NSString stringWithFormat:@"%@",carInfo.specialCarFlag] isEqualToString:@"0"]) {
            cell.contentLab.text = @"否";
        }else if ([[NSString stringWithFormat:@"%@",carInfo.specialCarFlag] isEqualToString:@"1"]){
            cell.contentLab.text = @"是";
        }
    }else{
        cell.titleLab.text = @"详细地址";
        cell.contentLab.text = self.detailModel.shippingAddress;
    }
    [cell.selectBtn addTarget:self action:@selector(cellSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)cellSelectedAction:(UIButton *)sender{
    CheXianDetailCell *cell = (CheXianDetailCell *)[[sender superview] superview];
    self.isCellSelected = !self.isCellSelected;
    cell.jiantouIMG.image = self.isCellSelected ? [UIImage imageNamed:@"baodan-jiantou-xia.png"] : [UIImage imageNamed:@"baodan-jiantou-shang.png"];
    NSIndexPath *indexPath = [self.cheXianList indexPathForCell:cell];
    [self.cheXianList reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 153*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        UIView *background = [[UIView alloc]init];
        background.backgroundColor  = [UIColor whiteColor];
        [view addSubview:background];
        [background mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.top.mas_equalTo(13*HEIGHT);
            make.height.mas_equalTo(97*HEIGHT);
        }];
        [background addSubview:self.logoIMG];
        [background addSubview:self.stateIMG];
        [background addSubview:self.baoDanHaoLab];
        [self.logoIMG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.top.mas_equalTo(18*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(74*WIDTH, 30*HEIGHT));
        }];
        [self.stateIMG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18*WIDTH);
            make.centerY.mas_equalTo(background);
            make.size.mas_equalTo(CGSizeMake(62*WIDTH, 62*WIDTH));
        }];
        [self.baoDanHaoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logoIMG.mas_bottom).with.offset(12*HEIGHT);
            make.left.mas_equalTo(self.logoIMG);
            make.size.mas_equalTo(CGSizeMake(300*WIDTH, 15*HEIGHT));
        }];
        self.logoIMG.image = [UIImage imageNamed:@"baodan-gongsilogo.png"];
        self.stateIMG.image = [UIImage imageNamed:@"baozhangzhong.png"];
        self.baoDanHaoLab.text = @"保单号：220202199008076754";
        //label
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"车辆信息";
        myLabel.textColor = LYColor_A4;
        myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:myLabel];
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.logoIMG);
            make.bottom.mas_equalTo(-13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
        }];

        return view;
    }else if (section == 1){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        //label
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"保险起期";
        myLabel.textColor = LYColor_A4;
        myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:myLabel];
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.bottom.mas_equalTo(-13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
        }];

        return view;
    }else if (section == 2){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        //label
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"强制保险";
        myLabel.textColor = LYColor_A4;
        myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:myLabel];
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.bottom.mas_equalTo(-13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
        }];
        return view;
    }else if (section == 3){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        //label
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"商业保险";
        myLabel.textColor = LYColor_A4;
        myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:myLabel];
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.bottom.mas_equalTo(-13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
        }];
        return view;
    }else if (section == 4){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        //label
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"车辆信息";
        myLabel.textColor = LYColor_A4;
        myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:myLabel];
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.bottom.mas_equalTo(-13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
        }];
        return view;
    }else if (section == 5){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        //label
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"过户车辆";
        myLabel.textColor = LYColor_A4;
        myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:myLabel];
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.bottom.mas_equalTo(-13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
        }];

        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        //label
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"保单邮寄地址";
        myLabel.textColor = LYColor_A4;
        myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:myLabel];
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.bottom.mas_equalTo(-13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
        }];
        return view;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 6) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 61*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        UILabel *label = [[UILabel alloc]init];
        //    label.text = @"查看《投保须知》《保险条款》";
        label.textColor = LYColor_A4;
        label.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:label];
        NSString *str1 = @"查看";
        NSString *str2 = @"《投保须知》《保险条款》";
        NSInteger length1 = [str1 length];
        NSInteger length2 = [str2 length];
        NSRange range = NSMakeRange(length1, length2);
        NSString *str3 = [NSString stringWithFormat:@"%@%@",str1,str2];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:str3];
        [text addAttribute:NSForegroundColorAttributeName value:LYColor_A1 range:range];
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*HEIGHT] range:range];
        [label setAttributedText:text];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.top.mas_equalTo(22*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(200*WIDTH, 12*HEIGHT));
        }];
        UIButton *xuZhiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [xuZhiBtn addTarget:self action:@selector(xuZhiAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:xuZhiBtn];
        UIButton *tiaoKuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tiaoKuanBtn addTarget:self action:@selector(tiaoKuanAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:tiaoKuanBtn];
        [xuZhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(112*WIDTH, 61*HEIGHT));
        }];
        [tiaoKuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(xuZhiBtn.mas_right).offset(0);
            make.size.mas_equalTo(CGSizeMake(112*WIDTH, 61*HEIGHT));
        }];
        return view;
    }else{
        return nil;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isCellSelected) {
        if (indexPath.section == 3 && indexPath.row == 6) {
            return 277.5*HEIGHT;
        }else{
            return 49*HEIGHT;
        }
    }else{
    return 49*HEIGHT;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.cheXianList) {
        if (scrollView.contentOffset.y < 0) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 7;
    }else if (section == 4){
        return 4;
    }else if (section == 5){
        return 1;
    }else{
        return 1;
    }
}
/**
 各个header高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 153.0f*HEIGHT;
    }else if (section == 1){
        return 42.0f*HEIGHT;
    }else if (section == 2){
        return 42.0f*HEIGHT;
    }else if (section == 3){
        return 42.0f*HEIGHT;
    }else if (section == 4){
        return 42.0f*HEIGHT;
    }else if (section == 5){
        return 42.0f*HEIGHT;
    }else if (section == 6){
        return 42.0f*HEIGHT;
    }else {
        return 42.0f*HEIGHT;
    }
}
/**
 各个footer高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 6) {
        return 61*HEIGHT;
    }
    
    return 1;
}
#pragma mark - 需知，条款
- (void)xuZhiAction{
    NSLog(@"跳转到须知页面");
}
- (void)tiaoKuanAction{
    NSLog(@"跳转到条款页面");
}
/**
 底部三个按钮方法
 */
- (void)footgroundBtnAction:(UIButton *)sender{
    if (sender.tag == 1000) {
        NSLog(@"联系客服");
    }else if (sender.tag == 1001){
        NSLog(@"电子保单");
    }else{
        NSLog(@"我要理赔");
    }
}

- (UITableView *)cheXianList{
    if (!_cheXianList) {
        _cheXianList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _cheXianList.backgroundColor = LYColor_A7;
        _cheXianList.dataSource = self;
        _cheXianList.delegate = self;
    }
    return _cheXianList;
}
- (UIImageView *)logoIMG{
    if (!_logoIMG) {
        _logoIMG = [[UIImageView alloc]init];
        _logoIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoIMG;
}
- (UIImageView *)stateIMG{
    if (!_stateIMG) {
        _stateIMG = [[UIImageView alloc]init];
        _stateIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _stateIMG;
}

- (UILabel *)baoDanHaoLab{
    if (!_baoDanHaoLab) {
        _baoDanHaoLab = [[UILabel alloc]init];
        _baoDanHaoLab.font = [UIFont systemFontOfSize:14*HEIGHT];
        _baoDanHaoLab.textColor = LYColor_A4;
    }
    return _baoDanHaoLab;
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
