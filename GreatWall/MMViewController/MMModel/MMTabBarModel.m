//
//  MMTabBarModel.m
//  MMTapBar
//
//  Created by wyy on 16/11/22.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "MMTabBarModel.h"

@implementation MMTabBarModel
+ (instancetype)modelWithControllerClassName:(NSString *)className controllerTitle:(NSString *)title WithIndexInfo:(NSString *)index
{
    MMTabBarModel *model =[[MMTabBarModel alloc] init];
    model.controllerClassName = className;
    model.controllerTitle = title;
    model.indexSelect = index;
    NSLog(@"---%@",model.indexSelect);
    return model;
}
@end
