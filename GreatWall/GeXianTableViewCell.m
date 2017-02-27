//
//  GeXianTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "GeXianTableViewCell.h"
#import "Header.h"
@implementation GeXianTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:  reuseIdentifier];
    
    return self;
}
- (void)creatSubView{
    self.contentView.backgroundColor = LYColor_A7;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(339*WIDTH);
        make.height.mas_equalTo(190*HEIGHT);
    }];
    [background layoutIfNeeded];
    //   圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:background.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = background.bounds;
    maskLayer.path = maskPath.CGPath;
    background.layer.mask = maskLayer;

    [background addSubview:self.logoIMG];
    [background addSubview:self.title];
    [background addSubview:self.baodanhao];
    [background addSubview:self.beibaoren];
    [background addSubview:self.toubaoren];
    [background addSubview:self.baoxianqijian];
    [background addSubview:self.logoIMG];
    [background addSubview:self.dingdanjine];
    [background addSubview:self.tuikuangfei];
    [self.logoIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-21*WIDTH);
        make.size.mas_equalTo(CGSizeMake(62*WIDTH, 52*HEIGHT));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30*HEIGHT);
        make.left.mas_equalTo(26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 18*HEIGHT));
    }];
    [self.baodanhao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).with.offset(21*HEIGHT);
        make.left.mas_equalTo(26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 11*HEIGHT));
    }];
    [self.beibaoren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baodanhao.mas_bottom).with.offset(8*HEIGHT);
        make.left.mas_equalTo(26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 11*HEIGHT));
    }];
    [self.toubaoren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.beibaoren.mas_bottom).with.offset(8*HEIGHT);
        make.left.mas_equalTo(26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 11*HEIGHT));
    }];
    [self.baoxianqijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toubaoren.mas_bottom).with.offset(8*HEIGHT);
        make.left.mas_equalTo(26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 11*HEIGHT));
    }];
    [self.dingdanjine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baoxianqijian.mas_bottom).with.offset(17*HEIGHT);
        make.left.mas_equalTo(26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 12*HEIGHT));
    }];
    [self.tuikuangfei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dingdanjine);
        make.right.mas_equalTo(-26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 12*HEIGHT));
    }];
    self.title.text = @"个人借款保证保险";
    self.baodanhao.text = @"保单号：2342304249525689";
    self.beibaoren.text = @"被保人：关键";
    self.toubaoren.text = @"投保人：关键";
    self.baoxianqijian.text = @"保险期间：2016-12-10至2017-12-09";
    self.dingdanjine.text = @"订单金额：198.00元";
    self.tuikuangfei.text = @"推广费：32.90元";
    self.logoIMG.image = [UIImage imageNamed:@"baozhangzhong.png"];
}
/*****************************************懒加载**************************************************/

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = LYColor_A3;
        _title.font = [UIFont systemFontOfSize:18.0f * HEIGHT];
    }
    return _title;
}
- (UILabel *)baoxianqijian{
    if (!_baoxianqijian) {
        _baoxianqijian = [[UILabel alloc]init];
        _baoxianqijian.textColor = LYColor_A5;
        _baoxianqijian.font = [UIFont systemFontOfSize:11.0f * HEIGHT];
    }
    return _baoxianqijian;
}
- (UILabel *)baodanhao{
    if (!_baodanhao) {
        _baodanhao = [[UILabel alloc]init];
        _baodanhao.textColor = LYColor_A5;
        _baodanhao.font = [UIFont systemFontOfSize:11.0f * HEIGHT];
    }
    return _baodanhao;
}
- (UILabel *)beibaoren{
    if (!_beibaoren) {
        _beibaoren = [[UILabel alloc]init];
        _beibaoren.textColor = LYColor_A5;
        _beibaoren.font = [UIFont systemFontOfSize:11.0f * HEIGHT];
    }
    return _beibaoren;
}
- (UILabel *)toubaoren{
    if (!_toubaoren) {
        _toubaoren = [[UILabel alloc]init];
        _toubaoren.textColor = LYColor_A5;
        _toubaoren.font = [UIFont systemFontOfSize:11.0f * HEIGHT];
    }
    return _toubaoren;
}
- (UILabel *)dingdanjine{
    if (!_dingdanjine) {
        _dingdanjine = [[UILabel alloc]init];
        _dingdanjine.textColor = LYColor_A3;
        _dingdanjine.font = [UIFont systemFontOfSize:12.0f * HEIGHT];
    }
    return _dingdanjine;
}
- (UILabel *)tuikuangfei{
    if (!_tuikuangfei) {
        _tuikuangfei = [[UILabel alloc]init];
        _tuikuangfei.textColor = LYColor_A3;
        _tuikuangfei.font = [UIFont systemFontOfSize:12.0f * HEIGHT];
        _tuikuangfei.textAlignment = NSTextAlignmentRight;
    }
    return _tuikuangfei;
}
- (UIImageView *)logoIMG{
    if (!_logoIMG) {
        _logoIMG = [[UIImageView alloc]init];
        _logoIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoIMG;
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
