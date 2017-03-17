//
//  DataGreatWall.h
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataHeader.h"

typedef void(^HomeListBlock)(NSString *respCode,NSString *respMsg,HomeCellModel *model,NSError *error);
typedef void(^MallProductListBlock)(NSString *respCode,NSString *respMsg,MallProductType *type,NSError *error);
typedef void(^SpecialsListBlock)(NSString *respCode,NSString *respMsg,NSString *pageSize,NSString *totalCount,NSMutableArray *array,NSError *error);
typedef void(^DescriptionBlock)(NSString *respCode,NSString *respMsg,DescriptionModel *descriptionModel,NSError *error);
typedef void(^PayMsgBlock)(NSString *respCode,NSString *respMsg,PayAliOrder *model,NSError *error);
typedef void(^PayOrderBlock)(NSString *respCode,NSString *respMsg,PayOrderModel *model,NSError *error);
typedef void(^PayTradeBlock)(NSString *respCode,NSString *respMsg,PayTrade *model,NSError *error);

typedef void(^MsgListBlock)(NSString *respCode,NSString *respMsg,NSString *pageSize,NSString *totalCount,NSString *unReadCount,NSMutableArray *array,NSError *error);




@interface DataGreatWall : NSObject

+(void)PostTheHomePageInfo:(NSString *)userID WithSpecialSize:(NSString *)specialSize WithTheProduct:(NSString *)product WithBlock:(HomeListBlock)block;
//	获取专题列表
+(void)PostTheProductListWithUserID:(NSString *)userID WithpageIndex:(NSString *)index WithPageSize:(NSString *)pageSize WithBlock:(SpecialsListBlock)block;
//	获取保险分类列表
+(void)PostTheProductTypeWithparentId:(NSString *)parentID WithBlock:(MallProductListBlock)block;
//获取专题商品
+(void)PostTheProductTypeWith:(NSString *)productType WithThePageIndex:(NSString *)pageIndex WithThePageSize:(NSString *)pageSize WithTheKey:(NSString *)key WithTheTargetID:(NSString *)targetID isGetDefault:(NSString *)isDefault WithDefaultNum:(NSString *)defaultNum WithSortCode:(NSString *)sortCode WithBenefitNum:(NSString *)benefit WithBlock:(SpecialsListBlock)block;
//消息接口
+(void)PostThePersionMsgWithUserID:(NSString *)userID WithMsgType:(NSString *)msgType WithSts:(NSString *)sts WithPageIndex:(NSString *)pageIndex WithPageSize:(NSString *)pageSize WithBlock:(SpecialsListBlock)block;

/***************************************************************/
/*
 getClientCtlInfo
 getStartUpImgs
 getAreaInfos
 getBannerInfo
 getXhbMessageInfo
 getHomePageProductType
 getHomePageProductList
 */
