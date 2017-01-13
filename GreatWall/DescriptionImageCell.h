//
//  DescriptionImageCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/1/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface DescriptionImageCell : UITableViewCell
@property (nonatomic ,strong) UIImageView *titleImg;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
