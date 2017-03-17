//
//  ZengXianTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ZengXianTableViewCell.h"
#import "Header.h"
#import "ZengXianModel.h"
@implementation ZengXianTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = LYColor_A7;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)creatKeLingQu{
    UIImageView *background = [[UIImageView alloc]init];
    background.image = [UIImage imageNamed:@"zengxian-chanpin.png"];
    [self.contentView addSubview:background];
    background.userInteractionEnabled = YES;
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(339*WIDTH, 265*HEIGHT));
    }];
    [background addSubview:self.productIMG];
    [self.productIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(120*HEIGHT);
    }];
    [self.productIMG addSubview:self.titleLabel];
    [background addSubview:self.age];
    [background addSubview:self.baozhangqixian];
    [background addSubview:self.baoE];
    [background addSubview:self.timeLabel];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.productIMG).with.offset(-13*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(300*WIDTH, 14*HEIGHT));
    }];
    [self.age mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.productIMG.mas_bottom).with.offset(12*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 11*HEIGHT));
    }];
    [self.baoE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.age.mas_bottom).with.offset(7*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 11*HEIGHT));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baoE.mas_bottom).with.offset(10*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 8*HEIGHT));
    }];
    [self.baozhangqixian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.age);
        make.left.mas_equalTo(127*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 8*HEIGHT));
    }];
    
    UIImageView *redIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zengxian-xianlaing.png"]];
    redIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.productIMG addSubview:redIMG];
    [redIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13*HEIGHT);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(84*WIDTH, 20*HEIGHT));
    }];
    [redIMG addSubview:self.xiangouLabel];
    [self.xiangouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [background addSubview:self.logoIMG];
    [self.logoIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.top.mas_equalTo(self.productIMG.mas_bottom).with.offset(12*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 30*HEIGHT));
    }];
    [background addSubview:self.zengsongBtn];
    [background addSubview:self.toubaoBtn];
    [self.zengsongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.bottom.mas_equalTo(-18*HEIGHT);
        make.height.mas_equalTo(40*HEIGHT);
        make.right.mas_equalTo(self.toubaoBtn.mas_left).with.offset(-19*WIDTH);
    }];
    [self.toubaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.zengsongBtn.mas_right).with.offset(19*WIDTH);
        make.height.and.bottom.mas_equalTo(self.zengsongBtn);
        make.right.mas_equalTo(-18*WIDTH);
        make.width.mas_equalTo(self.zengsongBtn);
    }];
    
    
    self.productIMG.image = [UIImage imageNamed:@"WechatIMG1.png"];
    self.logoIMG.image = [UIImage imageNamed:@"baodan-gongsilogo.png"];
    self.xiangouLabel.text = @"限666份";
    self.titleLabel.text = @"无忧自驾意外综合保障";
    self.age.text = @"年龄：18-60周岁";
    self.baoE.text = @"保额：20万元";
    self.timeLabel.text = @"距离过期还有28天8个小时";
    self.baozhangqixian.text = @"保障期限：90天";
}

