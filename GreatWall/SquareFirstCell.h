//
//  SquareFirstCell.h
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareModel.h"

@interface SquareFirstCell : UITableViewCell

@property (nonatomic, strong) SquareModel *model;
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *desLab;
@property (nonatomic, strong) UILabel *tuiLab;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *qiLab;


+(instancetype)SquareFcellWithTableView:(UITableView *)tableView;

@end
