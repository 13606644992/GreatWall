//
//  BaoDanDetailModel.h
//  GreatWall
//
//  Created by GJ on 2017/3/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaoDanDetailModel : NSObject

/**
 订单编号
 */
@property (nonatomic, strong) NSString *tradeId;
/**
 保单编号
 */
@property (nonatomic, strong) NSString *policyId;
/**
 订单状态
 */
@property (nonatomic, strong) NSString *sts;
/**
 保单状态
 */
@property (nonatomic, strong) NSString *policySts;
/**
 保险分类
 */
@property (nonatomic, strong) NSString *classType;
/**
 产品ID
 */
@property (nonatomic, strong) NSString *productId;
/**
 产品名称
 */
@property (nonatomic, strong) NSString *productName;
/**
 承保公司ID
 */
@property (nonatomic, strong) NSString *insurerId;
/**
 承保公司名称
 */
@property (nonatomic, strong) NSString *insurerName;
/**
 承保公司电话
 */
@property (nonatomic, strong) NSString *insurerTels;
/**
 承保公司Logo
 */
@property (nonatomic, strong) NSString *insurerLogo;
/**
 订单数量
 */
@property (nonatomic, strong) NSString *tradeAmount;
/**
 保费
 */
@property (nonatomic, strong) NSString *tradePremium;
/**
 总保费
 */
@property (nonatomic, strong) NSString *sumPremium;
/**
 额保
 */
@property (nonatomic, strong) NSString *insureAmount;
/**
 总保额
 */
@property (nonatomic, strong) NSString *sumAmount;
/**
 优惠金额
 */
@property (nonatomic, strong) NSString *discountAmount;
/**
 实付金额
 */
@property (nonatomic, strong) NSString *payAmount;
/**
 投保人姓名
 */
@property (nonatomic, strong) NSString *applicant;
/**
 投保人证件类型
 */
@property (nonatomic, strong) NSString *applicantType;
/**
 投保人证件号码
 */
@property (nonatomic, strong) NSString *applicantIdNo;
/**
 投保人手机号码
 */
@property (nonatomic, strong) NSString *applicantMobile;
/**
 保障期限
 */
@property (nonatomic, strong) NSString *tradePeriod;
/**
 投保时间
 */
@property (nonatomic, strong) NSString *tradeTime;
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
 投保地址
 */
@property (nonatomic, strong) NSString *orderURL;
/**
 理赔指南地址
 */
@property (nonatomic, strong) NSString *claimsURL;
/**
 发票递送详细地址
 */
@property (nonatomic, strong) NSString *shippingAddress;
/**
 支付明细列表
 */
@property (nonatomic, strong) NSArray *paymentList;
/**

 */
@property (nonatomic, strong) NSString *classId;
/**
 
 */
@property (nonatomic, strong) NSString *extraInfos;
/**
 被保险人列表
 */
@property (nonatomic, strong) NSArray *insuredList;
/**
 
 */
@property (nonatomic, strong) NSString *productProp;
/**
 
 */
@property (nonatomic, strong) NSString *sex;
/**
 
 */
@property (nonatomic, strong) NSString *stsumAmounts;

/**
 
 */
@property (nonatomic, strong) NSString *userId;
/**
 保障分类列表
 */
@property (nonatomic, strong) NSArray *typeList;
@end

//insuredList
@interface BeiBaoXianRen : NSObject
/**
 受益人列表
 */
@property (nonatomic, strong) NSArray *benList;
/**
 生日
 */
@property (nonatomic, strong) NSString *birthday;
/**
 车辆信息节点
 */
@property (nonatomic, strong) NSDictionary *carInfo;
/**
 明细记录编号
 */
@property (nonatomic, strong) NSString *detailId;
/**
 邮箱
 */
@property (nonatomic, strong) NSString *email;
/**
 性别
 */
@property (nonatomic, strong) NSString *gender;
/**
 身份证号
 */
@property (nonatomic, strong) NSString *idNo;
/**
 证件类型
 */
@property (nonatomic, strong) NSString *idType;
/**
 
 */
@property (nonatomic, strong) NSString *insureCount;
/**
 被保险人ID
 */
@property (nonatomic, strong) NSString *insuredId;
/**
 被保险人姓名
 */
@property (nonatomic, strong) NSString *insuredName;
/**
 
 */
@property (nonatomic, strong) NSString *insuredNamePinyin;
/**
 手机号
 */
@property (nonatomic, strong) NSString *mobile;
/**
 电子保单URL
 */
@property (nonatomic, strong) NSString *policyURL;
/**
 与投保人关系
 */
@property (nonatomic, strong) NSString *relation;

@end

//carInfo
@interface carInfoModel : NSObject
/**
 投保城市名称
 */
@property (nonatomic, strong) NSString *cityName;
/**
 发动机号
 */
@property (nonatomic, strong) NSString *engineNo;
/**
 燃料（能源）类型
 */
@property (nonatomic, strong) NSString *fuelType;
/**
 车牌号
 */
@property (nonatomic, strong) NSString *licenseNo;
/**
 新车是否上牌
 */
@property (nonatomic, strong) NSNumber *noLicenseFlag;
/**
 注册登记日期
 */
@property (nonatomic, strong) NSString *registerDate;
/**
 过户日期
 */
@property (nonatomic, strong) NSString *specialCarDate;
/**
 是否过户车
 */
@property (nonatomic, strong) NSString *specialCarFlag;
/**
 车架号
 */
@property (nonatomic, strong) NSString *vehicleFrameNo;
/**
 车辆品牌型号
 */
@property (nonatomic, strong) NSString *vehicleModel;
@end

//paymentList
@interface ZhiFuMingXiModel : NSObject

/**
 订单编号
 */
@property (nonatomic, strong) NSString *tradeId;
/**
 支付方式
 */
@property (nonatomic, strong) NSString *paymentName;
/**
 支付时间
 */
@property (nonatomic, strong) NSString *payTime;
/**
 支付金额
 */
@property (nonatomic, strong) NSString *payAmount;
/**
 退款时间
 */
@property (nonatomic, strong) NSString *refundTime;
/**
 退款金额
 */
@property (nonatomic, strong) NSString *refundAmount;
/**
 退款机构名称
 */
@property (nonatomic, strong) NSString *refundOrganization;
/**
 退款账号
 */
@property (nonatomic, strong) NSString *refundAccount;


@end

//typeList
@interface BaoZhangNeiRongFenLeiModel : NSObject
/**
 分类名称
 */
@property (nonatomic, strong) NSString *typeName;
/**
 分类总保额
 */
@property (nonatomic, strong) NSString *sumInsureAmount;
/**
 分类id
 */
@property (nonatomic, strong) NSString *typeId;
/**
 保障内容列表
 */
@property (nonatomic, strong) NSArray *insureList;


@end
//BaoZhangNeiRongFenLeiModel里的insureList
@interface BaoZhangNeiRongModel : NSObject
/**
保障金额单位
*/
@property (nonatomic, strong) NSString *amountUnit;
/**
 内容描述
 */
@property (nonatomic, strong) NSString *desc;
/**
 保障金额
 */
@property (nonatomic, strong) NSString *insureAmount;
/**
 内容名称
 */
@property (nonatomic, strong) NSString *insureName;
/**
 
 */
@property (nonatomic, strong) NSString *extraInsureList;

@end
