//
//  CarSelectCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/3/2.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarSelectModel.h"

@interface CarSelectCell : UITableViewCell
@property (nonatomic, strong) CarSelectModel *model;
@property (nonatomic, strong) UIImageView *xuanImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *desLab;
@property (nonatomic, strong) UILabel *canLab;
@property (nonatomic, strong) UILabel *amountLab;


+(instancetype)CarSelectcellWithTableView:(UITableView *)tableView;

@end
