//
//  DescriptionCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"


@interface DescriptionCell : UITableViewCell

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *detialLab;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
