//
//  PayViewController.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/17.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "PayViewController.h"
#import "Header.h"
#import "PayViewTypeAmountCell.h"
#import "PayViewTypeTwoCell.h"
#import "PayViewTypeThreeCell.h"
#import "PayViewTypeFourCell.h"
#import "PayViewTypeFiveCell.h"
#import "PayViewTypeSixCell.h"
#import "PayViewTypeSevenCell.h"
#import "PerInsureController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "WXApi.h"
#import "LYShareType.h"


@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger payType;
    NSInteger jifenType;
    NSInteger yueType;
    NSInteger youHuiType;
    NSString *shijian;
    NSString *fenzhong;
    NSString *miao;
    NSTimer *timer;
    NSString *timeString;
    NSInteger time;
    UIButton *payButton;
    UILabel *amountLab;
    CGFloat shengY;
}
@property (nonatomic ,strong) UITableView *tabView;
//@property (nonatomic ,strong) PayViewModel *model;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    payType = 50;jifenType = 0;yueType = 0;youHuiType = 0;timeString = @"请在23时59分59秒内完成支付，逾期将自动取消订单";time = 0;
    [self setTopView];
    [self setBottomView];
    [self.view addSubview:self.tabView];
}
-(void)setTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"确认支付";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = LYColor_A1;
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(paybackClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@"发送给客户"  forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake(ScreenWindowWidth-88, 33, 75*WIDTH, 25);
    [sendBtn addTarget:self action:@selector(sendTo) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
    [topView addSubview:sendBtn];
}
-(void)setBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(100*HEIGHT));
    }];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 0.5)];
    line.backgroundColor = [LYColor colorWithHexString:@"#e3e3e3"];
    [bottomView addSubview:line];
    amountLab = [[UILabel alloc] init];
    amountLab.textColor = LYColor_A2;
    amountLab.textAlignment = NSTextAlignmentCenter;
    amountLab.text = @"¥99.40";
    amountLab.font = [UIFont fontWithName:JiaCu size:17*WIDTH];
    [bottomView addSubview:amountLab];
    [amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.top.equalTo(bottomView).with.offset(13*HEIGHT);
        make.width.equalTo(@(55*WIDTH));
        make.height.equalTo(@(17*HEIGHT));
    }];
    UILabel *heLab = [[UILabel alloc] init];
    heLab.text = @"合计:";
    heLab.textColor = LYColor_A3;
    heLab.font = [UIFont systemFontOfSize:14*WIDTH];
