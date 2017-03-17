//
//  DescriptionModel.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DescriptionModel : NSObject
@property (nonatomic ,strong)NSString *benNum;//最大受益人数
@property (nonatomic ,strong)NSString *claimGuide;//理赔指南
@property (nonatomic ,strong)NSString *classId;//
@property (nonatomic ,strong)NSString *clause;//投保须知
@property (nonatomic ,strong)NSString *defaultInsurant;//
@property (nonatomic ,strong)NSString *endtInsureTime;//最晚起保日期
@property (nonatomic ,strong)NSString *flashSale;//是否限时抢购产品：1：限时抢购产品0：非限时抢购产品
@property (nonatomic ,strong)NSString *genderLimit;//性别限制
@property (nonatomic ,strong)NSString *guaranteePeriod;//保障期限
@property (nonatomic ,strong)NSString *insureWindow;//免责时间
@property (nonatomic ,strong)NSString *insurerId;//承保公司ID
@property (nonatomic ,strong)NSString *insurerLogo;//保险公司Logo
@property (nonatomic ,strong)NSString *insurerName;//保险公司名称
@property (nonatomic ,strong)NSString *lastInsureTime;//最晚终保日期
@property (nonatomic ,strong)NSString *maxAge;//最大承保年龄
@property (nonatomic ,strong)NSString *maxInsurant;//最大被保人数
@property (nonatomic ,strong)NSString *maxQuantity;//
@property (nonatomic ,strong)NSString *minAge;//最小承保年龄
@property (nonatomic ,strong)NSString *monthAmount;//月销量
@property (nonatomic ,strong)NSString *occupation;//从事职业
@property (nonatomic ,strong)NSArray *planList;//计划列表节点
@property (nonatomic ,strong)NSString *policyType;//电子保单保单形式：0：没有保单1：电子保单；2：纸质保单
@property (nonatomic ,strong)NSString *priceElements;//价格因子
@property (nonatomic ,strong)NSArray *priceList;//报价列表节点
@property (nonatomic ,strong)NSString *productId;//产品编号
@property (nonatomic ,strong)NSString *productIntro;//产品简介
@property (nonatomic ,strong)NSString *productLogo;//产品LOGO
@property (nonatomic ,strong)NSString *productName;//产品名称
@property (nonatomic ,strong)NSString *productProp;//产品属性
@property (nonatomic ,strong)NSString *productTagUrls;//产品标签URL
@property (nonatomic ,strong)NSString *prompt;//温馨提示
@property (nonatomic ,strong)NSString *quota;//支付限额
@property (nonatomic ,strong)NSString *refundFlag;//是否可退保
@property (nonatomic ,strong)NSString *startInsureTime;//最早起保日期
@property (nonatomic ,strong)NSString *suitable;//适用人群
@property (nonatomic ,strong)NSString *totalAmount;//总销量
@property (nonatomic ,strong)NSString *totalQuantity;//
@property (nonatomic ,strong)NSString *perferWords;//总销量
@property (nonatomic ,strong)NSString *productFeature;//
@property (nonatomic ,strong)NSString *commisionValue1;//总销量
@property (nonatomic ,strong)NSString *commisionValue2;//
@property (nonatomic ,strong)NSString *effectiveType;//
@property (nonatomic ,strong)NSString *effectDate;//
@property (nonatomic ,strong)NSString *isProductPrompt;//1：是  0：否

@end

@interface DescriptionPrice : NSObject

@property (nonatomic ,strong)NSString *defaultPrice;//默认价格
@property (nonatomic ,strong)NSString *priceId;//保费编号
@property (nonatomic ,strong)NSString *priceKeyword;//
@property (nonatomic ,strong)NSString *productPremium;//


@end

@interface DescriptionPlan : NSObject

@property (nonatomic ,strong)NSString *channelIds;//
@property (nonatomic ,strong)NSArray *classNameList;//
@property (nonatomic ,strong)NSString *planDesc;//
@property (nonatomic ,strong)NSString *planId;//计划编号
@property (nonatomic ,strong)NSString *planIntro;//
@property (nonatomic ,strong)NSString *planName;//
@property (nonatomic ,strong)NSString *planPrice;//
@property (nonatomic ,strong)NSString *sortCode;//排序码


@end
@interface DescriptionBenefit : NSObject
@property (nonatomic ,strong)NSString *benefitName;//保障利益名称
@property (nonatomic ,strong)NSString *insuredAmount;//保额
@property (nonatomic ,strong)NSString *sortCode;//排序码

@end
@interface DescriptionBenefitList : NSObject
@property (nonatomic ,strong)NSArray *benefitList;//
@property (nonatomic ,strong)NSString *className;//
@property (nonatomic ,strong)NSString *channelIds;//


@end

@interface DescriptionName : NSObject
@property (nonatomic ,strong)NSString *name;//
@property (nonatomic ,strong)NSArray *option;//
@end

