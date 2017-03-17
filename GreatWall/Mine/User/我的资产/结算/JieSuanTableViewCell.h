//
//  JieSuanTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/1/11.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JieSuanModel;

@interface JieSuanTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *date;
@property (nonatomic, strong)UILabel *time;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *number;
@property (nonatomic, strong)UILabel *money;
@property (nonatomic, strong)UIView *myView;
@property (nonatomic, strong)JieSuanModel *jieSuanModel;
@end
