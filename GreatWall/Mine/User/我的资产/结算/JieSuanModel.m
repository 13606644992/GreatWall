//
//  JieSuanModel.m
//  GreatWall
//
//  Created by GJ on 2017/2/28.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "JieSuanModel.h"

@implementation JieSuanModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.totalAmount = dict[@"totalAmount"];
        self.totalCount = dict[@"totalCount"];
        self.pageSize = dict[@"pageSize"];
        self.settSumList = dict[@"settSumList"];
        self.tradeTime = dict[@"tradeTime"];
        self.tradeId = dict[@"tradeId"];
        self.policyNo = dict[@"policyNo"];
        self.productName = dict[@"productName"];
        self.settSum = dict[@"settSum"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
