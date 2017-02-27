//
//  UserTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2016/12/30.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "UserTableViewCell.h"
#import "Header.h"
@implementation UserTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubview];
    }
    return self;
}
- (void)creatSubview{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.frame];
    self.selectedBackgroundView.backgroundColor = LYColor_A7;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconIMGView];
    self.iconIMGView.backgroundColor = [UIColor whiteColor];
    [self.iconIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(22*WIDTH, 22*WIDTH));
    }];
    self.iconIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconIMGView.mas_right).with.offset(18*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake( 60*WIDTH, 15*HEIGHT));
    }];
    self.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    self.titleLabel.textColor = LYColor_A3;
    
    UIImageView *jiantouIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    [self.contentView addSubview:jiantouIMGView];
    [jiantouIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(5.5*WIDTH, 9.5*HEIGHT));
    }];
    jiantouIMGView.backgroundColor = [UIColor whiteColor];
    jiantouIMGView.contentMode = UIViewContentModeScaleAspectFit;

}
- (void)setImgeWith:(UIImage *)image AndTitle:(NSString *)string{
    self.iconIMGView.image = image;
    self.titleLabel.text = string;
    
}
- (void)addYaoqingAnKefu{
    if (self.tag == 3) {
        [self.contentView addSubview:self.yaoqing];
        self.yaoqing.backgroundColor = [UIColor whiteColor];
        self.yaoqing.text = @"增员开单，你来收益";
        self.yaoqing.textColor = LYColor_A4;
        self.yaoqing.font = [UIFont systemFontOfSize:14*HEIGHT];
        self.yaoqing.textAlignment = NSTextAlignmentRight;
        [self.yaoqing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-35);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(200*WIDTH, HEIGHT * 15));
        }];
    }else if (self.tag == 4){
        [self.contentView addSubview:self.kefu];
        self.kefu.backgroundColor = [UIColor whiteColor];
        self.kefu.text = @"为您服务";
        self.kefu.textColor = LYColor_A4;
        self.kefu.font = [UIFont systemFontOfSize:14*HEIGHT];
        self.kefu.textAlignment = NSTextAlignmentRight;
        [self.kefu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-35);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, HEIGHT * 15));
        }];
    }
}
/*            lazyLoading...... .          */
- (UILabel *)yaoqing{
    if (!_yaoqing) {
        _yaoqing = [[UILabel alloc]init];
    }
    return _yaoqing;
}
- (UILabel *)kefu{
    if (!_kefu) {
        _kefu = [[UILabel alloc]init];
    }
    return _kefu;
}
- (UIImageView *)iconIMGView{
    if (!_iconIMGView) {
        _iconIMGView = [[UIImageView alloc]init];
    }
    return _iconIMGView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
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
