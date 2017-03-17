//
//  DingDanModel.h
//  GreatWall
//
//  Created by GJ on 2017/3/3.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DingDanModel : NSObject

/**
 //订单编号
 */
@property (nonatomic, strong) NSString *tradeId;

/**
 //订单状态
 */
@property (nonatomic, strong) NSString *sts;

/**
 //保险分类
 */
@property (nonatomic, strong) NSNumber *classType;

/**
 //产品ID
 */
@property (nonatomic, strong) NSString *productId;

/**
 //产品名称
 */
@property (nonatomic, strong) NSString *productName;

/**
 //承保公司ID
 */
@property (nonatomic, strong) NSString *insurerId;

/**
 //承保公司名称
 */
@property (nonatomic, strong) NSString *insurerName;

/**
 承保公司logo
 */
@property (nonatomic, strong) NSString *insurerLogo;

/**
 应付金额
 */
@property (nonatomic, strong) NSString *payAmount;

/**
 一级分销费率
 */
@property (nonatomic, strong) NSNumber *commisionValue1;

/**
 投保地址
 */
@property (nonatomic, strong) NSString *orderURL;

/**
 投保时间
 */
@property (nonatomic, strong) NSString *tradeDate;

/**
 起保时间
 */
@property (nonatomic, strong) NSString *startTime;

/**
 终保时间
 */
@property (nonatomic, strong) NSString *endTime;

/**
 交强险起保时间
 */
@property (nonatomic, strong) NSString *jqxStartTime;

/**
 交强险终保时间
 */
@property (nonatomic, strong) NSString *jqxEndTime;

/**
 投保人手机号
 */
@property (nonatomic, strong) NSString *policyHolderMobile;

/**
 投保人姓名
 */
@property (nonatomic, strong) NSString *policyHolderName;

/**
 被保险人列表
 */
@property (nonatomic, strong) NSArray *insuredList;


@end



@interface BeiBaoRenModel : NSObject

/**
 被保险人ID
 */
@property (nonatomic, strong) NSString *insuredId;

/**
 被保险人姓名
 */
@property (nonatomic, strong) NSString *insuredName;

/**
 被保险手机号
 */
@property (nonatomic, strong) NSString *insuredMobile;

/**
 车牌号
 */
@property (nonatomic, strong) NSString *licenseNo;


@end
