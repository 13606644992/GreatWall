//
//  CarNumberModel.h
//  GreatWall
//
//  Created by 李阳 on 2017/3/8.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarNumberModel : NSObject
/*
 *  地区Id
 */
@property (nonatomic ,strong) NSString *areaCode;
/*
 *  地区名称
 */
@property (nonatomic ,strong) NSString *areaName;
/*
 *  车牌头
 */
@property (nonatomic ,strong) NSString *licensePreff;
@end
