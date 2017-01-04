//
//  SearchCell.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/23.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SearchCell";
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.backgroundColor = UIColorRGBA(242, 242, 242, 1);
        [cell initSearchCellAnyThingWith];
    }
    return cell;
}
-(void)initSearchCellAnyThingWith
{
    [self.contentView addSubview:self.hotImg];
    [self.hotImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(20*HEIGHT);
        make.top.equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(20*HEIGHT, 20*HEIGHT));
    }];
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hotImg.mas_right).with.offset(10*HEIGHT);
        make.top.equalTo(self.hotImg);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-20*HEIGHT);
        make.height.equalTo(@(20*HEIGHT));
    }];
}
#pragma mark ---------Controller--------
-(UIImageView *)hotImg
{
    if (!_hotImg) {
        _hotImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _hotImg.backgroundColor = [UIColor greenColor];
    }
    return _hotImg;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.text = @"汇保险";
        _titleLab.font = [UIFont systemFontOfSize:14*HEIGHT];
        _titleLab.textColor = [UIColor grayColor];
    }
    return _titleLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
