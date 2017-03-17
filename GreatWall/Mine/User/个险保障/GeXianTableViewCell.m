//
//  GeXianTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "GeXianTableViewCell.h"
#import "Header.h"
#import "BaoDanModel.h"
@implementation GeXianTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:  reuseIdentifier];
    
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
//    maskLayer.frame = background.bounds;
//    maskLayer.path = maskPath.CGPath;
//    background.layer.mask = maskLayer;

    [self.background addSubview:self.logoIMG];
    [self.background addSubview:self.title];
    [self.background addSubview:self.pinPaiImage];
    [self.background addSubview:self.baodanhao];
    [self.background addSubview:self.beibaoren];
    [self.background addSubview:self.toubaoren];
    [self.background addSubview:self.baoxianqijian];;
    [self.background addSubview:self.dingdanjine];
    [self.background addSubview:self.line];
    [self.background addSubview:self.tuikuangfei];
    [self.logoIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(62*WIDTH, 52*HEIGHT));
    }];
    self.title.numberOfLines = 2;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(24*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(225*WIDTH, 18*HEIGHT));
    }];
    [self.pinPaiImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).with.offset(18*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.height.mas_equalTo(24*HEIGHT);
        make.width.mas_equalTo(60*WIDTH);
    }];
    [self.baodanhao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.top.mas_equalTo(self.pinPaiImage.mas_bottom).with.offset(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 12*HEIGHT));
    }];

    [self.beibaoren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.top.mas_equalTo(self.baodanhao.mas_bottom).with.offset(7*HEIGHT);
        make.size.mas_equalTo(self.baodanhao);
    }];
    [self.toubaoren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.baodanhao);
        make.top.mas_equalTo(self.beibaoren.mas_bottom).with.offset(7*HEIGHT);
        make.size.mas_equalTo(self.baodanhao);
    }];
    [self.baoxianqijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.baodanhao);
        make.top.mas_equalTo(self.toubaoren.mas_bottom).with.offset(7*HEIGHT);
        make.size.mas_equalTo(self.baodanhao);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baoxianqijian.mas_bottom).offset(24*HEIGHT);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.dingdanjine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.line).offset(22*HEIGHT);
        make.left.mas_equalTo(self.title);
        make.size.mas_equalTo(CGSizeMake(160*WIDTH, 15*HEIGHT));
    }];
//    [self.tuikuangfei mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.dingdanjine);
//        make.right.mas_equalTo(-18*WIDTH);
//        make.size.mas_equalTo(CGSizeMake(160*WIDTH, 15*HEIGHT));
//    }];
//    self.title.text = @"个人借款保证保险大幅度发士大夫吾问无为谓的说法";
    //    self.baodanhao.text = @"保单号：2342304249525689";
//    self.pinPaiImage.image = [UIImage imageNamed:@"00"];
//    self.beibaoren.text = @"被保人：关键";
//    self.toubaoren.text = @"投保人：关键";
//    self.baoxianqijian.text = @"保险期间：2016-12-10至2017-12-09";
//    self.dingdanjine.text = @"订单金额：198.00元";
//    self.tuikuangfei.text = @"推广费：32.90元";
//    self.logoIMG.image = [UIImage imageNamed:@"baozhangzhong.png"];
    
}

-(CGFloat)getHeight{
    
    CGRect tempRect = [self.title.text  boundingRectWithSize:CGSizeMake(240*WEIGHT,45*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18*HEIGHT]}context:nil];
    NSLog(@"--------------------tempRect.size.height===%f",tempRect.size.height);
    CGFloat height = (43+24+18+24+18+12+7+12+7+12+7+12+24+16.5+12+17+tempRect.size.height)*HEIGHT;
    return height;
    
}

