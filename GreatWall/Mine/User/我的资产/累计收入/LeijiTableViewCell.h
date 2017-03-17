//
//  LeijiTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/1/12.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeiJiShouRuModel;

@interface LeijiTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *date;
@property (nonatomic, strong)UILabel *money;
@property (nonatomic, strong)UIImageView *jiantouIMG;
@property (nonatomic, strong)LeiJiShouRuModel *leiJiModel;
@end
