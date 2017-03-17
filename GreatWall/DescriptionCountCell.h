//
//  DescriptionCountCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface DescriptionCountCell : UITableViewCell

@property (nonatomic ,assign) NSInteger mostCount;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *countLab;
@property (nonatomic ,strong) UIButton *addButton;
@property (nonatomic ,strong) UIButton *reduceButton;




+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
