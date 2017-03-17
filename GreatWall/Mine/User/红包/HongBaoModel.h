//
//  HongBaoModel.h
//  GreatWall
//
//  Created by GJ on 2017/3/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HongBaoModel : NSObject

/**
 红包描述
 */
@property (nonatomic, strong) NSString *couponDesc;
/**
 红包编号
 */
@property (nonatomic, strong) NSString *couponId;
/**
 红包名称
 */
@property (nonatomic, strong) NSString *couponName;
/**
 红包类型
 */
@property (nonatomic, strong) NSString *couponType;
/**
 红包跳转地址
 */
@property (nonatomic, strong) NSString *couponUrl;
/**
 发放金额
 */
@property (nonatomic, strong) NSString *couponValue;
/**
 生效时间
 */
@property (nonatomic, strong) NSString *effTime;
/**
 失效时间
 */
@property (nonatomic, strong) NSString *expTime;
/**
 满多好可用
 */
@property (nonatomic, strong) NSString *offUpto;

@end
