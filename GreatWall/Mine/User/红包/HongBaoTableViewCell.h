//
//  HongBaoTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/1/17.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HongBaoModel;

@interface HongBaoTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *leftIMG;
@property (nonatomic, strong)UIImageView *rightIMG;
@property (nonatomic, strong)UILabel *money;
@property (nonatomic, strong)UILabel *tiaojian;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *date;
@property (nonatomic, strong)UILabel *context;
@property (nonatomic, strong)UIImageView *lastDayIMG;
@property (nonatomic, strong)UIImageView *lineIMG;
@property (nonatomic, strong)UILabel *shiyong;
@property (nonatomic, strong)UIImageView *shiyongGuoqiIMG;

@property (nonatomic, strong)NSString *type;

@property (nonatomic, strong) HongBaoModel *hongBaoModel;

- (void)creatSubView;
@end
