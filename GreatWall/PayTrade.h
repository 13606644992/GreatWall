//
//  PayTrade.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/28.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayTrade : NSObject

@property(nonatomic ,strong)NSString *applicant;//
@property(nonatomic ,strong)NSString *applicantIdNo;//
@property(nonatomic ,strong)NSString *applicantMobile;//
@property(nonatomic ,strong)NSString *applicantType;//
@property(nonatomic ,strong)NSString *claimsURL;//
@property(nonatomic ,strong)NSString *classId;//
@property(nonatomic ,strong)NSString *classType;//
@property(nonatomic ,strong)NSString *discountAmount;//
@property(nonatomic ,strong)NSString *endTime;//
@property(nonatomic ,strong)NSString *extraInfos;//
@property(nonatomic ,strong)NSString *insureAmount;//
@property(nonatomic ,strong)NSArray *insuredList;//
@property(nonatomic ,strong)NSString *insurerId;//
@property(nonatomic ,strong)NSString *insurerLogo;//
@property(nonatomic ,strong)NSString *insurerName;//
@property(nonatomic ,strong)NSString *insurerTels;//
@property(nonatomic ,strong)NSString *orderURL;//
@property(nonatomic ,strong)NSString *payAmount;//
@property(nonatomic ,strong)NSArray *paymentList;//
@property(nonatomic ,strong)NSString *policyId;//
@property(nonatomic ,strong)NSString *policySts;//
@property(nonatomic ,strong)NSString *productId;//
@property(nonatomic ,strong)NSString *productName;//
@property(nonatomic ,strong)NSString *productProp;//
@property(nonatomic ,strong)NSString *sex;//
@property(nonatomic ,strong)NSString *shippingAddress;//
@property(nonatomic ,strong)NSString *startTime;//
@property(nonatomic ,strong)NSString *sts;//
@property(nonatomic ,strong)NSString *sumAmount;//
@property(nonatomic ,strong)NSString *sumPremium;//
@property(nonatomic ,strong)NSString *tradeAmount;//
@property(nonatomic ,strong)NSString *tradeId;//
@property(nonatomic ,strong)NSString *tradePeriod;//
@property(nonatomic ,strong)NSString *tradePremium;//
@property(nonatomic ,strong)NSString *tradeTime;//
@property(nonatomic ,strong)NSArray *typeList;//
@property(nonatomic ,strong)NSString *userId;//


@end

@interface OrderType : NSObject

@property(nonatomic ,strong)NSArray *insureList;//
@property(nonatomic ,strong)NSString *sumInsureAmount;//
@property(nonatomic ,strong)NSString *typeId;//
@property(nonatomic ,strong)NSString *typeName;//

@end
@interface OrderInsureList : NSObject
@property(nonatomic ,strong)NSString *amountUnit;//
@property(nonatomic ,strong)NSArray *extraInsureList;//
@property(nonatomic ,strong)NSString *desc;//
@property(nonatomic ,strong)NSString *insureAmount;//
@property(nonatomic ,strong)NSString *insureName;//
@end

@interface OrderPersonal : NSObject
@property(nonatomic ,strong)NSString *birthday;//
@property(nonatomic ,strong)NSArray *benList;//
@property(nonatomic ,strong)NSString *carInfo;//
@property(nonatomic ,strong)NSString *detailId;//
@property(nonatomic ,strong)NSString *email;//
@property(nonatomic ,strong)NSString *gender;//
@property(nonatomic ,strong)NSString *idNo;//
@property(nonatomic ,strong)NSString *idType;//
@property(nonatomic ,strong)NSString *insureCount;//
@property(nonatomic ,strong)NSString *insuredId;//
@property(nonatomic ,strong)NSString *insuredName;//
@property(nonatomic ,strong)NSString *insuredNamePinyin;//
@property(nonatomic ,strong)NSString *mobile;//
@property(nonatomic ,strong)NSString *policyURL;//
@property(nonatomic ,strong)NSString *relation;//
@end
