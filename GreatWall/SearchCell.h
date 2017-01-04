//
//  SearchCell.h
//  GreatWall
//
//  Created by 李阳 on 2016/12/23.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface SearchCell : UITableViewCell

@property (nonatomic, strong) UIImageView *hotImg;
@property (nonatomic, strong) UILabel *titleLab;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
