//
//  ZengXianModel.h
//  GreatWall
//
//  Created by GJ on 2017/3/11.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZengXianModel : NSObject

/**
 承保年龄描述
 */
@property (nonatomic, strong) NSString *ageDesc;
/**
 赠险限制份数
 */
@property (nonatomic, strong) NSString *buyCount;
/**
 结束时间
 */
@property (nonatomic, strong) NSString *endTime;
/**
 产品失效时间
 */
@property (nonatomic, strong) NSString *expTime;
/**
 保障期限
 */
@property (nonatomic, strong) NSString *guaranteePeriod;
/**
 保险公司名称
 */
@property (nonatomic, strong) NSString *insurerLogo;
/**
 承保最大年龄
 */
@property (nonatomic, strong) NSString *maxAge;
/**
 
 */
@property (nonatomic, strong) NSString *maxPremium;
/**
 承保最小年龄
 */
@property (nonatomic, strong) NSString *minAge;
/**
 
 */
@property (nonatomic, strong) NSString *minPremium;
/**
 
 */
@property (nonatomic, strong) NSString *productDesc;
/**
 产品图片
 */
@property (nonatomic, strong) NSString *productLogo;
/**
 产品名称
 */
@property (nonatomic, strong) NSString *productName;
/**
 
 */
@property (nonatomic, strong) NSString *productTagUrls;
/**
 总保额
 */
@property (nonatomic, strong) NSString *sumInsured;
/**
 保单号
 */
@property (nonatomic, strong) NSString *policyNo;
/**
 投保人
 */
@property (nonatomic, strong) NSString *policyholderName;
/**
 被保人
 */
@property (nonatomic, strong) NSString *insuredName;
/**
 开始时间
 */
@property (nonatomic, strong) NSString *startTime;


@end