//    heLab.backgroundColor = [UIColor redColor];
    heLab.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:heLab];
    [heLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(amountLab.mas_left).with.offset(-11*WIDTH);
        make.centerY.equalTo(amountLab);
        make.size.mas_equalTo(CGSizeMake(45*WIDTH, 14*HEIGHT));
    }];
    UILabel *shengLab = [[UILabel alloc] init];
    shengLab.textAlignment = NSTextAlignmentLeft;
    shengLab.textColor = LYColor_A4;
    shengLab.text = @"(已省¥16.6)";
    shengLab.font = [UIFont systemFontOfSize:14*WIDTH];
    [bottomView addSubview:shengLab];
    [shengLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(amountLab.mas_right).with.offset(6*WIDTH);
        make.right.equalTo(bottomView).with.offset(-18*WIDTH);
        make.centerY.equalTo(amountLab);
        make.height.equalTo(@(14*HEIGHT));
    }];

    payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.backgroundColor = LYColor_A1;
    payButton.layer.cornerRadius = 2.0f;
    payButton.clipsToBounds = YES;
    [payButton addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
    [payButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).with.offset(18*WIDTH);
        make.right.equalTo(bottomView).with.offset(-18*WIDTH);
        make.top.mas_equalTo(amountLab.mas_bottom).with.offset(18*HEIGHT);
        make.bottom.equalTo(bottomView).with.offset(-13*HEIGHT);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    payButton.backgroundColor = LYColor_A1;
    payButton.userInteractionEnabled = YES;
    NSDate *datenow = [NSDate date];
    NSString *timeSp2 = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    time = [self.model.payDeadline integerValue] - [timeSp2 integerValue];
    NSInteger s = time % 60;
    NSInteger m = (time / 60) % 60;
    NSInteger h = time / 3600;
    timeString = [NSString stringWithFormat:@"请在%02ld时%02ld分%02ld秒内完成支付，逾期将自动取消订单",h,m,s];
    if (time<=0) {
        time = 0;
        timeString = [NSString stringWithFormat:@"请在00时00分00秒内完成支付，逾期将自动取消订单"];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabView reloadData];
    });
    shengY = [self.model.payPrice floatValue];
    amountLab.text = [NSString stringWithFormat:@"¥%.2f",shengY/100];
    CGRect tempRect = [amountLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-150,17*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:JiaCu size:17*WIDTH]}context:nil];
    [amountLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tempRect.size.width+5));
    }];

}
-(void)payClick:(UIButton *)sender
{
    PayTypeModel *model = self.model.payments[payType-50];
    if ([model.paymentId isEqualToString:@"10"]) {
        [DataGreatWall postTheAliPayMessageWithTheTradeId:self.model.tradeId WithThePaymentId:@"10" WithTheUserId:GJ_UserID WithTheacctBalanceJF:@"0" WithTheacctBalanceYE:@"0" WithThecouponCode:@"" WithTheCouponId:@"" WithThecouponName:@"" WithThecouponValue:@"" WithThecouponUrl:@"" WithTheeffTime:@"" WithTheexp_time:@"" WithThecouponDesc:@"" Withdeductible:@"0" WithThepayDeadline:self.model.payDeadline WithpayPrice:self.model.payPrice WithThepaymentId:model.paymentId Withquota:model.quota WithquotaUsage:model.quotaUsage WithTheProductName:self.model.productName WithTips:@"" WithBlock:^(NSString *respCode, NSString *respMsg, PayAliOrder *model, NSError *error) {
            if (error) {
                
            }else if ([respCode isEqualToString:@"000000"]){
                /*
                 *生成订单信息及签名
                 */
                //将商品信息赋予AlixPayOrder的成员变量
                Order* order = [Order new];
                
                // NOTE: app_id设置
                order.app_id = @"2017020605533484";
                
                // NOTE: 支付接口名称
                order.method = model.service;
                
                // NOTE: 参数编码格式
                order.charset = model.inputcharset;
                
                // NOTE: 当前时间点
                NSDateFormatter* formatter = [NSDateFormatter new];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                order.timestamp = [formatter stringFromDate:[NSDate date]];
                
                // NOTE: 支付版本
                order.version = @"1.0";
                
                // NOTE: sign_type 根据商户设置的私钥来决定
                order.sign_type = model.signtype;
                
                // NOTE: 商品数据
                order.biz_content = [BizContent new];
                order.biz_content.body = model.body;
                order.biz_content.subject = model.subject;
                order.biz_content.out_trade_no = model.outtradeno; //订单ID（由商家自行制定）
                order.biz_content.timeout_express = @"30m"; //超时时间设置
                order.biz_content.total_amount = [NSString stringWithFormat:@"%@", model.totalfee]; //商品价格

                 NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
                if (model.sign.length>0) {
                    
                    NSString *appScheme = @"huiBaoXianSafePay";
                    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                    NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                             orderInfoEncoded, model.sign];
                    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                        //接口回调
                        [DataGreatWall PostTheOrderIDWithtradeID:model.outtradeno WithAmount:[NSString stringWithFormat:@"%ld",[model.totalfee integerValue]*100]];
                        NSLog(@"reslut = %@",resultDic);
                    }];

                }
                
            }else{
                
            }
        }];
    }else{
        NSLog(@"weixin-----");
        [self setTheWeiChatPay];
    }
}
-(void)setTheWeiChatPay
{
    
}
-(void)sendTo
{
    [[LYShareType shareShareType] LYShareTypeShowMode];
    [[LYShareType shareShareType] LYShareTypeBackSelectBlock:^(NSString *index) {
        NSLog(@"share-------%@",index);
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"标题";
        message.description = @"描述";
        [message setThumbImage:[UIImage imageNamed:@""]];
        
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
-(void)paybackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 38*HEIGHT;
    }else if (section == 1){
        return 15*HEIGHT;
    }
    return 43*HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 100;
    }
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [self setTheFirstHeaderView];
    }else if (section == 2){
        return [self setTheLastHeaderView];
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 100*HEIGHT)];
        UIImageView *footerImg = [[UIImageView alloc] init];
        footerImg.image = [UIImage imageNamed:@"tishi"];
        [footerView addSubview:footerImg];
        [footerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footerView).with.offset(18*WIDTH);
            make.top.equalTo(footerView).with.offset(12*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(12*WIDTH, 12*HEIGHT));
        }];
        UILabel *tishiLab = [[UILabel alloc] init];
        tishiLab.textColor = LYColor_A4;
        tishiLab.text = @"温馨提示：本产品由平安健康保险股份有限公司承保。";
        tishiLab.font = [UIFont systemFontOfSize:12*WIDTH];
        [footerView addSubview:tishiLab];
        [tishiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(footerImg.mas_right).with.offset(11.5f*WIDTH);
            make.top.bottom.equalTo(footerImg);
            make.right.equalTo(footerView).with.offset(-18*WIDTH);
        }];
        UILabel *phoneLab = [[UILabel alloc] init];
        phoneLab.textColor = LYColor_A4;
        phoneLab.text = @"联系电话：95588";
        phoneLab.font = [UIFont systemFontOfSize:12*WIDTH];
        [footerView addSubview:phoneLab];
        [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(footerImg.mas_right).with.offset(11.5f*WIDTH);
            make.top.mas_equalTo(footerImg.mas_bottom).with.offset(11*WIDTH);
            make.height.equalTo(@(12*HEIGHT));
            make.right.equalTo(footerView).with.offset(-18*WIDTH);
        }];
        return footerView;
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 5;
    }
    return self.model.payments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PayViewTypeAmountCell *cell = [PayViewTypeAmountCell cellWithPayViewTableView:tableView];
            cell.detialLab.text = [NSString stringWithFormat:@"¥%.02f",[self.model.payPrice floatValue]/100];
            return cell;
        }
        PayViewTypeTwoCell *cell = [PayViewTypeTwoCell cellWithPayViewTypeTableView:tableView];
        cell.titleLab.text = self.model.productName;
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            PayViewTypeThreeCell *cell = [PayViewTypeThreeCell cellWithPayViewTypeTableView:tableView];
            cell.detailLab.text = @"省5元：每周首单红包";

            return cell;
        }else if (indexPath.row == 4){
            PayViewTypeSixCell *cell = [PayViewTypeSixCell cellWithPayViewTypeSixTableView:tableView];
            cell.amountLab.tag = 10088;
            cell.amountLab.text = [NSString stringWithFormat:@"¥%.2f",shengY/100];
            return cell;
        }else if (indexPath.row == 3){
            PayViewTypeFiveCell *cell = [PayViewTypeFiveCell cellWithPayViewTypeFiveTableView:tableView];
            cell.segementBtn.tag = indexPath.row;
            cell.segementBtn.selected = NO;
            if (cell.segementBtn.tag == youHuiType) {
                cell.segementBtn.selected = YES;
            }
            [cell.segementBtn addTarget:self action:@selector(segementClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        PayViewTypeFourCell *cell = [PayViewTypeFourCell cellWithPayViewTypeFourTableView:tableView];
        cell.segementBtn.tag = indexPath.row;
        cell.segementBtn.selected = NO;
        if (indexPath.row == 1) {
            cell.titleLab.text = [NSString stringWithFormat:@"可用%.2f积分抵¥%.2f",[self.model.acctBalanceJF floatValue]/100,[self.model.deductible floatValue]/100];
            if (cell.segementBtn.tag == jifenType) {
                cell.segementBtn.selected = YES;
            }
        }else if (indexPath.row == 2) {
            cell.titleLab.text = [NSString stringWithFormat:@"余额可抵扣¥%.2f",[self.model.acctBalanceYE floatValue]/100];
            cell.titleLab.tag = 10087;
            if (cell.segementBtn.tag == yueType) {
                cell.segementBtn.selected = YES;
            }
        }
        [cell.segementBtn addTarget:self action:@selector(segementClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (self.model.payments.count>0) {
        
        PayTypeModel *model = self.model.payments[indexPath.row];
        
        PayViewTypeSevenCell *cell = [PayViewTypeSevenCell cellWithPayViewTypeSevenTableView:tableView];
        cell.selectBtn.tag = 50+indexPath.row;
        if (cell.selectBtn.tag == payType) {
            cell.selectBtn.selected = YES;
        }
        if (![model.paymentId isEqualToString:@"10"]) {
            cell.titleLab.text = @"微信支付";
        }
        return cell;
    }

    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            self.hidesBottomBarWhenPushed=YES;
            PerInsureController *payVC = [[PerInsureController alloc] init];
            payVC.tradeId = self.model.tradeId;
            [self.navigationController pushViewController:payVC animated:YES];
        }
    }else if (indexPath.section == 2) {
        if (payType !=0) {
            UIButton * btn = (UIButton *)[tableView viewWithTag:payType];
            btn.selected = NO;
        }
        PayViewTypeSevenCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        if (indexPath.row == 0) {
                cell.selectBtn.selected = YES;
                payType = cell.selectBtn.tag;
        }else{
                cell.selectBtn.selected = YES;
                payType = cell.selectBtn.tag;
        }
    }
}
-(void)segementClick:(UIButton *)sender
{
    if (sender.tag == 1) {
        if (sender.selected==YES) {
            sender.selected = NO;
            jifenType = 0;
        }else{
            sender.selected = YES;
            jifenType = sender.tag;
        }
        if (jifenType == 0) {
            if (yueType == 0) {
                shengY = [self.model.payPrice floatValue];
            }else{
                shengY = shengY - [self.model.acctBalanceYE floatValue];
            }
        }else{
            if (yueType == 0) {
                shengY = shengY - [self.model.deductible floatValue];
            }else{
                shengY = shengY - [self.model.acctBalanceYE floatValue]- [self.model.acctBalanceJF floatValue];
            }
        }
    }else if (sender.tag == 2){
        if (sender.selected==YES) {
            sender.selected = NO;
            yueType = 0;
        }else{
            sender.selected = YES;
            yueType = sender.tag;
        }
        if (yueType == 0) {
            if (yueType == 0) {
                shengY = [self.model.payPrice floatValue];
            }else{
                shengY = shengY - [self.model.acctBalanceYE floatValue];
            }
        }else{
            if (yueType == 0) {
                shengY = shengY - [self.model.deductible floatValue];
            }else{
                shengY = shengY - [self.model.acctBalanceYE floatValue]- [self.model.acctBalanceJF floatValue];
            }
        }
    }else{
        if (sender.selected==YES) {
            sender.selected = NO;
            youHuiType = 0;
        }else{
            sender.selected = YES;
            youHuiType = sender.tag;
        }
    }


    NSLog(@"---%f",shengY);
    if (shengY<0) {
        shengY = 0;
    }
    [self.tabView reloadData];
    
    
}
-(UIView *)setTheFirstHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 38*HEIGHT)];

    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(18*WIDTH, 0, ScreenWindowWidth-36*WIDTH, 12*WIDTH)];
    timeLab.tag = 10086;
    timeLab.center = CGPointMake(timeLab.center.x, headerView.center.y);
    timeLab.text = timeString;
    timeLab.textColor = LYColor_A3;
    timeLab.font = [UIFont systemFontOfSize:12*HEIGHT];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:timeLab.text];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:NSMakeRange(2, 2)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
    
                              value:[UIColor redColor]
    
                              range:NSMakeRange(5, 2)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
    
                              value:[UIColor redColor]
    
                              range:NSMakeRange(8, 2)];
    
    timeLab.attributedText = AttributedStr;
    if (timeLab.text.length>24) {
        NSString *hour = [timeLab.text substringWithRange:NSMakeRange(2, 2)];
        shijian = hour;
        NSString *min = [timeLab.text substringWithRange:NSMakeRange(5, 2)];
        fenzhong = min;
        NSString *sec = [timeLab.text substringWithRange:NSMakeRange(8, 2)];
        miao = sec;
        
        if (time>0) {
            if (timer) {
                [timer invalidate];
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeReduce) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
            payButton.backgroundColor = LYColor_A1;
            payButton.userInteractionEnabled = YES;
        }else{
            payButton.backgroundColor = LYColor_A6;
            payButton.userInteractionEnabled = NO;
        }
    }
    [headerView addSubview:timeLab];
    
    return headerView;
}
-(void)timeReduce
{
    NSInteger mmsec = [miao integerValue];
    NSInteger mmmin = [fenzhong integerValue]*60;
    NSInteger mmhour = [shijian integerValue]*60*60;
    NSInteger zongCount = mmhour+mmmin+mmsec;
    if (zongCount>0) {
        zongCount--;
        time--;
        NSInteger sec = zongCount%60;
        NSInteger min = (zongCount/60)%60;
        NSInteger hour=zongCount/(60*60);
        timeString = [NSString stringWithFormat:@"请在%02ld时%02ld分%02ld秒内完成支付，逾期将自动取消订单",hour,min,sec];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:timeString];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor redColor]
         
                              range:NSMakeRange(2, 2)];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor redColor]
         
                              range:NSMakeRange(5, 2)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor redColor]
         
                              range:NSMakeRange(8, 2)];
        UILabel *lab = (UILabel *)[self.tabView viewWithTag:10086];
        lab.text = timeString;
        lab.attributedText = AttributedStr;
        NSString *_hour = [timeString substringWithRange:NSMakeRange(2, 2)];
        shijian = _hour;
        NSString *_min = [timeString substringWithRange:NSMakeRange(5, 2)];
        fenzhong = _min;
        NSString *_sec = [timeString substringWithRange:NSMakeRange(8, 2)];
        miao = _sec;
    }else{
        [timer invalidate];
        payButton.backgroundColor = LYColor_A6;
        payButton.userInteractionEnabled = NO;
    }
    
}
-(UIView *)setTheLastHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 38*HEIGHT)];
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(18*WIDTH, 15*HEIGHT, ScreenWindowWidth-36*WIDTH, 12*WIDTH)];
//    timeLab.center = CGPointMake(timeLab.center.x, headerView.center.y);
    timeLab.text = @"请选择支付方式";
    timeLab.textColor = LYColor_A4;
    timeLab.font = [UIFont systemFontOfSize:12*HEIGHT];
    [headerView addSubview:timeLab];
    return headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -------Controller---------
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWindowWidth, ScreenWindowHeight - 100*HEIGHT - 64) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.backgroundColor = LYColor_A7;
        _tabView.rowHeight = 56*HEIGHT;
        _tabView.separatorColor = [UIColor clearColor];
    }
    return _tabView;
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
