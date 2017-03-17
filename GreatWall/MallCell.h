//
//  MallCell.h
//  GreatWall
//
//  Created by 李阳 on 2016/12/26.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "MallModel.h"


@interface MallCell : UITableViewCell


@property (nonatomic, strong) MallProduct *model;
@property (nonatomic ,strong) AllLine *lineView;
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *hotLab;
@property (nonatomic, strong) UILabel *actionLab;
@property (nonatomic, strong) UILabel *brandLab;
@property (nonatomic, strong) UILabel *ageLab;
@property (nonatomic, strong) UILabel *secLab;
@property (nonatomic, strong) UILabel *thirdLab;
@property (nonatomic, strong) UILabel *rmbLab;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *qiLab;
@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) UIImageView *fanImg;
@property (nonatomic, strong) UILabel *fanLab;


+(instancetype)MallcellWithTableView:(UITableView *)tableView;

@end
