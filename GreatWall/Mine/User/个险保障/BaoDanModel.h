//
//  BaoDanModel.h
//  GreatWall
//
//  Created by GJ on 2017/3/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaoDanModel : NSObject

/**
 投保人姓名
 */
@property (nonatomic, strong) NSString *applicant;
/**

 */
@property (nonatomic, strong) NSString *classId;
/**
 保险分类
 */
@property (nonatomic, strong) NSString *classType;
/**
 明细记录编号
 */
@property (nonatomic, strong) NSString *detailId;
/**
 终保时间
 */
@property (nonatomic, strong) NSString *endTime;
/**
 
 */
@property (nonatomic, strong) NSString *extraInfos;
/**
 
 */
@property (nonatomic, strong) NSString *insureCountDetail;
/**
 
 */
@property (nonatomic, strong) NSString *insurePremiumDetail;
/**
 承保公司id
 */
@property (nonatomic, strong) NSString *insurerId;
/**
 承保公司logo
 */
@property (nonatomic, strong) NSString *insurerLogo;
/**
 承保公司名称
 */
@property (nonatomic, strong) NSString *insurerName;
/**
 
 */
@property (nonatomic, strong) NSString *isClaims;
/**
 交强险终保时间
 */
@property (nonatomic, strong) NSString *jqxEndTime;
/**
 交强险起保时间
 */
@property (nonatomic, strong) NSString *jqxStartTime;
/**
 应付金额
 */
@property (nonatomic, strong) NSNumber *payAmount;
/**
 投保人手机号
 */
@property (nonatomic, strong) NSString *policyHolderMobile;
/**
 保单编号
 */
@property (nonatomic, strong) NSString *policyId;
/**
 电子保单URL
 */
@property (nonatomic, strong) NSString *policyURL;
/**
 产品ID
 */
@property (nonatomic, strong) NSString *productId;
/**
 产品名称
 */
@property (nonatomic, strong) NSString *productName;
/**
 
 */
@property (nonatomic, strong) NSString *productProp;
/**
 起保时间
 */
@property (nonatomic, strong) NSString *startTime;
/**
 保单状态
 */
@property (nonatomic, strong) NSString *sts;
/**
 投保时间
 */
@property (nonatomic, strong) NSString *tradeDate;
/**
 
 */
@property (nonatomic, strong) NSString *tradeId;
/**
 
 */
@property (nonatomic, strong) NSArray *insuredList;

@end

@interface BeiBaoXianRenModel : NSObject
/**
 被保险人id
 */
@property (nonatomic, strong) NSString *insuredId;
/**
 被保险人手机号
 */
@property (nonatomic, strong) NSString *insuredMobile;
/**
 被保险人姓名
 */
@property (nonatomic, strong) NSString *insuredName;
/**
 车牌号
 */
@property (nonatomic, strong) NSString *licenseNo;

@end

