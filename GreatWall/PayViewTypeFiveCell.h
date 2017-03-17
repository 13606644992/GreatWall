//
//  PayViewTypeFiveCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface PayViewTypeFiveCell : UITableViewCell

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *numberLab;
@property (nonatomic ,strong) UIButton *segementBtn;
@property (nonatomic ,strong) UILabel *lineLab;

+ (instancetype)cellWithPayViewTypeFiveTableView:(UITableView *)tableView;

@end
