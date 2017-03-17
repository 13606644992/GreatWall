//
//  CheXianDetailCell.h
//  GreatWall
//
//  Created by GJ on 2017/2/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheXianDetailCell : UITableViewCell
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *contentLab;
@property (nonatomic, strong)UIImageView *jiantouIMG;
@property (nonatomic, strong)UIButton *selectBtn;
//附加不急免赔下拉view
@property (nonatomic, strong)UIView *background;
@property (nonatomic, strong)UILabel *backCheLiangLabel;
@property (nonatomic, strong)UILabel *backCheLiangDetailLabel;
@property (nonatomic, strong)UILabel *backDiSanZheLabel;
@property (nonatomic, strong)UILabel *backDiSanZheDetailLabel;
@property (nonatomic, strong)UILabel *backSiJiLabel;
@property (nonatomic, strong)UILabel *backSiJiDetailLabel;
@property (nonatomic, strong)UILabel *backChengKeLabel;
@property (nonatomic, strong)UILabel *backChengKeDetailLabel;
@property (nonatomic, strong)UILabel *backDaoQiangLabel;
@property (nonatomic, strong)UILabel *backDaoQiangDetailLabel;

@end
