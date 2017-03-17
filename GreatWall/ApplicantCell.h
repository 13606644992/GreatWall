//
//  ApplicantCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface ApplicantCell : UITableViewCell

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UITextField *detailTF;
@property (nonatomic ,strong) UIButton *personButton;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
