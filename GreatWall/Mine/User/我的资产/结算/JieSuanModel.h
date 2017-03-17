//
//  JieSuanModel.h
//  GreatWall
//
//  Created by GJ on 2017/2/28.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JieSuanModel : NSObject

@property (nonatomic, strong) NSString *totalAmount;
@property (nonatomic, strong) NSString *totalCount;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSArray  *settSumList;
@property (nonatomic, strong) NSString *tradeTime;
@property (nonatomic, strong) NSString *tradeId;
@property (nonatomic, strong) NSString *policyNo;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *settSum;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
