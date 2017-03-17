//
//  AddressModel.h
//  GreatWall
//
//  Created by GJ on 2017/2/15.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property (nonatomic, copy)NSString *areaCode;
@property (nonatomic, copy)NSString *areaId;
@property (nonatomic, copy)NSString *areaName;
@property (nonatomic, copy)NSString *areaType;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *parentId;
@property (nonatomic, copy)NSString *pinyinAbbr;
@property (nonatomic, copy)NSString *sts;
@property (nonatomic, copy)NSString *zipCode;
@end
