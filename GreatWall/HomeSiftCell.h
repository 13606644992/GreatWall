//
//  HomeSiftCell.h
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "HomeCellModel.h"
#import "BezierPathLine.h"

@interface HomeSiftCell : UITableViewCell

@property (nonatomic, strong) HomeProduct *model;
@property (nonatomic ,strong) ImaginaryLine *lineView;
@property (nonatomic ,strong) BezierPathLine *bezierView;
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UIImageView *fanImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *desLab;
@property (nonatomic, strong) UILabel *fanLab;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *amountKindLab;
@property (nonatomic, strong) UILabel *qiLab;
@property (nonatomic ,assign) NSInteger indexPathRow;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
