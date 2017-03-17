//
//  ReducePayCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/23.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface ReducePayCell : UITableViewCell

@property (nonatomic ,strong)PayTrade *trade;

@property (nonatomic ,strong)UILabel *insureLab;
@property (nonatomic ,strong)UILabel *redPackedLab;
@property (nonatomic ,strong)UILabel *yueLab;

@property (nonatomic ,strong)UILabel *insureAmount;
@property (nonatomic ,strong)UILabel *reduceRedPacked;
@property (nonatomic ,strong)UILabel *reduceYue;
@property (nonatomic ,strong) UILabel *linelab;

+ (instancetype)cellWithTheReducePayCellTableView:(UITableView *)tableView;

@end
