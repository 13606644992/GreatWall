//
//  AddressSelect.h
//  AddressSelect
//
//  Created by 李阳 on 2017/3/15.
//  Copyright © 2017年 huibaoxian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AddressSelectBlock)(NSString * address,NSString *shi,NSString *qu,NSString *areaId);

@interface AddressSelect : NSObject

@property (nonatomic, copy) AddressSelectBlock block;

+ (instancetype)shareShareType;

- (void)AddressSelectShowModeWithArray:(NSArray *)shengarray;

- (void)LYShareTypeBackSelectBlock:(AddressSelectBlock)block;


@end
