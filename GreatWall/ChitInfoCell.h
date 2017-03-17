//
//  ChitInfoCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface ChitInfoCell : UITableViewCell
{
    
}
@property (nonatomic ,strong)PayTrade *trade;
@property (nonatomic ,strong)UILabel *orderOne;
@property (nonatomic ,strong)UILabel *orderTwo;
@property (nonatomic ,strong)UILabel *insureThree;
@property (nonatomic ,strong)UILabel *startFour;
@property (nonatomic ,strong)UILabel *endFive;
@property (nonatomic ,strong)UILabel *orderStyle;
@property (nonatomic ,strong)UILabel *orderNum;
@property (nonatomic ,strong)UILabel *insureNum;
@property (nonatomic ,strong)UILabel *startTime;
@property (nonatomic ,strong)UILabel *endTime;
@property (nonatomic ,strong)UIColor *selectColor;

+ (instancetype)cellWithTheChitInfoTableView:(UITableView *)tableView;

@end
