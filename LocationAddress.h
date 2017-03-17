//
//  LocationAddress.h
//  GreatWall
//
//  Created by 李阳 on 2017/3/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AddressSelectBlock)(NSString * address,NSString *shi,NSString *qu,NSString *areaId);

@interface LocationAddress : NSObject

@property (nonatomic, copy) AddressSelectBlock block;

+ (instancetype)shareShareType;

- (void)AddressSelectShowModeWithinsureId:(NSString *)insureId;

- (void)LYShareTypeBackSelectBlock:(AddressSelectBlock)block;
@end
