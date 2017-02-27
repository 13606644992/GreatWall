//
//  GJModel.h
//  GreatWall
//
//  Created by GJ on 2017/1/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJModel : NSObject
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *areaCode;
@property (nonatomic, copy)NSString *city;
@property (nonatomic, copy)NSString *cneeId;
@property (nonatomic, copy)NSString *cneeName;
@property (nonatomic, copy)NSString *defaultFlag;
@property (nonatomic, copy)NSString *mobile;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;;
@end
