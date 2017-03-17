//
//  MingXiModel.h
//  GreatWall
//
//  Created by GJ on 2017/3/14.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MingXiModel : NSObject

/**
 
 */
@property (nonatomic, strong) NSString *acctBalance;
/**
 
 */
@property (nonatomic, strong) NSString *acctFreezing;
/**
 账户ID
 */
@property (nonatomic, strong) NSString *acctId;
/**
 
 */
@property (nonatomic, strong) NSString *acctName;
/**
 
 */
@property (nonatomic, strong) NSString *acctSum;
/**
 日志编号
 */
@property (nonatomic, strong) NSString *logId;
/**
 交易时间
 */
@property (nonatomic, strong) NSNumber *logTime;
/**
 交易业务
 */
@property (nonatomic, strong) NSString *tradeAddr;
/**
 交易金额
 */
@property (nonatomic, strong) NSNumber *tradeAmount;
/**
 tradeDesc
 */
@property (nonatomic, strong) NSString *tradeDesc;
/**
 交易ID
 */
@property (nonatomic, strong) NSString *tradeId;
/**
 交易类型
 */
@property (nonatomic, strong) NSNumber *tradeType;
/**
 
 */
@property (nonatomic, strong) NSString *userLogo;
/**
 
 */
@property (nonatomic, strong) NSString *userNickname;

@end
