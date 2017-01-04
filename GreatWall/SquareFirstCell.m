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
        cell.contentView.backgroundColor = UIColorRGBA(242, 242, 242, 1);
        [cell initSquareThingWith:cell];
    }
    return cell;
 
}
-(void)initSquareThingWith:(SquareFirstCell *)cell
{
    __weak SquareFirstCell *view= cell;
    
    [cell.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(30);
        make.top.equalTo(view).with.offset(20);
        make.right.equalTo(view).with.offset(-30);
        make.height.equalTo(@(100));
    }];
    [cell.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImg);
        make.right.equalTo(self.titleImg);
        make.top.mas_equalTo(self.titleImg.mas_bottom).with.offset(5);
        make.height.equalTo(@(25));
    }];
    [cell.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(view).with.offset(-15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(5);
        make.height.equalTo(@(15));
    }];
    [cell.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(2);
        make.width.equalTo(@(100));
        make.height.equalTo(@(25));
    }];
    [cell.contentView addSubview:self.qiLab];
    [self.qiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [cell.contentView addSubview:self.tuiLab];
    [self.tuiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qiLab.mas_right).with.offset(80);
        make.top.equalTo(self.qiLab);
        make.right.equalTo(view).with.offset(-30);
        make.height.equalTo(@(20));
    }];
    
}
-(void)setModel:(SquareModel *)model
{
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
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont fontWithName:JiaCu size:17*HEIGHT];
        _titleLab.text = @"至尊车险";
    }
    return _titleLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.textColor = [UIColor blackColor];
        _desLab.font = [UIFont systemFontOfSize:14*HEIGHT];
        _desLab.text = @"超值保障|全国通赔";
    }
    return _desLab;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] init];
        _amountLab.textColor = [UIColor redColor];
        _amountLab.font = [UIFont systemFontOfSize:17*HEIGHT];
        _amountLab.text = @"¥2500";
    }
    return _amountLab;
}
-(UILabel *)qiLab
{
    if (!_qiLab) {
        _qiLab = [[UILabel alloc] init];
        _qiLab.textColor = [UIColor blackColor];
        _qiLab.font = [UIFont systemFontOfSize:14*HEIGHT];
        _qiLab.text = @"起";
    }
    return _qiLab;
}
-(UILabel *)tuiLab
{
    if (!_tuiLab) {
        _tuiLab = [[UILabel alloc] init];
        _tuiLab.textColor = [UIColor redColor];
        _tuiLab.font = [UIFont systemFontOfSize:14*HEIGHT];
        _tuiLab.text = @"36%推广费";
        _tuiLab.textAlignment = NSTextAlignmentRight;
    }
    return _tuiLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
