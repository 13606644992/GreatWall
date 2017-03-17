//
//  SquareSecondCell.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "SquareSecondCell.h"
#import "Header.h"

@implementation SquareSecondCell
+(instancetype)SquareScellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SquareFCell";
    SquareSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];

        [cell initSquareThingWith:cell];
    }
    return cell;

}
-(void)initSquareThingWith:(SquareSecondCell *)cell
{
    __weak SquareSecondCell *view= cell;
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
    [cell.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(view).with.offset(-15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(13*HEIGHT);
        make.height.equalTo(@(15));
    }];
    
}
-(void)setModel:(SquareModel *)model
{
    if (model) {
        [self.titleImg sd_setImageWithURL:[NSURL URLWithString:model.adURL] placeholderImage:PlaceImage];
        self.titleLab.text = model.title;
        self.desLab.text = model.keyWords;
    }
}
-(void)setModelSpecial:(SquareSpecial *)modelSpecial
{
    if (modelSpecial) {
        [self.titleImg sd_setImageWithURL:[NSURL URLWithString:modelSpecial.specialLogo] placeholderImage:PlaceImage];
        self.titleLab.text = modelSpecial.specialName;
        self.desLab.text = modelSpecial.specialIntro;
    }
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
        _titleLab.font =  [UIFont systemFontOfSize:16*WIDTH];
        _titleLab.text = @"家有儿女";
    }
    return _titleLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.textColor = LYColor_A4;
        _desLab.font = [UIFont systemFontOfSize:12*HEIGHT];
        _desLab.text = @"妈妈早策划，宝宝早保障";
    }
    return _desLab;
}
-(AllLine *)lineView
{
    if (!_lineView) {
        _lineView = [[AllLine alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 230*HEIGHT)];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}
//-(UILabel *)amountLab
//{
//    if (!_amountLab) {
//        _amountLab = [[UILabel alloc] init];
//        _amountLab.textColor = [UIColor redColor];
//        _amountLab.font = [UIFont systemFontOfSize:17];
//        _amountLab.text = @"¥2500";
//    }
//    return _amountLab;
//}
//-(UILabel *)qiLab
//{
//    if (!_qiLab) {
//        _qiLab = [[UILabel alloc] init];
//        _qiLab.textColor = [UIColor blackColor];
//        _qiLab.font = [UIFont systemFontOfSize:14];
//        _qiLab.text = @"起";
//    }
//    return _qiLab;
//}
//-(UILabel *)tuiLab
//{
//    if (!_tuiLab) {
//        _tuiLab = [[UILabel alloc] init];
//        _tuiLab.textColor = [UIColor redColor];
//        _tuiLab.font = [UIFont systemFontOfSize:14];
//        _tuiLab.text = @"36%推广费";
//        _tuiLab.textAlignment = NSTextAlignmentRight;
//    }
//    return _tuiLab;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
