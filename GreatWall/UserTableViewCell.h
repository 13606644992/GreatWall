//
//  UserTableViewCell.h
//  GreatWall
//
//  Created by GJ on 2016/12/30.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell
@property (nonatomic, strong)UIView *line;
@property (nonatomic, assign)NSInteger tagNum;
@property (nonatomic, strong)UIImageView *iconIMGView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *yaoqing;
@property (nonatomic, strong)UILabel *kefu;


- (void)setImgeWith:(UIImage *)image AndTitle:(NSString *)string;
- (void)addYaoqingAnKefu;
@end