- (void)setZengXianModel:(ZengXianModel *)zengXianModel{
    [self.productIMG sd_setImageWithURL:[NSURL URLWithString:zengXianModel.productLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
    [self.logoIMG sd_setImageWithURL:[NSURL URLWithString:zengXianModel.insurerLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
    self.xiangouLabel.text = [NSString stringWithFormat:@"限%@份",zengXianModel.buyCount];
    self.titleLabel.text = zengXianModel.productName;
    NSString *str = [zengXianModel.minAge stringByReplacingOccurrencesOfString:@"周岁" withString:@""];
    self.age.text = [NSString stringWithFormat:@"年龄：%@-%@",str,zengXianModel.maxAge];
    self.baoE.text = [NSString stringWithFormat:@"保额：%.0f万元",[zengXianModel.sumInsured floatValue]/1000000];
    self.baozhangqixian.text = [NSString stringWithFormat:@"保障期限：%@天",zengXianModel.guaranteePeriod];
    self.timeLabel.text =[NSString stringWithFormat:@"距离过期还有%@",zengXianModel.expTime];
    
    //已使用
//    [self.logo sd_setImageWithURL:[NSURL URLWithString:zengXianModel.insurerLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
//    self.baodanhao.text = [NSString stringWithFormat:@"保单号：%@",zengXianModel.policyNo];
//    self.beibaoxianren.text = [NSString stringWithFormat:@"被保险人：%@",zengXianModel.insuredName];
//    self.toubaoren.text = [NSString stringWithFormat:@"投保人：%@",zengXianModel.policyholderName];
//    NSLog(@"🐷%@",zengXianModel.startTime );
////    self.baoxianqijian.text = [NSString stringWithFormat:@"保险期间：%@至%@",[zengXianModel.startTime substringToIndex:10],[zengXianModel.endTime substringToIndex:10]];
    
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
    
    self.titleLabel.text = @"无忧自驾意外综合保障险";
    self.baodanhao.text = @"保单号：12345678901234567890";
    self.beibaoxianren.text = @"被保险人：成都";
    self.toubaoren.text = @"投保人：赵雷";
    self.baoxianqijian.text = @"保险期间：2012-02-02 至 2012--2-03";
    self.logo.image = [UIImage imageNamed:@"yinhangbiaozhi"];
}




- (UIImageView *)productIMG{
    if (!_productIMG) {
        _productIMG = [[UIImageView alloc]init];
//        _productIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _productIMG;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _titleLabel;
}
- (UILabel *)baoE{
    if (!_baoE) {
        _baoE = [[UILabel alloc]init];
        _baoE.textColor = LYColor_A5;
        _baoE.font = [UIFont systemFontOfSize:11*HEIGHT];
    }
    return _baoE;
}
- (UILabel *)age{
    if (!_age) {
        _age = [[UILabel alloc]init];
        _age.textColor = LYColor_A5;
        _age.font = [UIFont systemFontOfSize:11*HEIGHT];
    }
    return _age;
}- (UILabel *)baozhangqixian{
    if (!_baozhangqixian) {
        _baozhangqixian = [[UILabel alloc]init];
        _baozhangqixian.textColor = LYColor_A5;
        _baozhangqixian.font = [UIFont systemFontOfSize:11*HEIGHT];
    }
    return _baozhangqixian;
}- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = LYColor_A2;
        _timeLabel.font = [UIFont systemFontOfSize:11*HEIGHT];
    }
    return _timeLabel;
}
- (UILabel *)xiangouLabel{
    if (!_xiangouLabel) {
        _xiangouLabel = [[UILabel alloc]init];
        _xiangouLabel.textColor = [UIColor whiteColor];
        _xiangouLabel.font = [UIFont systemFontOfSize:11*HEIGHT];
        _xiangouLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _xiangouLabel;
}
- (UIImageView *)logoIMG{
    if (!_logoIMG) {
        _logoIMG = [[UIImageView alloc]init];
//        _logoIMG.contentMode = UIViewContentModeRight;
    }
    return _logoIMG;
}
- (UIButton *)zengsongBtn{
    if (!_zengsongBtn) {
        _zengsongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _zengsongBtn.backgroundColor = LYColor_A1;
        [_zengsongBtn setTitle:@"赠送客户" forState:UIControlStateNormal];
        [_zengsongBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _zengsongBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        _zengsongBtn.layer.cornerRadius = 2.0f;
        _zengsongBtn.tag = 1000;
    }
    return _zengsongBtn;
}
- (UIButton *)toubaoBtn{
    if (!_toubaoBtn) {
        _toubaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _toubaoBtn.backgroundColor = LYColor_A2;
        [_toubaoBtn setTitle:@"立即投保" forState:UIControlStateNormal];
        [_toubaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _toubaoBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        _toubaoBtn.layer.cornerRadius = 2.0f;
        _toubaoBtn.tag = 1001;
    }
    return _toubaoBtn;
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







