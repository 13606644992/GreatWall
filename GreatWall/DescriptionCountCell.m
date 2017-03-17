//
//  DescriptionCountCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DescriptionCountCell.h"

@implementation DescriptionCountCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DescriptionCountCell";
    
    DescriptionCountCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initWithTheDescriptionCount];
    }
    return cell;
}
-(void)initWithTheDescriptionCount
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(24*WIDTH, 24*WIDTH));
    }];
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.addButton.mas_left);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(46*WIDTH, 24*WIDTH));
    }];
    [self.contentView addSubview:self.reduceButton];
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.countLab.mas_left);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(24*WIDTH, 24*WIDTH));
    }];
}
-(void)countClick:(UIButton *)sender
{
    NSInteger count = [self.countLab.text integerValue];
    switch (sender.tag) {
        case 1:
        {
            if (self.mostCount) {
                if (self.mostCount==0||count<self.mostCount) {
                    count++;
                    self.countLab.text = [NSString stringWithFormat:@"%ld",(long)count];
                }
            }
        }
            break;
        case 2:
        {
            if (count == 1) {
                break;
            }else{
                count--;
                self.countLab.text = [NSString stringWithFormat:@"%ld",(long)count];
            }
        }
            break;
        default:
            break;
    }
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)count],@"count", nil];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"SelectCount" object:nil userInfo:dict]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ---------Controller-------------

-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        _titleLab.text = @"购买份数";
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
    }
    return _titleLab;
}
-(UILabel *)countLab
{
    if (!_countLab) {
        _countLab = [[UILabel alloc] init];
        _countLab.textAlignment = NSTextAlignmentCenter;
        _countLab.textColor = LYColor_A3;
        _countLab.text = @"1";
        _countLab.font = [UIFont systemFontOfSize:14*WIDTH];
    }
    return _countLab;
}
-(UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(countClick:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.tag = 1;
    }
    
    return _addButton;
}
-(UIButton *)reduceButton
{
    if (!_reduceButton) {
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceButton setImage:[UIImage imageNamed:@"_"] forState:UIControlStateNormal];
        [_reduceButton addTarget:self action:@selector(countClick:) forControlEvents:UIControlEventTouchUpInside];
        _reduceButton.tag = 2;
    }
    return _reduceButton;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
    
    // Configure the view for the selected state
}

@end
