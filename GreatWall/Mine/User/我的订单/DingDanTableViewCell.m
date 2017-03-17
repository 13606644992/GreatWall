//
//  DingDanTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/1/18.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DingDanTableViewCell.h"
#import "Header.h"
#import "DingDanModel.h"
@implementation DingDanTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:  reuseIdentifier];
    if (self) {
        [self creatSubView];
    }

    return self;
}

- (void)creatSubView{
    self.contentView.backgroundColor = LYColor_A7;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.dateAndTime];
    [self.dateAndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*WIDTH, 12*HEIGHT));
        make.top.mas_equalTo(18*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
    }];
    
    self.background = [[UIView alloc]init];
    self.background.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.background];
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43*HEIGHT);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(375*WIDTH);
        make.height.mas_equalTo(238*HEIGHT);
    }];
    [self.background layoutIfNeeded];
    //   圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:background.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.background.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.background.layer.mask = maskLayer;
    
    [self.background addSubview:self.logoIMG];
    [self.background addSubview:self.dingdanjine];
    [self.background addSubview:self.dingdanhao];
    [self.background addSubview:self.chepaihao];
    [self.background addSubview:self.beibaoren];
    [self.background addSubview:self.jiaoqiangxian];
    [self.background addSubview:self.shangyexian];
    [self.background addSubview:self.zhifuBtn];
    [self.background addSubview:self.tuikuangfei];
    [self.background addSubview:self.line];
    
    [self.chepaihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(24*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(225*WIDTH, 18*HEIGHT));
    }];
    
    [self.zhifuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(30*HEIGHT);
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(self.chepaihao);
        make.size.mas_equalTo(CGSizeMake(74*WIDTH, 24*HEIGHT));
    }];
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
        make.size.mas_equalTo(CGSizeMake(300*WIDTH, 12*HEIGHT));
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
    
    
    
    
    
    
    
//    self.dateAndTime.text = @"2016-12-31  13:44:09";
//    self.dingdanhao.text = @"订单号：2349870991838408";
//    self.chepaihao.text = @"车牌号：浙A66666";
//    self.beibaoren.text = @"被保人：宋小宝";
//    self.jiaoqiangxian.text = @"交强险起期：2016-12-10至2017-12-09";
//    self.shangyexian.text = @"商业险起期：2016-12-10至2017-12-09";
//    self.logoIMG.image = [UIImage imageNamed:@"baodan-gongsilogo.png"];
//    self.dingdanjine.text = @"订单金额：6783.98元";
//    self.tuikuangfei.text = @"推广费：670.00元";
//    
//
//    [_zhifuBtn setTitle:@"去支付" forState:UIControlStateNormal];
//    [_zhifuBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
//    _zhifuBtn.layer.borderColor = LYColor_A1.CGColor;
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

-(CGFloat)getHeight{
    
    CGRect tempRect = [self.chepaihao.text  boundingRectWithSize:CGSizeMake(240*WEIGHT,45*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18*HEIGHT]}context:nil];
    NSLog(@"--------------------tempRect.size.height===%f",tempRect.size.height);
    CGFloat height = (43+24+18+24+18+12+7+12+7+12+7+12+24+16.5+12+17+tempRect.size.height)*HEIGHT;
    return height;
    
}


