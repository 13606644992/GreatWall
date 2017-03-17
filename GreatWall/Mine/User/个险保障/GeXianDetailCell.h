//
//  GeXianDetailCell.h
//  GreatWall
//
//  Created by GJ on 2017/2/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaoDanDetailModel;
@interface GeXianDetailCell : UITableViewCell
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *contentLab;
@property (nonatomic, strong)BaoDanDetailModel *detailModel;
@end
