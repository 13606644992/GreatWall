//
//  CheXianTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CheXianTableViewCell.h"
#import "Header.h"
#import "BaoDanModel.h"
@implementation CheXianTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:  reuseIdentifier];
    
    return self;
}

- (void)creatSubView{
//    self.contentView.backgroundColor = LYColor_A7;
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    UIView *background = [[UIView alloc]init];
//    background.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:background];
//    [background mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.centerX.mas_equalTo(self.contentView);
//        make.width.mas_equalTo(339*WIDTH);
//        make.height.mas_equalTo(219*HEIGHT);
//    }];
//    [background layoutIfNeeded];
//    //   圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:background.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = background.bounds;
//    maskLayer.path = maskPath.CGPath;
//    background.layer.mask = maskLayer;
//    
//    [background addSubview:self.dateAndTime];
//    [background addSubview:self.logoIMG];
//    [background addSubview:self.dingdanjine];
//    [background addSubview:self.dingdanhao];
//    [background addSubview:self.chepaihao];
//    [background addSubview:self.beibaoren];
//    [background addSubview:self.jiaoqiangxian];
//    [background addSubview:self.shangyexian];
//    [background addSubview:self.tuikuangfei];
//    [background addSubview:self.stateIMG];
//    [self.dateAndTime mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 12*HEIGHT));
//        make.top.mas_equalTo(38*HEIGHT);
//        make.left.mas_equalTo(26*WIDTH);
//    }];
//
//    [self.logoIMG mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(75*HEIGHT);
//        make.left.mas_equalTo(26*WIDTH);
//        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 60*WIDTH));
//    }];
//    [self.dingdanhao mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.logoIMG.mas_right).with.offset(18*WIDTH);
//        make.top.mas_equalTo(self.logoIMG);
//        make.size.mas_equalTo(CGSizeMake(230*WIDTH, 11*HEIGHT));
//    }];
//    [self.chepaihao mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.dingdanhao);
//        make.top.mas_equalTo(self.dingdanhao.mas_bottom).with.offset(7*HEIGHT);
//        make.size.mas_equalTo(self.dingdanhao);
//    }];
//    [self.beibaoren mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.dingdanhao);
//        make.top.mas_equalTo(self.chepaihao.mas_bottom).with.offset(7*HEIGHT);
//        make.size.mas_equalTo(self.dingdanhao);
//    }];
//    [self.jiaoqiangxian mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.dingdanhao);
//        make.top.mas_equalTo(self.beibaoren.mas_bottom).with.offset(7*HEIGHT);
//        make.size.mas_equalTo(self.dingdanhao);
//    }];
//    [self.shangyexian mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.dingdanhao);
//        make.top.mas_equalTo(self.jiaoqiangxian.mas_bottom).with.offset(7*HEIGHT);
//        make.size.mas_equalTo(self.dingdanhao);
//    }];
//    [self.dingdanjine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.shangyexian.mas_bottom).with.offset(21*HEIGHT);
//        make.left.mas_equalTo(self.logoIMG);
//        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 12*HEIGHT));
//    }];
//    [self.tuikuangfei mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.dingdanjine);
//        make.right.mas_equalTo(-26*WIDTH);
//        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 12*HEIGHT));
//    }];
    
    
    
    
    self.contentView.backgroundColor = LYColor_A7;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.dateAndTime];
    [self.dateAndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*WIDTH, 12*HEIGHT));
        make.top.mas_equalTo(18*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
    }];
    
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43*HEIGHT);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(375*WIDTH);
        make.height.mas_equalTo(238*HEIGHT);
    }];
    [background layoutIfNeeded];
    //   圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:background.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = background.bounds;
    maskLayer.path = maskPath.CGPath;
    background.layer.mask = maskLayer;
    
    [background addSubview:self.logoIMG];
    [background addSubview:self.dingdanjine];
    [background addSubview:self.dingdanhao];
    [background addSubview:self.chepaihao];
    [background addSubview:self.beibaoren];
    [background addSubview:self.jiaoqiangxian];
    [background addSubview:self.shangyexian];
    [background addSubview:self.stateIMG];
    [background addSubview:self.tuikuangfei];
    [background addSubview:self.line];
    
    [self.chepaihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(24*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(180, 19*HEIGHT));
    }];
    
