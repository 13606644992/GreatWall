//
//  ZengXianTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/2/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZengXianModel;

@interface ZengXianTableViewCell : UITableViewCell
/**
 可领取
 */
- (void)creatKeLingQu;
@property (nonatomic, strong)UIImageView *productIMG;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *age;
@property (nonatomic, strong)UILabel *baozhangqixian;
@property (nonatomic, strong)UILabel *baoE;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *xiangouLabel;
@property (nonatomic, strong)UIImageView *logoIMG;
@property (nonatomic, strong)UIButton *zengsongBtn;
@property (nonatomic, strong)UIButton *toubaoBtn;

/**
 已使用
 */
@property (nonatomic, strong)UIImageView *logo;
@property (nonatomic, strong)UILabel *baodanhao;
@property (nonatomic, strong)UILabel *beibaoxianren;
@property (nonatomic, strong)UILabel *toubaoren;
@property (nonatomic, strong)UILabel *baoxianqijian;
@property (nonatomic, strong)UIButton *tuijianBtn;
- (void)creatYiShiYong;



@property (nonatomic, strong) ZengXianModel *zengXianModel;


@end
