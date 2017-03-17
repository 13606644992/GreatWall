//
//  SquareFirstCell.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "SquareFirstCell.h"
#import "Header.h"

@implementation SquareFirstCell
+(instancetype)SquareFcellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SquareFCell";
    SquareFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell initSquareThingWith:cell];
    }
    return cell;
 
}
-(void)initSquareThingWith:(SquareFirstCell *)cell
{
    __weak SquareFirstCell *view= cell;
    [self.contentView addSubview:self.lineView];
    [cell.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(13*WIDTH);
        make.top.equalTo(view).with.offset(20*WIDTH);
        make.right.equalTo(view).with.offset(-13*WIDTH);
        make.height.equalTo(@(135*HEIGHT));
    }];
    [cell.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImg);
        make.width.equalTo(@(200*WIDTH));
        make.top.mas_equalTo(self.titleImg.mas_bottom).with.offset(13*HEIGHT);
        make.height.equalTo(@(16*HEIGHT));
    }];
    [cell.contentView addSubview:self.qiLab];
    [self.qiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-13*WIDTH);
        make.bottom.equalTo(self.titleLab);
        make.size.mas_equalTo(CGSizeMake(13*WIDTH, 13*WIDTH));
    }];
    [cell.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.qiLab.mas_left).with.offset(-5*WIDTH);
        make.bottom.equalTo(self.titleLab);
        make.width.equalTo(@(100*WIDTH));
        make.height.equalTo(@(16*HEIGHT));
    }];
    //    返现背景图
    [self.contentView addSubview:self.fanImg];
    [self.fanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-13*WEIGHT);
        make.top.mas_equalTo(self.amountLab.mas_bottom).with.offset(11*HEIGHT);
        make.height.equalTo(@(16*HEIGHT));
        make.width.equalTo(@(96*WEIGHT));
    }];
    [cell.contentView addSubview:self.tuiLab];
    [self.tuiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.fanImg);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 11*HEIGHT));
    }];
    [cell.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(self.fanImg.mas_left).with.offset(-13*WIDTH);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(13*HEIGHT);
        make.height.equalTo(@(12*WIDTH));
    }];


}
-(void)setModel:(MallProduct *)model
{
    if ([IS_Bclient integerValue] == 0) {
        self.fanImg.hidden = YES;
        self.tuiLab.hidden = YES;
    }else{
        self.fanImg.hidden = NO;
        self.tuiLab.hidden = NO;
    }
    [self.titleImg sd_setImageWithURL:[NSURL URLWithString:model.productLogo] placeholderImage:PlaceImage];
    self.titleLab.text = model.productName;
    self.desLab.text = model.productIntro;
    self.amountLab.text = [NSString stringWithFormat:@"¥ %@",model.specialPrice];
    self.tuiLab.text = [NSString stringWithFormat:@"推广费最高%@%@",model.commisionValue1,@"%"];
     CGRect tempRect = [self.amountLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-220,25)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17*HEIGHT]}context:nil];
    [self.amountLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tempRect.size.width+5));
    }];
    [self layoutIfNeeded];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ----------Controller---------
-(UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:PlaceImage];
    }
    return _titleImg;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        _titleLab.font = [UIFont systemFontOfSize:16*WIDTH];
        _titleLab.text = @"至尊车险";
    }
    return _titleLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.textColor = LYColor_A4;
        _desLab.font = [UIFont systemFontOfSize:12*WIDTH];
        _desLab.text = @"超值保障|全国通赔";
    }
    return _desLab;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] init];
        _amountLab.textColor = LYColor_A1;
        _amountLab.font = [UIFont systemFontOfSize:16*WIDTH];
        _amountLab.textAlignment = NSTextAlignmentRight;
        _amountLab.text = @"¥ 2500";
    }
    return _amountLab;
}
-(UILabel *)qiLab
{
    if (!_qiLab) {
        _qiLab = [[UILabel alloc] init];
        _qiLab.textColor = LYColor_A4;
        _qiLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _qiLab.text = @"起";
    }
    return _qiLab;
}
-(UIImageView *)fanImg
{
    if (!_fanImg) {
        _fanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tuiguangfeibiaoqian"]];
    }
    return _fanImg;
}
-(UILabel *)tuiLab
{
    if (!_tuiLab) {
        _tuiLab = [[UILabel alloc] init];
        _tuiLab.textColor = [UIColor whiteColor];
        _tuiLab.font = [UIFont systemFontOfSize:11*WIDTH];
        _tuiLab.text = @"推广费最高20%";
        _tuiLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tuiLab;
}
-(AllLine *)lineView
{
    if (!_lineView) {
        _lineView = [[AllLine alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 230*HEIGHT)];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
