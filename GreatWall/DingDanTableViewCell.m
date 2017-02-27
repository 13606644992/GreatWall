//
//  DingDanTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/1/18.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DingDanTableViewCell.h"
#import "Header.h"
@implementation DingDanTableViewCell

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
        make.height.mas_equalTo(219*HEIGHT);
    }];
    [background layoutIfNeeded];
    //   圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:background.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = background.bounds;
    maskLayer.path = maskPath.CGPath;
    background.layer.mask = maskLayer;
    
    [background addSubview:self.dateAndTime];
    [background addSubview:self.logoIMG];
    [background addSubview:self.dingdanjine];
    [background addSubview:self.dingdanhao];
    [background addSubview:self.chepaihao];
    [background addSubview:self.beibaoren];
    [background addSubview:self.jiaoqiangxian];
    [background addSubview:self.shangyexian];
    [background addSubview:self.zhifuBtn];
    [background addSubview:self.tuikuangfei];
    
    [self.dateAndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 12*HEIGHT));
        make.top.mas_equalTo(38*HEIGHT);
        make.left.mas_equalTo(26*WIDTH);
    }];
    [self.zhifuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30*HEIGHT);
        make.right.mas_equalTo(-26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(74*WIDTH, 24*HEIGHT));
    }];
    [self.logoIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zhifuBtn.mas_bottom).with.offset(21*HEIGHT);
        make.left.mas_equalTo(26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 60*WIDTH));
    }];
    [self.dingdanhao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoIMG.mas_right).with.offset(18*WIDTH);
        make.top.mas_equalTo(self.logoIMG);
        make.size.mas_equalTo(CGSizeMake(230*WIDTH, 11*HEIGHT));
    }];
    [self.chepaihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dingdanhao);
        make.top.mas_equalTo(self.dingdanhao.mas_bottom).with.offset(7*HEIGHT);
        make.size.mas_equalTo(self.dingdanhao);
    }];
    [self.beibaoren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dingdanhao);
        make.top.mas_equalTo(self.chepaihao.mas_bottom).with.offset(7*HEIGHT);
        make.size.mas_equalTo(self.dingdanhao);
    }];
    [self.jiaoqiangxian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dingdanhao);
        make.top.mas_equalTo(self.beibaoren.mas_bottom).with.offset(7*HEIGHT);
        make.size.mas_equalTo(self.dingdanhao);
    }];
    [self.shangyexian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dingdanhao);
        make.top.mas_equalTo(self.jiaoqiangxian.mas_bottom).with.offset(7*HEIGHT);
        make.size.mas_equalTo(self.dingdanhao);
    }];
    [self.dingdanjine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shangyexian.mas_bottom).with.offset(21*HEIGHT);
        make.left.mas_equalTo(self.logoIMG);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 12*HEIGHT));
    }];
    [self.tuikuangfei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dingdanjine);
        make.right.mas_equalTo(-26*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 12*HEIGHT));
    }];
    
    
    
    
    
    
    
    self.dateAndTime.text = @"2016-12-31  13:44:09";
    self.dingdanhao.text = @"订单号：2349870991838408";
    self.chepaihao.text = @"车牌号：浙A66666";
    self.beibaoren.text = @"被保人：宋小宝";
    self.jiaoqiangxian.text = @"交强险起期：2016-12-10至2017-12-09";
    self.shangyexian.text = @"商业险起期：2016-12-10至2017-12-09";
    self.logoIMG.image = [UIImage imageNamed:@"baodan-gongsilogo.png"];
    self.dingdanjine.text = @"订单金额：6783.98元";
    self.tuikuangfei.text = @"推广费：670.00元";
    

    [_zhifuBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [_zhifuBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    _zhifuBtn.layer.borderColor = LYColor_A1.CGColor;
    if (self.tag == 1001) {
        [_zhifuBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_zhifuBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        _zhifuBtn.layer.borderColor = LYColor_A1.CGColor;
    }
    if (self.tag == 1002) {
        [_zhifuBtn setTitle:@"已完成" forState:UIControlStateNormal];
        [_zhifuBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
        _zhifuBtn.layer.borderColor = LYColor_A6.CGColor;
        _zhifuBtn.userInteractionEnabled = NO;
    }
    
}

/*****************************************懒加载**************************************************/
- (UILabel *)dateAndTime{
    if (!_dateAndTime) {
        _dateAndTime = [[UILabel alloc]init];
        _dateAndTime.font = [UIFont systemFontOfSize:12*HEIGHT];
        _dateAndTime.textColor = LYColor_A3;
    }
    return _dateAndTime;
}
- (UILabel *)dingdanhao{
    if (!_dingdanhao) {
        _dingdanhao = [[UILabel alloc]init];
        _dingdanhao.font = [UIFont systemFontOfSize:11*HEIGHT];
        _dingdanhao.textColor = LYColor_A4;
    }
    return _dingdanhao;
}
- (UILabel *)chepaihao{
    if (!_chepaihao) {
        _chepaihao = [[UILabel alloc]init];
        _chepaihao.font = [UIFont systemFontOfSize:11*HEIGHT];
        _chepaihao.textColor = LYColor_A4;
    }
    return _chepaihao;
}
- (UILabel *)beibaoren{
    if (!_beibaoren) {
        _beibaoren = [[UILabel alloc]init];
        _beibaoren.font = [UIFont systemFontOfSize:11*HEIGHT];
        _beibaoren.textColor = LYColor_A4;
    }
    return _beibaoren;
}
- (UILabel *)jiaoqiangxian{
    if (!_jiaoqiangxian) {
        _jiaoqiangxian = [[UILabel alloc]init];
        _jiaoqiangxian.font = [UIFont systemFontOfSize:11*HEIGHT];
        _jiaoqiangxian.textColor = LYColor_A4;
    }
    return _jiaoqiangxian;
}
- (UILabel *)shangyexian{
    if (!_shangyexian) {
        _shangyexian = [[UILabel alloc]init];
        _shangyexian.font = [UIFont systemFontOfSize:11*HEIGHT];
        _shangyexian.textColor = LYColor_A4;
    }
    return _shangyexian;
}
- (UILabel *)dingdanjine{
    if (!_dingdanjine) {
        _dingdanjine = [[UILabel alloc]init];
        _dingdanjine.font = [UIFont systemFontOfSize:12*HEIGHT];
        _dingdanjine.textColor = LYColor_A3;
    }
    return _dingdanjine;
}
- (UILabel *)tuikuangfei{
    if (!_tuikuangfei) {
        _tuikuangfei = [[UILabel alloc]init];
        _tuikuangfei.font = [UIFont systemFontOfSize:12*HEIGHT];
        _tuikuangfei.textColor = LYColor_A3;
        _tuikuangfei.textAlignment = NSTextAlignmentRight;
    }
    return _tuikuangfei;
}
- (UIImageView *)logoIMG{
    if (!_logoIMG) {
        _logoIMG = [[UIImageView alloc]init];
        _logoIMG.contentMode = UIViewContentModeScaleAspectFit;
        _logoIMG.layer.cornerRadius = 2.0f;
        _logoIMG.layer.borderWidth = 1.0f;
        _logoIMG.layer.borderColor = LYColor_A4.CGColor;
    }
    return _logoIMG;
}
- (UIButton *)zhifuBtn{
    if (!_zhifuBtn) {
        _zhifuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _zhifuBtn.layer.borderColor = LYColor_A1.CGColor;
        _zhifuBtn.layer.cornerRadius = 2.0f;
        _zhifuBtn.layer.borderWidth = 1.0f;
        _zhifuBtn.titleLabel.font = [UIFont systemFontOfSize:11*HEIGHT];

        
    }
    return _zhifuBtn;
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
