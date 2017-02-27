//
//  CheXianTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheXianTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *dateAndTime;
@property (nonatomic, strong)UIImageView *logoIMG;
@property (nonatomic, strong)UILabel *dingdanhao;
@property (nonatomic, strong)UILabel *chepaihao;
@property (nonatomic, strong)UILabel *beibaoren;
@property (nonatomic, strong)UILabel *jiaoqiangxian;
@property (nonatomic, strong)UILabel *shangyexian;
@property (nonatomic, strong)UILabel *dingdanjine;
@property (nonatomic, strong)UILabel *tuikuangfei;
@property (nonatomic, strong)UIImageView *stateIMG;
- (void)creatSubView;
@end