- (void)setDingDanModel:(DingDanModel *)dingDanModel{
//    _dingDanModel = dingDanModel;
    self.dateAndTime.text = dingDanModel.tradeDate;
    [self.logoIMG sd_setImageWithURL:[NSURL URLWithString:dingDanModel.insurerLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
    self.dingdanhao.text = [NSString stringWithFormat:@"订单号：%@",dingDanModel.tradeId];
    //车险
    if ([[NSString stringWithFormat:@"%@",dingDanModel.classType] isEqualToString:@"1"]) {
        if (dingDanModel.insuredList.count>0) {
            BeiBaoRenModel *midel = dingDanModel.insuredList[0];
            self.chepaihao.text = [NSString stringWithFormat:@"%@", midel.licenseNo];
            self.beibaoren.text = [NSString stringWithFormat:@"被保人：%@",midel.insuredName];
        }
    }//个险
    else if ([[NSString stringWithFormat:@"%@",dingDanModel.classType] isEqualToString:@"2"]){
        self.chepaihao.text = [NSString stringWithFormat:@"%@", dingDanModel.productName];
        if (dingDanModel.insuredList.count>0) {
            BeiBaoRenModel *midel = dingDanModel.insuredList[0];
            self.beibaoren.text = [NSString stringWithFormat:@"被保人：%@",midel.insuredName];
        }
    }
    
    self.jiaoqiangxian.text = [NSString stringWithFormat:@"交强险起期：%@至%@",dingDanModel.jqxStartTime,dingDanModel.jqxEndTime];
    self.shangyexian.text = [NSString stringWithFormat:@"商业险起期：%@至%@",dingDanModel.startTime,dingDanModel.endTime];
    //订单金额
    //需要改变的第一个文字的位置
    NSString *str1 = @"订单金额：";
    NSInteger length1 = [str1 length];
    //需要改变的最后一个文字的位置
    NSString *payStr = dingDanModel.payAmount;
    NSInteger length2 = [payStr length];
    NSString *str2 = [NSString stringWithFormat:@"%@%@ 元",str1,payStr];
    NSRange range = NSMakeRange(length1, length2);
    NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc] initWithString:str2];
    [textStr addAttribute:NSForegroundColorAttributeName value:LYColor_A2 range:range];
    [textStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*HEIGHT] range:range];
    [self.dingdanjine setAttributedText:textStr];
    //推广费
    NSString *string1 = @"推广费：";
    NSInteger tuiGuangLength1 = [string1 length];
    NSString *tuiGuangString = [NSString stringWithFormat:@"%@",dingDanModel.commisionValue1];
    NSInteger tuiGuangLength2 = [tuiGuangString length];
    NSString *string2 = [NSString stringWithFormat:@"%@%@ 元",string1,tuiGuangString];
    NSRange tuiGuangRange = NSMakeRange(tuiGuangLength1, tuiGuangLength2);
    NSMutableAttributedString *tuiGuang = [[NSMutableAttributedString alloc] initWithString:string2];
    [tuiGuang addAttribute:NSForegroundColorAttributeName value:LYColor_A2 range:tuiGuangRange];
    [tuiGuang addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*HEIGHT] range:tuiGuangRange];
    [self.tuikuangfei setAttributedText:tuiGuang];
//    self.tuikuangfei.text = [NSString stringWithFormat:@"推广费：%@元",dingDanModel.commisionValue1];
    if ([dingDanModel.sts isEqualToString:@"10"]) {
        [self.zhifuBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [self.zhifuBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        self.zhifuBtn.layer.borderColor = LYColor_A1.CGColor;
        self.zhifuBtn.layer.cornerRadius = 2.0f;
        self.zhifuBtn.layer.borderWidth = 1.0f;
        self.zhifuBtn.userInteractionEnabled = YES;
    }else{
        [self.zhifuBtn setTitle:@"已完成" forState:UIControlStateNormal];
        [_zhifuBtn setTitleColor:LYColor_A5 forState:UIControlStateNormal];
        _zhifuBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _zhifuBtn.layer.cornerRadius = 0;
        _zhifuBtn.layer.borderWidth = 0;
        self.zhifuBtn.layer.borderColor = LYColor_A6.CGColor;
        self.zhifuBtn.userInteractionEnabled = NO;
    }
    CGRect tempRect = [self.chepaihao.text  boundingRectWithSize:CGSizeMake(230*WEIGHT,45*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18*HEIGHT]}context:nil];
    [self.chepaihao mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(225*WIDTH, (tempRect.size.height + 2)*HEIGHT));
    }];
    NSLog(@"tempRect.size.height==%f,self.chepaihao.text = %@",tempRect.size.height,self.chepaihao.text);
    [self.background mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((24+18+24+18+12+7+12+7+12+7+12+24+16.5+12+17+tempRect.size.height)*HEIGHT);
    }];

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
        _chepaihao.numberOfLines = 2;
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
- (UIButton *)zhifuBtn{
    if (!_zhifuBtn) {
        _zhifuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _zhifuBtn.layer.borderColor = LYColor_A1.CGColor;
        _zhifuBtn.layer.cornerRadius = 2.0f;
        _zhifuBtn.layer.borderWidth = 1.0f;
        _zhifuBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];

    }
    return _zhifuBtn;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = LYColor_A6;
    }
    return _line;
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
