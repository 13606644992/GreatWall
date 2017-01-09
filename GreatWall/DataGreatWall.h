//
//  DataGreatWall.h
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^HomeListBlock)(NSString *code,NSString *mesasge,NSMutableArray *homeArray,NSString *page,NSError *error);

@interface DataGreatWall : NSObject

+(void)PostTheHomePage:(NSString *)pageIndex WithThePageSize:(NSString *)pageSize WithTheHomeBlock:(HomeListBlock)block;

@end
