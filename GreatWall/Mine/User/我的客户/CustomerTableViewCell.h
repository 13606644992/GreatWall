//
//  CustomerTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2017/3/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Customer;

@interface CustomerTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) Customer *customerModel;

@end
