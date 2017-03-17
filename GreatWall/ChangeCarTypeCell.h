//
//  ChangeCarTypeCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/3/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeCarTypeCell : UITableViewCell

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIImageView *xiaImg;
@property (nonatomic ,strong) UILabel *touLab;
@property (nonatomic ,strong) UIButton *touBtn;
@property (nonatomic ,strong) UIButton *mianBtn;




+(instancetype)ChangeCarTypecellWithTableView:(UITableView *)tableView;

@end