- (void)setBaoDanModel:(BaoDanModel *)baoDanModel{
    self.title.text = baoDanModel.productName;
//    self.title.text = @"阿萨是飞洒发发发发沙发沙发发发放松放松";
    [self.pinPaiImage sd_setImageWithURL:[NSURL URLWithString:baoDanModel.insurerLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
    self.baodanhao.text = [NSString stringWithFormat:@"订单号：%@",baoDanModel.policyId];
    self.toubaoren.text = [NSString stringWithFormat:@"投保人：%@",baoDanModel.applicant];
    self.baoxianqijian.text = [NSString stringWithFormat:@"保险期间：%@ ~ %@",baoDanModel.startTime,baoDanModel.endTime];
    self.dateAndTime.text = [NSString stringWithFormat:@"%@ 至 %@",baoDanModel.startTime,baoDanModel.endTime];
    //订单金额
    //需要改变的第一个文字的位置
    NSString *str1 = @"保单金额：";
    NSInteger length1 = [str1 length];
    //需要改变的最后一个文字的位置
    NSString *payStr = [NSString stringWithFormat:@"%@",baoDanModel.payAmount];
    NSInteger length2 = [payStr length];
    NSString *str2 = [NSString stringWithFormat:@"%@%@ 元",str1,payStr];
    NSRange range = NSMakeRange(length1, length2);
    NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc] initWithString:str2];
    [textStr addAttribute:NSForegroundColorAttributeName value:LYColor_A2 range:range];
    [textStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*HEIGHT] range:range];
    [self.dingdanjine setAttributedText:textStr];
    if (baoDanModel.insuredList.count > 0) {
        BeiBaoXianRenModel *beiBaorenModel = baoDanModel.insuredList[0];
        self.beibaoren.text = [NSString stringWithFormat:@"被保人：%@",beiBaorenModel.insuredName];
    }
    CGRect tempRect = [self.title.text  boundingRectWithSize:CGSizeMake(230*WEIGHT,45*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18*HEIGHT]}context:nil];
    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(225*WIDTH, (tempRect.size.height + 2)*HEIGHT));
    }];
    NSLog(@"tempRect.size.height==%f,self.title.text = %@",tempRect.size.height,self.title.text);
    [self.background mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((24+18+24+18+12+7+12+7+12+7+12+24+16.5+12+17+tempRect.size.height)*HEIGHT);
    }];
    if ([baoDanModel.sts isEqualToString:@"10"]) {
        self.logoIMG.image = [UIImage imageNamed:@"baodan-daichudan"];
    }else if ([baoDanModel.sts isEqualToString:@"20"]){
        self.logoIMG.image = [UIImage imageNamed:@"baodan-baozhangzhong"];
    }else if ([baoDanModel.sts isEqualToString:@"40"]){
        self.title.textColor = LYColor_A4;
        self.baodanhao.textColor = LYColor_A4;
        self.beibaoren.textColor = LYColor_A4;
        self.toubaoren.textColor = LYColor_A4;
        self.baoxianqijian.textColor = LYColor_A4;
        self.dingdanjine.textColor = LYColor_A4;
        self.logoIMG.image = [UIImage imageNamed:@"baodan-yiguoqi"];
    }

}
//*****************************************懒加载**************************************************/

- (UILabel *)dateAndTime{
    if (!_dateAndTime) {
        _dateAndTime = [[UILabel alloc]init];
        _dateAndTime.font = [UIFont systemFontOfSize:12*HEIGHT];
        _dateAndTime.textColor = LYColor_A4;
    }
    return _dateAndTime;
}

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
        _baoxianqijian.font = [UIFont systemFontOfSize:12.0f * HEIGHT];
    }
    return _baoxianqijian;
}
- (UILabel *)baodanhao{
    if (!_baodanhao) {
        _baodanhao = [[UILabel alloc]init];
        _baodanhao.textColor = LYColor_A5;
        _baodanhao.font = [UIFont systemFontOfSize:12.0f * HEIGHT];
    }
    return _baodanhao;
}
- (UILabel *)beibaoren{
    if (!_beibaoren) {
        _beibaoren = [[UILabel alloc]init];
        _beibaoren.textColor = LYColor_A5;
        _beibaoren.font = [UIFont systemFontOfSize:12.0f * HEIGHT];
    }
    return _beibaoren;
}
- (UILabel *)toubaoren{
    if (!_toubaoren) {
        _toubaoren = [[UILabel alloc]init];
        _toubaoren.textColor = LYColor_A5;
        _toubaoren.font = [UIFont systemFontOfSize:12.0f * HEIGHT];
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

- (UIImageView *)pinPaiImage{
    if (!_pinPaiImage) {
        _pinPaiImage = [[UIImageView alloc]init];
        _pinPaiImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _pinPaiImage;
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
