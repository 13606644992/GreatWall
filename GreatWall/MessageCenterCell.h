//
//  MessageCenterCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/3/14.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface MessageCenterCell : UITableViewCell

/*
 *  Model类
 */
@property (nonatomic ,strong) MessageModel *model;
@property (nonatomic, strong) UIImageView *selectImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *desLab;
@property (nonatomic, strong) UILabel *timeLab;



+ (instancetype)cellWithMessageCenterView:(UITableView *)tableView;
-(CGFloat)getHeights;
@end
