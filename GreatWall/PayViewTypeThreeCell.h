//
//  PayViewTypeThreeCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface PayViewTypeThreeCell : UITableViewCell

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *detailLab;
@property (nonatomic ,strong) UIImageView *styleImg;
@property (nonatomic ,strong) UILabel *lineLab;

+ (instancetype)cellWithPayViewTypeTableView:(UITableView *)tableView;


@end
