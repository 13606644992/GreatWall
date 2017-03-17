//
//  InsuredPerCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface InsuredPerCell : UITableViewCell
@property (nonatomic ,strong)PayTrade *trade;

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong)UIColor *selectColor;
@property (nonatomic ,strong)NSArray *relations;

+ (instancetype)cellWithTheInsureTableView:(UITableView *)tableView;
@end
