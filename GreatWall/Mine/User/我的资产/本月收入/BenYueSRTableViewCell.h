//
//  BenYueSRTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/3/1.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BenYueModel;
@interface BenYueSRTableViewCell : UITableViewCell

@property (nonatomic, strong)UIView *myView;
@property (nonatomic, strong) UILabel *timelabel;
@property (nonatomic, strong) UILabel *numberlabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) BenYueModel *benYueModel;

@end
