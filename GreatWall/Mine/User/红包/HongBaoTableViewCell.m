//
//  HongBaoTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/1/17.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "HongBaoTableViewCell.h"
#import "Header.h"
#import "HongBaoModel.h"
@implementation HongBaoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self creatSubView];
    }
    return self;
}
- (void)creatSubView{
    self.contentView.backgroundColor = LYColor_A7;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.leftIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.leftIMG];
    [self.leftIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(90*WIDTH, 100*HEIGHT));
    }];
   self.rightIMG.image = [UIImage imageNamed:@"hongbao-bai.png"];
//    self.rightIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.rightIMG];
    [self.rightIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.leftIMG.mas_right);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(100*HEIGHT);
    }];
    
    [self.leftIMG addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.leftIMG);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 50*HEIGHT));
    }];
    
    [self.leftIMG addSubview:self.tiaojian];
    [self.tiaojian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftIMG);
        make.bottom.mas_equalTo(self.leftIMG).with.offset(-20*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 12*HEIGHT));
    }];
    
    [self.rightIMG addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*WIDTH);
        make.top.mas_equalTo(20*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 18*HEIGHT));
    }];
    
    [self.rightIMG addSubview:self.date];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.top.mas_equalTo(self.title.mas_bottom).with.offset(13*WIDTH);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 11*HEIGHT));
    }];
    
    [self.rightIMG addSubview:self.context];
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.top.mas_equalTo(self.date.mas_bottom).with.offset(8*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 11*HEIGHT));
    }];
    
    //剩一天
    [self.leftIMG addSubview:self.lastDayIMG];
    [self.lastDayIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50*WIDTH, 50*HEIGHT));
    }];
    
    self.money.text = @"¥66";
    self.tiaojian.text = @"满300元可用";
    self.title.text = @"住院宝红包";
    self.date.text = @"有效期: 2016/12/26 ~ 2016/12/31";
    NSLog(@"%@",self.date.font);
    self.context.text = @"限住院宝产品使用";
    
    if (self.tag == 1000) {//未使用
        self.leftIMG.image = [UIImage imageNamed:@"hongbao-hong.png"];
        //虚线
        [self.rightIMG addSubview:self.lineIMG];
        [self.lineIMG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.rightIMG);
            make.right.mas_equalTo(self.rightIMG).with.offset(-42*WIDTH);
            make.size.mas_equalTo(CGSizeMake(3*WIDTH, 77*HEIGHT));
        }];
        //立即使用
        [self.rightIMG addSubview:self.shiyong];
        [self.shiyong mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-16*WIDTH);
            make.width.mas_equalTo(12*WIDTH);
            make.height.mas_equalTo(70*HEIGHT);
            make.centerY.mas_equalTo(self.rightIMG);
        }];
    }else if (self.tag == 1001)
    {
        self.leftIMG.image = [UIImage imageNamed:@"hongbao-hui.png"];
        self.title.textColor = LYColor_A4;
        [self.rightIMG addSubview:self.shiyongGuoqiIMG];
        [self.shiyongGuoqiIMG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10*HEIGHT);
            make.right.mas_equalTo(-10*WIDTH);
            make.size.mas_equalTo(CGSizeMake(70*WIDTH, 65*HEIGHT));
        }];
        self.shiyongGuoqiIMG.image = [UIImage imageNamed:@"hongbao-yishiyong.png"];
        [self.rightIMG bringSubviewToFront:self.shiyongGuoqiIMG];
    }else if (self.tag == 1002){
        self.leftIMG.image = [UIImage imageNamed:@"hongbao-hui.png"];
        self.title.textColor = LYColor_A4;
        [self.rightIMG addSubview:self.shiyongGuoqiIMG];
        [self.shiyongGuoqiIMG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10*HEIGHT);
            make.right.mas_equalTo(-10*WIDTH);
            make.size.mas_equalTo(CGSizeMake(70*WIDTH, 65*HEIGHT));
        }];
        self.shiyongGuoqiIMG.image = [UIImage imageNamed:@"hongbao-yiguoqi.png"];;
        [self.rightIMG bringSubviewToFront:self.shiyongGuoqiIMG];
    }
}

