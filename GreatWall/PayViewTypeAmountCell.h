//
//  PayViewTypeAmountCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface PayViewTypeAmountCell : UITableViewCell


@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *detialLab;
@property (nonatomic ,strong) UILabel *lineLab;


+ (instancetype)cellWithPayViewTableView:(UITableView *)tableView;
@end
