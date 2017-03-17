//
//  PolicyholderCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface PolicyholderCell : UITableViewCell
@property (nonatomic ,strong)PayTrade *trade;

@property (nonatomic ,strong)UILabel *nameOne;
@property (nonatomic ,strong)UILabel *cardTypeTwo;
@property (nonatomic ,strong)UILabel *cardNumThree;
@property (nonatomic ,strong)UILabel *phoneFour;

@property (nonatomic ,strong)UILabel *nameLab;
@property (nonatomic ,strong)UILabel *cardType;
@property (nonatomic ,strong)UILabel *cardNum;
@property (nonatomic ,strong)UILabel *phoneNum;
@property (nonatomic ,strong)UIColor *selectColor;
@property (nonatomic ,strong)NSArray *cards;


+ (instancetype)cellWithThePolicyHoderTableView:(UITableView *)tableView;

@end
