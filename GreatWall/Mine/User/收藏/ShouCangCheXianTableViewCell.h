//
//  CheXianTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/3/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "ShouCangModel.h"
@interface ShouCangCheXianTableViewCell : UITableViewCell

@property (nonatomic, strong) ShouCangModel *model;
@property (nonatomic ,strong) AllLine *lineView;
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *carTypeLab;
@property (nonatomic, strong) UILabel *areaLab;
//@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UILabel *brandLab;
@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) UIImageView *fanImg;
@property (nonatomic, strong) UILabel *fanLab;

+(instancetype)MallcellWithTableView:(UITableView *)tableView;


@end
