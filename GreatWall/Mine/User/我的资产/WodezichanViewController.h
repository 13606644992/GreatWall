//
//  WodezichanViewController.h
//  GreatWall
//
//  Created by GJ on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "RootViewController.h"
#import "PNChart.h"

@interface WodezichanViewController : RootViewController<PNChartDelegate>
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UILabel *benyueshouru;
@property (nonatomic, strong)UILabel *jiesuanzhong;
@property (nonatomic, strong)UILabel *leijishouru;
@end