- (void)setHongBaoModel:(HongBaoModel *)hongBaoModel{
    NSString *year = [hongBaoModel.effTime substringToIndex:4];
    NSString *month = [hongBaoModel.effTime substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [hongBaoModel.effTime substringWithRange:NSMakeRange(8, 2)];
    NSString *year1 = [hongBaoModel.expTime substringToIndex:4];
    NSString *month1 = [hongBaoModel.expTime substringWithRange:NSMakeRange(5, 2)];
    NSString *day1 = [hongBaoModel.expTime substringWithRange:NSMakeRange(8, 2)];
    NSString *eff = [NSString stringWithFormat:@"%@/%@/%@",year,month,day];
    NSString *exp = [NSString stringWithFormat:@"%@/%@/%@",year1,month1,day1];
    self.title.text = hongBaoModel.couponName;
    self.date.text = [NSString stringWithFormat:@"有效期：%@~%@",eff,exp];
    self.context.text = hongBaoModel.couponDesc;
    self.money.text = [NSString stringWithFormat:@"¥%.0f",[hongBaoModel.couponValue floatValue]/100];;
    self.tiaojian.text = [NSString stringWithFormat:@"满%.0f可用",[hongBaoModel.offUpto floatValue]/100];
}

/**********懒加载 *********/

- (UIImageView *)leftIMG{
    if (!_leftIMG) {
        _leftIMG = [[UIImageView alloc]init];
    }
    return _leftIMG;
}
- (UIImageView *)rightIMG{
    if (!_rightIMG) {
        _rightIMG = [[UIImageView alloc]init];
    }
    return _rightIMG;
}
- (UILabel *)money{
    if (!_money) {
        _money = [[UILabel alloc]init];
        _money.textColor = [UIColor whiteColor];
        _money.font = [UIFont systemFontOfSize:30.0f*HEIGHT];
        _money.textAlignment = NSTextAlignmentCenter;
    }
    return _money;
}
- (UILabel *)tiaojian{
    if (!_tiaojian) {
        _tiaojian = [[UILabel alloc]init];
        _tiaojian.textColor = [UIColor whiteColor];
        _tiaojian.font = [UIFont systemFontOfSize:11.0f*HEIGHT];
        _tiaojian.textAlignment = NSTextAlignmentCenter;
    }
    return _tiaojian;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = LYColor_A3;
        _title.font = [UIFont systemFontOfSize:18.0f*HEIGHT];
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}
- (UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.textColor = LYColor_A4;
        _date.font = [UIFont systemFontOfSize:11.0f*HEIGHT];
        _date.textAlignment = NSTextAlignmentLeft;
    }
    return _date;
}
- (UILabel *)context{
    if (!_context) {
        _context = [[UILabel alloc]init];
        _context.textColor = LYColor_A4;
        _context.font = [UIFont systemFontOfSize:11.0f*HEIGHT];
        _context.textAlignment = NSTextAlignmentLeft;
    }
    return _context;
}
- (UIImageView *)lastDayIMG{
    if (!_lastDayIMG) {
        _lastDayIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hongbao-shengyitian@2x.png"]];
        _lastDayIMG.contentMode = UIViewContentModeScaleAspectFit;
        _lastDayIMG.hidden = YES;
    }
    return _lastDayIMG;
}
- (UIImageView *)lineIMG{
    if (!_lineIMG) {
        _lineIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hongbao-xuxian.png"]];
        _lineIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _lineIMG;
}
- (UILabel *)shiyong{
    if (!_shiyong) {
        _shiyong = [[UILabel alloc]init];
        _shiyong.text = @"立即使用";
        _shiyong.textColor = LYColor_A2;
        _shiyong.font = [UIFont systemFontOfSize:12.0f*HEIGHT];
        _shiyong.numberOfLines = 0;
    }
    return _shiyong;
}
- (UIImageView *)shiyongGuoqiIMG{
    if (!_shiyongGuoqiIMG) {
        _shiyongGuoqiIMG = [[UIImageView alloc]init];
        _shiyongGuoqiIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _shiyongGuoqiIMG;
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
