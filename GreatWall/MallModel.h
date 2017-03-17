//
//  MallModel.h
//  GreatWall
//
//  Created by 李阳 on 2016/12/26.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallModel : NSObject

@property(nonatomic ,strong)NSString *totalCount;//总记录数
//@property(nonatomic ,strong)NSString *pageSize;//当前页记录数
@property(nonatomic ,strong)NSString *specialList;//专题列表节点
@property(nonatomic ,strong)NSString *specialId;//专题编号
@property(nonatomic ,strong)NSString *specialName;//专题名称
@property(nonatomic ,strong)NSString *specialLogo;//专题图片
@property(nonatomic ,strong)NSString *specialIntro;//专题简介
@property(nonatomic ,strong)NSString *specialContent;//专题内容
@property(nonatomic ,strong)NSString *startTime;//开始时间
@property(nonatomic ,strong)NSString *endTime;//结束时间
@property(nonatomic ,strong)NSString *productAmount;//专题产品数
@property(nonatomic ,strong)NSString *specialUrl;//专题页面url地址


@end

@interface MallProductType : NSObject

@property(nonatomic ,strong)NSString *count;//
@property(nonatomic ,strong)NSString *typeId;//
@property(nonatomic ,strong)NSString *typeName;//
@property(nonatomic ,strong)NSArray *typeList;//

@end


@interface MallProduct : NSObject

@property(nonatomic ,strong)NSString *ageDesc;//承保年龄
@property(nonatomic ,strong)NSArray *benefitList;//保障利益数
@property(nonatomic ,strong)NSString *classId;//分类ID
@property(nonatomic ,strong)NSString *classType;//1，车险  2，个险
@property(nonatomic ,strong)NSString *commisionType;//推广费类型
@property(nonatomic ,strong)NSString *commisionValue1;//一级分销费率
@property(nonatomic ,strong)NSString *guarantee;//
@property(nonatomic ,strong)NSString *insurerId;//保险公司编号
@property(nonatomic ,strong)NSString *insurerLogo;//保险公司Logo
@property(nonatomic ,strong)NSString *insurerName;//保险公司名称
@property(nonatomic ,strong)NSString *minPremium;//最低保费
@property(nonatomic ,strong)NSString *monthAmount;//月销量
@property(nonatomic ,strong)NSString *perferWords;//
@property(nonatomic ,strong)NSString *productId;//产品编号
@property(nonatomic ,strong)NSString *productIntro;//产品简介
@property(nonatomic ,strong)NSString *productLogo;//产品图片
@property(nonatomic ,strong)NSString *productName;//产品名称
@property(nonatomic ,strong)NSString *productPrice;//市场价
@property(nonatomic ,strong)NSString *productProp;//产品属性
@property(nonatomic ,strong)NSString *productTagUrls;//
@property(nonatomic ,strong)NSString *specialPrice;//活动价
@property(nonatomic ,strong)NSString *suitable;//适用人群
@property(nonatomic ,strong)NSString *totalAmount;//总销量
@property(nonatomic ,strong)NSString *areaDesc;//保险公司开通业务地区
@property(nonatomic ,strong)NSString *businessDesc;//保险公司主营业务
@end

@interface MallInsure : NSObject
@property(nonatomic ,strong)NSString *businessDesc;//
@property(nonatomic ,strong)NSString *commisionDesc;//
@property(nonatomic ,strong)NSString *insurerId;//
@property(nonatomic ,strong)NSString *insurerIntro;//
@property(nonatomic ,strong)NSString *insurerLevel;//
@property(nonatomic ,strong)NSString *insurerLogo;//
@property(nonatomic ,strong)NSString *insurerName;//
@property(nonatomic ,strong)NSString *insurerNickname;//
@property(nonatomic ,strong)NSString *insurerTels;//
@property(nonatomic ,strong)NSString *insurerType;//

@end


@interface MallBenefitList : NSObject
@property(nonatomic ,strong)NSString *benefitDesc;//
@property(nonatomic ,strong)NSString *benefitName;//
@property(nonatomic ,strong)NSString *insuredAmount;//
@property(nonatomic ,strong)NSString *sortCode;//


@end
