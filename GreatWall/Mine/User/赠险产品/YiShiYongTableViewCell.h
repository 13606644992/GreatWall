//
//  YiShiYongTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/3/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZengXianModel.h"

@interface YiShiYongTableViewCell : UITableViewCell
/**
 已使用
 */
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *logo;
@property (nonatomic, strong)UILabel *baodanhao;
@property (nonatomic, strong)UILabel *beibaoxianren;
@property (nonatomic, strong)UILabel *toubaoren;
@property (nonatomic, strong)UILabel *baoxianqijian;
@property (nonatomic, strong)UIButton *tuijianBtn;
- (void)creatYiShiYong;



@property (nonatomic, strong) ZengXianModel *zengXianModel;
@end
