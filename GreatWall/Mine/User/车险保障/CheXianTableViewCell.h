//
//  CheXianTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaoDanModel;
//@class DingDanModel;
@interface CheXianTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *dateAndTime;//时间
@property (nonatomic, strong)UIImageView *stateIMG;//状态图片
@property (nonatomic, strong)UIImageView *logoIMG;//logo图片
@property (nonatomic, strong)UILabel *dingdanhao;//订单号
@property (nonatomic, strong)UILabel *chepaihao;//车牌号
@property (nonatomic, strong)UILabel *beibaoren;//被保人
@property (nonatomic, strong)UILabel *jiaoqiangxian;//交强险
@property (nonatomic, strong)UILabel *shangyexian;//商业险
@property (nonatomic, strong)UILabel *dingdanjine;//订单金额
@property (nonatomic, strong)UILabel *tuikuangfei;//推广费
@property (nonatomic, strong)UIView *line;//线
@property (nonatomic, strong)BaoDanModel *baoDanModel;
-(CGFloat)getHeight;
- (void)creatSubView;

@end
