//
//  CarSelectCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/2.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CarSelectCell.h"
#import "Header.h"

@implementation CarSelectCell
+(instancetype)CarSelectcellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CarSelectCell";
    CarSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell loadTheCarMsg];
        
    }
    return cell;
}
-(void)loadTheCarMsg{
    [self.contentView addSubview:self.xuanImg];
    [self.xuanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(38*WIDTH, 27*HEIGHT));
    }];
    
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(@(21*HEIGHT));
        make.right.equalTo(@(-50*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    
    [self.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(13*HEIGHT);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    
    [self.contentView addSubview:self.canLab];
    [self.canLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(13*HEIGHT);
        make.width.equalTo(@(76*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    
    [self.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.canLab.mas_right).with.offset(13*WIDTH);
        make.top.equalTo(self.canLab);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark -----Controller------
-(UIImageView *)xuanImg{
    if (!_xuanImg) {
        _xuanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xuanzhong(chexian)"]];
    }
    return _xuanImg;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"君威   别克牌SGM7161WAS3轿车   手自一体";
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.textColor = LYColor_A3;
    }
    return _titleLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.text = @"2014   领先技术型   5座";
        _desLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _desLab.textColor = LYColor_A3;
    }
    return _desLab;
}
-(UILabel *)canLab
{
    if (!_canLab) {
        _canLab = [[UILabel alloc] init];
        _canLab.text = @"新车参考价:";
        _canLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _canLab.textColor = LYColor_A3;
    }
    return _canLab;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] init];
        _amountLab.text = @"159900元";
        _amountLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _amountLab.textColor = LYColor_A2;
    }
    return _amountLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
