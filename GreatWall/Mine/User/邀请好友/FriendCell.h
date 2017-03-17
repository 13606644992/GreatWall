//
//  FriendCell.h
//  YaoQingHaoYou
//
//  Created by LeeGJ on 17/3/8.
//  Copyright © 2017年 LeeGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YaoQingModel;

@interface FriendCell : UITableViewCell
@property (nonatomic , strong)UILabel *number;
@property (nonatomic , strong)UIImageView *headIMG;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UILabel *income;
@property (nonatomic , strong)YaoQingModel *yaoQingModel;
@end
