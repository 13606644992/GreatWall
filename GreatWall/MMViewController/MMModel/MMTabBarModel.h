//
//  MMTabBarModel.h
//  MMTapBar
//
//  Created by wyy on 16/11/22.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTabBarModel : NSObject
@property (nonatomic, copy) NSString *controllerClassName;
@property (nonatomic, copy) NSString *controllerTitle;
@property (nonatomic, copy) NSString *indexSelect;

+ (instancetype)modelWithControllerClassName:(NSString *)className controllerTitle:(NSString *)title WithIndexInfo:(NSString *)index;
@end