//首页未读消息数量
+(void)PostTheFirstMessageWith:(NSString *)userID Block:(SpecialsListBlock)block;
//首页Banner
+(void)PostTheBannerListWith:(NSString *)userID WithBlock:(SpecialsListBlock)block;
//首页快捷栏入口
+(void)PostTheProductTypeWithTheFirst:(NSString *)userID WithBlock:(SpecialsListBlock)block;
//首页小汇报
+(void)PostTheXHBMessageWith:(NSString *)userID WithBlock:(SpecialsListBlock)block;
//首页商品
+(void)PostTheFistProductWith:(NSString *)userID WithBlcok:(SpecialsListBlock)block;
//	活动列表查询
+(void)PostTheAdsListWithPageIndex:(NSString *)pageIndex WithPageSize:(NSString *)pageSize WithBlock:(SpecialsListBlock)block;
//获取产品详情
+(void)PostTheProductContentWithProductID:(NSString *)productID WithBlock:(DescriptionBlock)block;
//获取爆款产品列表
+(void)PostThesPecialProduct:(NSString *)pageIndex WithBlock:(SpecialsListBlock)block;
//获取专题列表
+(void)PostThesPecial:(NSString *)pageIndex WithPageSize:(NSString *)pageSize WithBlock:(SpecialsListBlock)block;
//获取保险公司
+(void)PostTheInsureWithparentId:(NSString *)parentID WithInsureID:(NSString *)insureID WithinsurerType:(NSString *)type WithBlock:(SpecialsListBlock)block;
//提交订单
+(void)PostTheOrderWithTheUserID:(NSString *)userID WithTheProductID:(NSString *)productID WithThePlanID:(NSString *)planID WithThePeriod:(NSString *)period WithThePriceKeyWord:(NSString *)priceKeyWord WithaTheApplicant:(NSString *)applicant WithTheMobile:(NSString *)phone WithTheidNo:(NSString *)idNo WithTheidType:(NSString *)idType WithTheInsuredName:(NSString *)insuredName WithTheInsureNo:(NSString *)insureNo WithRelationType:(NSString *)relationType WithTheInsureType:(NSString *)insureType WithCount:(NSString *)count WithStartTime:(NSString *)startTime WithBlock:(PayOrderBlock)block;
////获取订单支付信息
//+(void)PostThePayOrderMessageWithTheOrderID:(NSString *)orderId WithBlock:(PayMsgBlock)block;
//获取支付参数
+(void)postTheAliPayMessageWithTheTradeId:(NSString *)tradeId WithThePaymentId:(NSString *)paymentId WithTheUserId:(NSString *)userId WithTheacctBalanceJF:(NSString *)jf WithTheacctBalanceYE:(NSString *)yue WithThecouponCode:(NSString *)code WithTheCouponId:(NSString *)couponId WithThecouponName:(NSString *)couponName WithThecouponValue:(NSString *)couponValue WithThecouponUrl:(NSString *)couponUrl WithTheeffTime:(NSString *)effTime WithTheexp_time:(NSString *)exp_time WithThecouponDesc:(NSString *)couponDesc Withdeductible:(NSString *)deductible WithThepayDeadline:(NSString *)payDeadline WithpayPrice:(NSString *)payPrice WithThepaymentId:(NSString *)paymentIds Withquota:(NSString *)quota WithquotaUsage:(NSString *)quotaUsage WithTheProductName:(NSString *)productName WithTips:(NSString *)tips WithBlock:(PayMsgBlock)block;
//查看订单（保单）详情
+(void)PostTheTradeDetailWithTheTradeID:(NSString *)targetId WithTheDetailId:(NSString *)detailId WithTheBlock:(PayTradeBlock)block;

//回调
+(void)PostTheOrderIDWithtradeID:(NSString *)orderId WithAmount:(NSString *)amount;
//	判断用户是否能升B
+(void)PostTheUserUpToBWithBlock:(SpecialsListBlock)block;

//	获取车险投保地区
+(void)PostTheAddressWithTheCompanyCode:(NSString *)companyCode WithTheAreaCode:(NSString *)areaCode WithBlock:(SpecialsListBlock)block;
//查询车辆是否可以投保
+(void)PostTheCarWithTheChEckMsgWithcompanyCode:(NSString *)companyCode WithAreaCode:(NSString *)areaCode WithThelicenseNo:(NSString *)licenseNo WithBlock:(SpecialsListBlock)block;
//补充车辆信息
+(void)PostTheCarMsgWithTheAddserialId:(NSString *)serialId WithextractComp:(NSString *)extractComp WithmodelType:(NSString *)modelType WithvinNo:(NSString *)vinNo WithengineNo:(NSString *)engineNo WithfirstRegDate:(NSString *)firstRegDate Withseats:(NSString *)seats WithsyStartDate:(NSString *)syStartDate WithjqStartDate:(NSString *)jqStartDate WithtransferFlag:(NSString *)transferFlag WithtransferDate:(NSString *)transferDate WithdriveName:(NSString *)driveName WithidNo:(NSString *)idNo Withmobile:(NSString *)mobile WithBlock:(SpecialsListBlock)block;
//用户升级C2B
+(void)PostUpToBWithBlock:(SpecialsListBlock)block;
//获取消息
+(void)PostTheMessageWithMsgType:(NSString *)msgType Withsts:(NSString *)sts WithpageIndex:(NSString *)pageIndex WithBlock:(MsgListBlock)block;
//阅读消息
+(void)PostTheReadMessageWithMsgId:(NSString *)msgId WithBlock:(MsgListBlock)block;
//获取系统搜索热词
+(void)PostTheSetHotKeysWithBlock:(SpecialsListBlock)block;
@end
