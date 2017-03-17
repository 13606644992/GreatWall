//
//  YiShiYongTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/3/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "YiShiYongTableViewCell.h"
#import "Header.h"
#import "ZengXianModel.h"

@implementation YiShiYongTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = LYColor_A7;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

/**
 已使用
 */
- (void)creatYiShiYong{
    
    UIImageView *background = [[UIImageView alloc]init];
    background.image = [UIImage imageNamed:@"zengxian-zengxian"];
    [self.contentView addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(339*WIDTH, 211*HEIGHT));
    }];
    UILabel *btnLabel = [[UILabel alloc]init];
    btnLabel.text = @"为客户推荐相似产品";
    btnLabel.textColor = [UIColor whiteColor];
    btnLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    btnLabel.textAlignment = NSTextAlignmentCenter;
    [background addSubview:btnLabel];
    [btnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-18*HEIGHT);
        make.centerX.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 15*HEIGHT));
    }];
    
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:18*HEIGHT];
    self.titleLabel.textColor = LYColor_A3;
    [background addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30*HEIGHT);
        make.left.mas_equalTo(26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 18*HEIGHT));
    }];
    
    [background addSubview:self.logo];
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26*WIDTH);
        make.centerY.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(50*WIDTH, 30*HEIGHT));
    }];
    
    [background addSubview:self.baodanhao];
    [self.baodanhao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(280*WIDTH, 11*HEIGHT));
    }];
    
    [background addSubview:self.beibaoxianren];
    [self.beibaoxianren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baodanhao.mas_bottom).offset(8*HEIGHT);
        make.left.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(self.baodanhao);
    }];
    
    [background addSubview:self.toubaoren];
    [self.toubaoren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.beibaoxianren.mas_bottom).offset(8*HEIGHT);
        make.size.mas_equalTo(self.baodanhao);
    }];
    
    [background addSubview:self.baoxianqijian];
    [self.baoxianqijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toubaoren.mas_bottom).offset(8*HEIGHT);
        make.left.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(self.baodanhao);
    }];
    
}

- (void)setZengXianModel:(ZengXianModel *)zengXianModel{

    self.titleLabel.text = zengXianModel.productName;
    
    //已使用
    [self.logo sd_setImageWithURL:[NSURL URLWithString:zengXianModel.insurerLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
    self.baodanhao.text = [NSString stringWithFormat:@"保单号：%@",zengXianModel.policyNo];
    self.beibaoxianren.text = [NSString stringWithFormat:@"被保险人：%@",zengXianModel.insuredName];
    self.toubaoren.text = [NSString stringWithFormat:@"投保人：%@",zengXianModel.policyholderName];
    NSLog(@"🐷%@",zengXianModel.startTime );
    self.baoxianqijian.text = [NSString stringWithFormat:@"保险期间：%@至%@",[zengXianModel.startTime substringToIndex:10],[zengXianModel.endTime substringToIndex:10]];
    
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _titleLabel;
}
- (UILabel *)baodanhao{
    if (!_baodanhao) {
        _baodanhao = [[UILabel alloc]init];
        _baodanhao.font = [UIFont systemFontOfSize:11*HEIGHT];
        _baodanhao.textColor = LYColor_A4;
    }
    return _baodanhao;
}
- (UILabel *)beibaoxianren{
    if (!_beibaoxianren) {
        _beibaoxianren = [[UILabel alloc]init];
        _beibaoxianren.font = [UIFont systemFontOfSize:11*HEIGHT];
        _beibaoxianren.textColor = LYColor_A4;
    }
    return _beibaoxianren;
}
- (UILabel *)toubaoren{
    if (!_toubaoren) {
        _toubaoren = [[UILabel alloc]init];
        _toubaoren.font = [UIFont systemFontOfSize:11*HEIGHT];
        _toubaoren.textColor = LYColor_A4;
    }
    return _toubaoren;
}
- (UILabel *)baoxianqijian{
    if (!_baoxianqijian) {
        _baoxianqijian = [[UILabel alloc]init];
        _baoxianqijian.font = [UIFont systemFontOfSize:11*HEIGHT];
        _baoxianqijian.textColor = LYColor_A4;
    }
    return _baoxianqijian;
}

- (UIImageView *)logo{
    if (!_logo) {
        _logo = [[UIImageView alloc]init];
    }
    return _logo;
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
