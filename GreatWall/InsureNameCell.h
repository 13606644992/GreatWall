//
//  InsureNameCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface InsureNameCell : UITableViewCell
@property (nonatomic ,strong)PayTrade *trade;

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIImageView *titleImg;
@property (nonatomic ,strong) UIImageView *rightImg;
@property (nonatomic ,strong) UILabel *linelab;
@property (nonatomic ,strong)UIColor *selectColor;


+ (instancetype)cellWithTheInsureNameTableView:(UITableView *)tableView;
@end
