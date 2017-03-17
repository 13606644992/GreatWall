//
//  GeXianTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaoDanModel;

@interface GeXianTableViewCell : UITableViewCell
- (void)creatSubView;
@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong)UIImageView *pinPaiImage;
@property (nonatomic, strong)UILabel *dateAndTime;//时间
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *baoxianqijian;
@property (nonatomic, strong)UIImageView *logoIMG;
@property (nonatomic, strong)UILabel *baodanhao;
@property (nonatomic, strong)UILabel *beibaoren;
@property (nonatomic, strong)UILabel *toubaoren;
@property (nonatomic, strong)UILabel *dingdanjine;
@property (nonatomic, strong)UILabel *tuikuangfei;
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)BaoDanModel *baoDanModel;
-(CGFloat)getHeight;

@end
