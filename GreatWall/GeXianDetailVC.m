//
//  GeXianDetailVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "GeXianDetailVC.h"
#import "Header.h"
#import "GeXianDetailCell.h"
@interface GeXianDetailVC ()
@property (nonatomic, strong)UITableView *geXianList;
@property (nonatomic, strong)UIImageView *logoIMG;
@property (nonatomic, strong)UIImageView *stateIMG;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *baoDanHaoLab;
@end

@implementation GeXianDetailVC
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
    // Do any additional setup after loading the view.
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
    [self.view addSubview:self.geXianList];
    [self.geXianList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.bottom.mas_equalTo(footBackground.mas_top);
    }];
    self.geXianList.showsVerticalScrollIndicator = NO;
    //添加底部阴影
    UIImageView *shadowIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"baodan-yinying.png"]];
    shadowIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:shadowIMG];
    [shadowIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(footBackground.mas_top);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(5);
    }];
    //重新设置分割线
    if ([self.geXianList respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.geXianList setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [self.geXianList setSeparatorColor:LYColor_A6];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 5;
    }else{
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    GeXianDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GeXianDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.titleLab.text = @"人参意外伤害-身故、残疾";
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"意外医疗费用（免赔100元）";
        }else if (indexPath.row == 2){
            cell.titleLab.text = @"银行卡盗刷";
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            cell.titleLab.text = @"支付保费";
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"保障开始时间";
        }else if (indexPath.row == 2){
            cell.titleLab.text = @"保障结束时间";
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0){
            cell.titleLab.text = @"姓名";
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"证件类型";
        }else if (indexPath.row == 2){
            cell.titleLab.text = @"证件号";
        }else if (indexPath.row == 3){
            cell.titleLab.text = @"出生日期";
        }else if (indexPath.row == 4){
            cell.titleLab.text = @"手机号";
        }
    }else if (indexPath.section == 3){
        cell.titleLab.text = @"被保人";
    }
    cell.contentLab.text = @"占位";
    return cell;
}

/**
 设置header
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 177*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        UIView *background = [[UIView alloc]init];
        background.backgroundColor  = [UIColor whiteColor];
        [view addSubview:background];
        [background mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.top.mas_equalTo(13*HEIGHT);
            make.height.mas_equalTo(122*HEIGHT);
        }];
        [background addSubview:self.logoIMG];
        [background addSubview:self.titleLab];
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
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logoIMG.mas_bottom).with.offset(12*HEIGHT);
            make.left.mas_equalTo(self.logoIMG);
            make.size.mas_equalTo(CGSizeMake(300*WIDTH, 19*HEIGHT));
        }];
        [self.baoDanHaoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(8*HEIGHT);
            make.left.mas_equalTo(self.logoIMG);
            make.size.mas_equalTo(CGSizeMake(300*WIDTH, 15*HEIGHT));
        }];
        self.logoIMG.image = [UIImage imageNamed:@"baodan-gongsilogo.png"];
        self.stateIMG.image = [UIImage imageNamed:@"baozhangzhong.png"];
        self.titleLab.text = @"驾乘人员意外伤害保险（月）";
        self.baoDanHaoLab.text = @"保单号：220202199008076754";
        //label
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"保险责任";
        myLabel.textColor = LYColor_A4;
        myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:myLabel];
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.logoIMG);
            make.bottom.mas_equalTo(-12.5*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
        }];
        return view;
    }else if (section == 1){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 18*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        return view;
    }else if (section == 2){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 42*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"强制保险";
        myLabel.textColor = LYColor_A4;
        myLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:myLabel];
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.bottom.mas_equalTo(-12.5*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
        }];
        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 18*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        return view;
    }
}
/**
 设置footer ~~
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 104*HEIGHT)];
        view.backgroundColor = LYColor_A7;
        UILabel *firstLab = [[UILabel alloc]init];
        firstLab.text = @"查看";
        firstLab.textColor = LYColor_A3;
        firstLab.font = [UIFont systemFontOfSize:12*HEIGHT];
        [view addSubview:firstLab];
        [firstLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.top.mas_equalTo(22*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(26*WIDTH, 12*HEIGHT));
        }];
        UIButton *toubaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [toubaoBtn setTitle:@"《投保须知》" forState:UIControlStateNormal];
        [toubaoBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        toubaoBtn.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        toubaoBtn.tag = 1000;
        [toubaoBtn addTarget:self action:@selector(pushToFileAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:toubaoBtn];
        [toubaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(firstLab.mas_right).with.offset(1*WIDTH);
            make.centerY.mas_equalTo(firstLab).with.offset(1);
            make.size.mas_equalTo(CGSizeMake(75*WIDTH, 18*HEIGHT));
        }];
        UIButton *tiaokuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        toubaoBtn.backgroundColor = LYColor_A5;
        [tiaokuanBtn setTitle:@"《保险条款》" forState:UIControlStateNormal];
        [tiaokuanBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        tiaokuanBtn.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        tiaokuanBtn.tag = 1001;
        [tiaokuanBtn addTarget:self action:@selector(pushToFileAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:tiaokuanBtn];
        [tiaokuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(toubaoBtn.mas_right).with.offset(1*WIDTH);
            make.centerY.mas_equalTo(toubaoBtn);
            make.size.mas_equalTo(CGSizeMake(75*WIDTH, 18*HEIGHT));
        }];
        UIImageView *tixingIMG = [[UIImageView alloc]init];
        tixingIMG.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:tixingIMG];
        tixingIMG.image = [UIImage imageNamed:@"tixingfuhao.png"];
        [tixingIMG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(firstLab);
            make.top.mas_equalTo(firstLab.mas_bottom).with.offset(13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*WIDTH));
        }];
        //提醒
        UILabel *tixingLabel = [[UILabel alloc]init];
        tixingLabel.font = [UIFont systemFontOfSize:12.0*HEIGHT];
        tixingLabel.textColor = LYColor_A4;
        NSString *text = @"      本页面保单信息仅供参考，实际保单状态请以保险公司核心业务系统中记载为准";
        [view addSubview:tixingLabel];
        tixingLabel.numberOfLines = 0;
        [tixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tixingIMG);
            make.top.mas_equalTo(tixingIMG).with.offset(-1.5*HEIGHT);
            make.right.mas_equalTo(-18*WIDTH);
            make.height.mas_equalTo(36*HEIGHT);
        }];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:7*HEIGHT];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
        tixingLabel.attributedText = attributedString;
        return view;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 177.0f*HEIGHT;
    }else if (section == 1){
        return 18.0f*HEIGHT;
    }else if (section == 2){
        return 42.0f*HEIGHT;
    }else{
        return 18.0f*HEIGHT;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 104*HEIGHT;
    }else{
        return 0.2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49*HEIGHT;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.geXianList) {
        if (scrollView.contentOffset.y < 0) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
}
- (void)pushToFileAction:(UIButton *)sender{
    NSLog(@"%ld", sender.tag);
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

- (UITableView *)geXianList{
    if (!_geXianList) {
        _geXianList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _geXianList.backgroundColor = LYColor_A7;
        _geXianList.dataSource = self;
        _geXianList.delegate = self;
    }
    return _geXianList;
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
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:18*HEIGHT];
        _titleLab.textColor = LYColor_A3;
    }
    return _titleLab;
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
