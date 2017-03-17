//
//  AreaModel.h
//  GreatWall
//
//  Created by 李阳 on 2017/3/15.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject

/*
 *  区域Id
 */
@property (nonatomic ,strong) NSString *areaId;
/*
 *  区域名称
 */
@property (nonatomic ,strong) NSString *areaName;
/*
 *  子区域
 */
@property (nonatomic ,strong) NSArray *children;
@end
