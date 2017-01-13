//
//  DescriptionTypeSexCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface DescriptionTypeSexCell : UITableViewCell
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *detialLab;
@property (nonatomic ,strong) UIImageView *detialImg;
@property (nonatomic ,strong) UIButton *detailButton;
@property (nonatomic ,strong) UIButton *mainBtn;
@property (nonatomic ,strong) UIButton *womanBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
