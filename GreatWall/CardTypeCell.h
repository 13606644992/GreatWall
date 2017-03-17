//
//  CardTypeCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface CardTypeCell : UITableViewCell
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *detailLab;
@property (nonatomic ,strong) UIButton *typeButton;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