//    [self.zhifuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.top.mas_equalTo(30*HEIGHT);
//        make.right.mas_equalTo(-18*WIDTH);
//        make.centerY.mas_equalTo(self.chepaihao);
//        make.size.mas_equalTo(CGSizeMake(74*WIDTH, 24*HEIGHT));
//    }];
    [self.logoIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chepaihao.mas_bottom).with.offset(18*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.height.mas_equalTo(24*HEIGHT);
        //        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 60*WIDTH));
    }];
    self.logoIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.dingdanhao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(self.logoIMG.mas_bottom).offset(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(background.frame.size.width - 18*2*WIDTH, 13*HEIGHT));
    }];
    
    [self.beibaoren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dingdanhao);
        make.top.mas_equalTo(self.dingdanhao.mas_bottom).with.offset(7*HEIGHT);
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
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shangyexian.mas_bottom).offset(24*HEIGHT);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.dingdanjine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.line).offset(19*HEIGHT);
        make.left.mas_equalTo(self.logoIMG);
        make.size.mas_equalTo(CGSizeMake(160*WIDTH, 15*HEIGHT));
    }];
    [self.tuikuangfei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dingdanjine);
        make.right.mas_equalTo(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(160*WIDTH, 15*HEIGHT));
    }];
    [self.stateIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-21*WIDTH);
        make.size.mas_equalTo(CGSizeMake(62*WIDTH, 52*HEIGHT));
    }];
    
    
    
//    self.dateAndTime.text = @"2016-12-31  13:44:09";
//    self.dingdanhao.text = @"订单号：2349870991838408";
//    self.chepaihao.text = @"车牌号：浙A66666";
//    self.beibaoren.text = @"被保人：宋小宝";
//    self.jiaoqiangxian.text = @"交强险起期：2016-12-10至2017-12-09";
//    self.shangyexian.text = @"商业险起期：2016-12-10至2017-12-09";
//    self.logoIMG.image = [UIImage imageNamed:@"baodan-gongsilogo.png"];
//    self.dingdanjine.text = @"订单金额：6783.98元";
//    self.tuikuangfei.text = @"推广费：670.00元";
//    self.stateIMG.image = [UIImage imageNamed:@"baozhangzhong.png"];
    
}

- (void)setBaoDanModel:(BaoDanModel *)baoDanModel{
    //    _dingDanModel = dingDanModel;
    self.dateAndTime.text = baoDanModel.tradeDate;
    [self.logoIMG sd_setImageWithURL:[NSURL URLWithString:baoDanModel.insurerLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
    self.dingdanhao.text = [NSString stringWithFormat:@"订单号：%@",baoDanModel.tradeId];;
    if (baoDanModel.insuredList.count>0) {
        BeiBaoXianRenModel *midel = baoDanModel.insuredList[0];
        self.chepaihao.text = [NSString stringWithFormat:@"车牌号：%@", midel.licenseNo];
        self.beibaoren.text = [NSString stringWithFormat:@"被保人：%@",midel.insuredName];
        
    }
    self.jiaoqiangxian.text = [NSString stringWithFormat:@"交强险起期：%@至%@",baoDanModel.jqxStartTime,baoDanModel.jqxEndTime];
    self.shangyexian.text = [NSString stringWithFormat:@"商业险起期：%@至%@",baoDanModel.startTime,baoDanModel.endTime];
    //订单金额
    //需要改变的第一个文字的位置
    NSString *str1 = @"订单金额：";
    NSInteger length1 = [str1 length];
    //需要改变的最后一个文字的位置
    NSString *payStr = [NSString stringWithFormat:@"%@", baoDanModel.payAmount];
    NSInteger length2 = [payStr length];
    NSString *str2 = [NSString stringWithFormat:@"%@%@ 元",str1,payStr];
    NSRange range = NSMakeRange(length1, length2);
    NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc] initWithString:str2];
    [textStr addAttribute:NSForegroundColorAttributeName value:LYColor_A2 range:range];
    [textStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*HEIGHT] range:range];
    [self.dingdanjine setAttributedText:textStr];
