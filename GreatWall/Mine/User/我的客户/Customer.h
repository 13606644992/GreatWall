//
//  Customer.h
//  GreatWall
//
//  Created by GJ on 2017/3/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject

/**
 出生年月
 */
@property (nonatomic, strong) NSString *birthday;
/**
 邮箱
 */
@property (nonatomic, strong) NSString *email;
/**
 性别
 */
@property (nonatomic, strong) NSString *gender;
/**
 证件号
 */
@property (nonatomic, strong) NSString *idNo;
/**
 证件类型
 */
@property (nonatomic, strong) NSString *idType;
/**
 
 */
@property (nonatomic, strong) NSString *insurantDesc;
/**
 保险联系人姓名拼音缩写
 */
@property (nonatomic, strong) NSString *insuredAbbr;
/**
 地址
 */
@property (nonatomic, strong) NSString *insuredAddress;
/**
 保险联系人姓名拼音
 */
@property (nonatomic, strong) NSString *insuredEname;
/**
 保险联系人ID
 */
@property (nonatomic, strong) NSString *insuredId;
/**
 保险联系人姓名
 */
@property (nonatomic, strong) NSString *insuredName;
/**
 电话
 */
@property (nonatomic, strong) NSString *mobile;
/**
 职业
 */
@property (nonatomic, strong) NSString *occupation;
/**
 与被保险人关系
 */
@property (nonatomic, strong) NSString *relation;

/**
 姓名拼音索引
 */
@property (nonatomic, strong) NSString *nameIndex;

#pragma mark 带参数的构造函数
-(Customer *)initWithName:(NSString *)name;

#pragma mark 带参数的静态对象初始化方法
+(Customer *)initWithName:(NSString *)name;

#pragma mark 根据字典初始化
+(instancetype)customerWithDict:(NSDictionary*)dict;
-(instancetype)initWithDict:(NSDictionary*)dict;

@end
