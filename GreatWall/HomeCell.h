//
//  HomeCell.h
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "HomeCellModel.h"

@interface HomeCell : UITableViewCell

@property (nonatomic, strong) HomeCellModel *model;
@property (nonatomic ,strong) OnlyLine *lineView;
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UIImageView *fanImg;
@property (nonatomic, strong) UILabel *rmbLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *desLab;
@property (nonatomic, strong) UILabel *fanLab;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *qiLab;
@property (nonatomic ,assign) NSInteger indexPathRow;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
