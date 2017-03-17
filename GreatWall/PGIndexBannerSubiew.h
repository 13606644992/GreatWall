//
//  PGIndexBannerSubiew.h
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

/******************************
 
 可以根据自己的需要再次重写view
 
 ******************************/

#import <UIKit/UIKit.h>

@interface PGIndexBannerSubiew : UIView

/**
 *  主图
 */
@property (nonatomic, strong) UIImageView *mainImageView;

/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;

/**
 *  交强险
 */
@property (nonatomic, strong) UILabel *jiaoLab;
/**
 *  商业险
 */
@property (nonatomic, strong) UILabel *shangLab;

/**
 *  交强险
 */
@property (nonatomic, strong) UILabel *jiaoQLab;
/**
 *  商业险
 */
@property (nonatomic, strong) UILabel *shangYLab;


/**
 *  机动车损失险
 */
@property (nonatomic, strong) UILabel *jiSunLab;
/**
 *  机不计
 */
@property (nonatomic, strong) UILabel *jiBLab;

/**
 *  三者责任
 */
@property (nonatomic, strong) UILabel *sanLan;
/**
 *  三者责任金额
 */
@property (nonatomic, strong) UILabel *sanCountLan;
/**
 *  三者责任不计
 */
@property (nonatomic, strong) UILabel *sanBLab;

/**
 *  司机责任
 */
@property (nonatomic, strong) UILabel *siLab;
/**
 *  司机责任金额
 */
@property (nonatomic, strong) UILabel *siCountLab;
/**
 *  司机不计
 */
@property (nonatomic, strong) UILabel *siBLab;

/**
 *  乘客责任
 */
@property (nonatomic, strong) UILabel *chengLan;
/**
 *  乘客金额
 */
@property (nonatomic, strong) UILabel *chengCountBLab;
/**
 *  乘客不计
 */
@property (nonatomic, strong) UILabel *chengBLab;
/**
 *  盗抢险
 */
@property (nonatomic, strong) UILabel *daoLan;
/**
 *  盗抢不计
 */
@property (nonatomic, strong) UILabel *daoBLab;
/**
 *  总金额
 */
@property (nonatomic, strong) UILabel *zongAmount;
/**
 *  投保方案
 */
@property (nonatomic, strong) UIButton *changType;
@end
