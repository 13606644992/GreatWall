//
//  PayViewModel.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/27.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayViewModel : NSObject
@property(nonatomic ,strong)NSString *deadline;//支付截止时间
@property(nonatomic ,strong)NSString *payPrice;//应付金额
@property(nonatomic ,strong)NSArray *payments;//支付方式
@property(nonatomic ,strong)NSArray *tradeId;//订单号




@end
@interface PayTypeModel : NSObject

@property(nonatomic ,strong)NSString *paymentId;//支付方式编号
@property(nonatomic ,strong)NSString *quota;//支付限额
@property(nonatomic ,strong)NSString *quotaUsage;//限额方式


@end

@interface PayOrderModel : NSObject

@property(nonatomic ,strong)NSString *acctBalanceJF;//
@property(nonatomic ,strong)NSString *acctBalanceYE;//
@property(nonatomic ,strong)NSArray *couponList;//
@property(nonatomic ,strong)NSString *deductible;//
@property(nonatomic ,strong)NSString *payDeadline;//
@property(nonatomic ,strong)NSString *payPrice;//
@property(nonatomic ,strong)NSArray *payments;//
@property(nonatomic ,strong)NSString *productName;//
@property(nonatomic ,strong)NSString *tips;//
@property(nonatomic ,strong)NSString *tradeId;//

@end

@interface PayAliOrder : NSObject

@property(nonatomic ,strong)NSString *body;//商品描述
@property(nonatomic ,strong)NSString *inputcharset;//编码格式
@property(nonatomic ,strong)NSString *itbpay;//支付超时时间
@property(nonatomic ,strong)NSString *notifyurl;//通知回调地址
@property(nonatomic ,strong)NSString *outtradeno;//商户订单号
@property(nonatomic ,strong)NSString *partner;//合作伙伴编号
@property(nonatomic ,strong)NSString *paymenttype;//支付方式
@property(nonatomic ,strong)NSString *returnurl;//
@property(nonatomic ,strong)NSString *sellerid;//卖家支付宝账号
@property(nonatomic ,strong)NSString *service;//接口名称
@property(nonatomic ,strong)NSString *showurl;//
@property(nonatomic ,strong)NSString *sign;//签名
@property(nonatomic ,strong)NSString *signtype;//签名方式
@property(nonatomic ,strong)NSString *subject;//商品名称
@property(nonatomic ,strong)NSString *totalfee;//支付金额

@end



