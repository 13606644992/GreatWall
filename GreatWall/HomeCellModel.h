//
//  HomeCellModel.h
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCellModel : NSObject


@property(nonatomic ,strong)NSArray *ads;//滑动视图数组
//@property(nonatomic ,strong)NSString *flashSale;//
//@property(nonatomic ,strong)NSString *infoList;//
@property(nonatomic ,strong)NSString *loop;//是否滚动1：循环(默认)；0：不循环
@property(nonatomic ,strong)NSArray *productType;//快捷栏险种
@property(nonatomic ,strong)NSString *showTime;//滚动单位：秒，默认5秒
@property(nonatomic ,strong)NSArray *specialList;//专题数组
//@property(nonatomic ,strong)NSString *userLogo;//用户Logo URL，未登录为系统默认LOGO，否则为用户自定义LOGO
@property(nonatomic ,strong)NSString *isBClient;//
@property(nonatomic ,strong)NSArray *xhbMsgList;//小汇报数组

@end

//滚动视图
@interface HomeScroll : NSObject

@property(nonatomic ,strong)NSString *adLink;//广告链接
@property(nonatomic ,strong)NSString *adURL;//广告图片URL

@end
//险种类别
@interface HomeSpecial : NSObject
@property(nonatomic ,strong)NSString *insurerTypeId;//类别ID
@property(nonatomic ,strong)NSString *insurerTypeLogo;//分类险logo
@property(nonatomic ,strong)NSString *insurerTypeName;//分类险名称
@property(nonatomic ,strong)NSString *insurerTypeUrl;//跳转URL

@end
//专题区头
@interface HomeHeader : NSObject
@property(nonatomic ,strong)NSString *endTime;//
@property(nonatomic ,strong)NSString *productCount;//专题产品数
@property(nonatomic ,strong)NSString *specialContent;//分类险名称
@property(nonatomic ,strong)NSString *specialId;//专题编号
@property(nonatomic ,strong)NSString *specialIntro;//专题简介
@property(nonatomic ,strong)NSString *specialLogo;//专题宣传
@property(nonatomic ,strong)NSString *specialName;//专题名称
@property(nonatomic ,strong)NSString *specialType;//专题类型
@property(nonatomic ,strong)NSString *specialUrl;//专题页面地址
@property(nonatomic ,strong)NSString *startTime;//
@property(nonatomic ,strong)NSArray *productList;//商品数组

@end
//专题商品
@interface HomeProduct : NSObject
@property(nonatomic ,strong)NSString *ageDesc;//承保年龄
@property(nonatomic ,strong)NSArray *benefitList;//保障利益数
@property(nonatomic ,strong)NSString *classId;//保险分类编号
@property(nonatomic ,strong)NSString *commisionType;//推广费类型
@property(nonatomic ,strong)NSString *commisionValue1;//一级分销费率
@property(nonatomic ,strong)NSString *guarantee;//保障期限
@property(nonatomic ,strong)NSString *insurerId;//保险公司编号
@property(nonatomic ,strong)NSString *insurerLogo;//保险公司Logo
@property(nonatomic ,strong)NSString *insurerName;//保险公司名称
@property(nonatomic ,strong)NSString *minPremium;//最低保费
@property(nonatomic ,strong)NSString *monthAmount;//月销量，最近30天销量
@property(nonatomic ,strong)NSString *perferWords;//推荐语
@property(nonatomic ,strong)NSString *productId;//产品编号

@property(nonatomic ,strong)NSString *productIntro;//产品简介

@property(nonatomic ,strong)NSString *productLogo;//产品图片
@property(nonatomic ,strong)NSString *productName;//产品名称
@property(nonatomic ,strong)NSString *productPrice;//市场价
@property(nonatomic ,strong)NSString *productProp;//产品属性，位标识，定义暂缓，待明确
@property(nonatomic ,strong)NSString *productTagUrls;//产品标签
@property(nonatomic ,strong)NSString *specialPrice;//活动价
@property(nonatomic ,strong)NSString *suitable;//适用人群
@property(nonatomic ,strong)NSString *totalAmount;//总销量

@end
//小汇报
@interface HomeXHBList : NSObject

@property(nonatomic ,strong)NSString *msgContent;//类别ID
@property(nonatomic ,strong)NSString *msgId;//分类险logo
@property(nonatomic ,strong)NSString *msgLink;//分类险名称
@property(nonatomic ,strong)NSString *msgTime;//跳转URL
@property(nonatomic ,strong)NSString *msgTitle;//分类险logo
@property(nonatomic ,strong)NSString *msgType;//分类险名称
@property(nonatomic ,strong)NSString *sts;//跳转URL

@end
