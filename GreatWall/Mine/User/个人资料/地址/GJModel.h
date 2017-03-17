//
//  GJModel.h
//  GreatWall
//
//  Created by GJ on 2017/1/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJModel : NSObject

/**
 详细地址
 */
@property (nonatomic, copy)NSString *address;
/**
 所在城市编码
 */
@property (nonatomic, copy)NSString *areaCode;
/**
 所在城市
 */
@property (nonatomic, copy)NSString *city;
/**
 收货人ID
 */
@property (nonatomic, copy)NSString *cneeId;
/**
 收货人姓名
 */
@property (nonatomic, copy)NSString *cneeName;
/**
 是否默认地址1默认0不是默认
 */
@property (nonatomic, copy)NSString *defaultFlag;
/**
 手机号码
 */
@property (nonatomic, copy)NSString *mobile;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