//    //推广费
//    NSString *string1 = @"推广费：";
//    NSInteger tuiGuangLength1 = [string1 length];
//    NSString *tuiGuangString = [NSString stringWithFormat:@"%@",baoDanModel.commisionValue1];
//    NSInteger tuiGuangLength2 = [tuiGuangString length];
//    NSString *string2 = [NSString stringWithFormat:@"%@%@ 元",string1,tuiGuangString];
//    NSRange tuiGuangRange = NSMakeRange(tuiGuangLength1, tuiGuangLength2);
//    NSMutableAttributedString *tuiGuang = [[NSMutableAttributedString alloc] initWithString:string2];
//    [tuiGuang addAttribute:NSForegroundColorAttributeName value:LYColor_A2 range:tuiGuangRange];
//    [tuiGuang addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*HEIGHT] range:tuiGuangRange];
//    [self.tuikuangfei setAttributedText:tuiGuang];
    //    self.tuikuangfei.text = [NSString stringWithFormat:@"推广费：%@元",dingDanModel.commisionValue1];
    if ([baoDanModel.sts isEqualToString:@"10"]) {
        self.stateIMG.image = [UIImage imageNamed:@"baodan-daichudan"];
    }else if ([baoDanModel.sts isEqualToString:@"20"]){
        self.stateIMG.image = [UIImage imageNamed:@"baodan-baozhangzhong"];
    }else if ([baoDanModel.sts isEqualToString:@"40"]){
        self.stateIMG.image = [UIImage imageNamed:@"baodan-yiguoqi"];
    }
}


/*****************************************懒加载**************************************************/
- (UILabel *)dateAndTime{
    if (!_dateAndTime) {
        _dateAndTime = [[UILabel alloc]init];
        _dateAndTime.font = [UIFont systemFontOfSize:12*HEIGHT];
        _dateAndTime.textColor = LYColor_A4;
    }
    return _dateAndTime;
}
- (UILabel *)dingdanhao{
    if (!_dingdanhao) {
        _dingdanhao = [[UILabel alloc]init];
        _dingdanhao.font = [UIFont systemFontOfSize:12*HEIGHT];
        _dingdanhao.textColor = LYColor_A3;
    }
    return _dingdanhao;
}
- (UILabel *)chepaihao{
    if (!_chepaihao) {
        _chepaihao = [[UILabel alloc]init];
        _chepaihao.font = [UIFont systemFontOfSize:18*HEIGHT];
        _chepaihao.textColor = LYColor_A3;
        _chepaihao.textAlignment = NSTextAlignmentLeft;
    }
    return _chepaihao;
}
- (UILabel *)beibaoren{
    if (!_beibaoren) {
        _beibaoren = [[UILabel alloc]init];
        _beibaoren.font = [UIFont systemFontOfSize:12*HEIGHT];
        _beibaoren.textAlignment = NSTextAlignmentLeft;
        _beibaoren.textColor = LYColor_A3;
    }
    return _beibaoren;
}
- (UILabel *)jiaoqiangxian{
    if (!_jiaoqiangxian) {
        _jiaoqiangxian = [[UILabel alloc]init];
        _jiaoqiangxian.font = [UIFont systemFontOfSize:12*HEIGHT];
        _jiaoqiangxian.textColor = LYColor_A3;
    }
    return _jiaoqiangxian;
}
- (UILabel *)shangyexian{
    if (!_shangyexian) {
        _shangyexian = [[UILabel alloc]init];
        _shangyexian.font = [UIFont systemFontOfSize:11*HEIGHT];
        _shangyexian.textColor = LYColor_A3;
    }
    return _shangyexian;
}
- (UILabel *)dingdanjine{
    if (!_dingdanjine) {
        _dingdanjine = [[UILabel alloc]init];
        _dingdanjine.font = [UIFont systemFontOfSize:12*HEIGHT];
        _dingdanjine.textColor = LYColor_A4;
    }
    return _dingdanjine;
}
- (UILabel *)tuikuangfei{
    if (!_tuikuangfei) {
        _tuikuangfei = [[UILabel alloc]init];
        _tuikuangfei.font = [UIFont systemFontOfSize:12*HEIGHT];
        _tuikuangfei.textColor = LYColor_A4;
        _tuikuangfei.textAlignment = NSTextAlignmentRight;
    }
    return _tuikuangfei;
}
- (UIImageView *)logoIMG{
    if (!_logoIMG) {
        _logoIMG = [[UIImageView alloc]init];
        _logoIMG.contentMode = UIViewContentModeScaleAspectFit;
        //        _logoIMG.layer.cornerRadius = 2.0f;
        //        _logoIMG.layer.borderWidth = 1.0f;
        //        _logoIMG.layer.borderColor = LYColor_A4.CGColor;
    }
    return _logoIMG;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = LYColor_A6;
    }
    return _line;
}

- (UIImageView *)stateIMG{
    if (!_stateIMG) {
        _stateIMG = [[UIImageView alloc]init];
        _stateIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _stateIMG;
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
