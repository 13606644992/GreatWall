//
//  CarMallCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/1/3.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "MallModel.h"

@interface CarMallCell : UITableViewCell
@property (nonatomic, strong) MallModel *model;
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *carTypeLab;
@property (nonatomic, strong) UILabel *areaLab;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UILabel *brandLab;
@property (nonatomic, strong) UILabel *countLab;

+(instancetype)MallcellWithTableView:(UITableView *)tableView;

@end
