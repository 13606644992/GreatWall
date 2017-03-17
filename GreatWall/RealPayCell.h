//
//  RealPayCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/23.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface RealPayCell : UITableViewCell
@property (nonatomic ,strong)PayTrade *trade;

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *amountLab;

+ (instancetype)cellWithTheRealPayTableView:(UITableView *)tableView;

@end
