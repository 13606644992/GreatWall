//
//  CarNumberController.h
//  GreatWall
//
//  Created by 李阳 on 2017/3/1.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarNumberController : UIViewController
/*
 *  商品Id
 */
@property (nonatomic ,strong) NSString *productId;
/*
 *  车险公司代码
 */
@property (nonatomic ,strong) NSString *insurerId;
/*
 *  车险公司
 */
@property (nonatomic ,strong) NSString *insureName;
@end
