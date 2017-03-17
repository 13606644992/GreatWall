//
//  MessageCenterCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/14.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "MessageCenterCell.h"

@implementation MessageCenterCell
+ (instancetype)cellWithMessageCenterView:(UITableView *)tableView{
    static NSString *ID = @"MessageCenterCell";
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell setTheMessageCenterView];
    }
    return cell;
}
-(void)setTheMessageCenterView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.selectImg];
    [self.selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(@(21*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(11*WIDTH, 11*WIDTH));
    }];
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectImg.mas_right).with.offset(11*WIDTH);
        make.top.equalTo(self.selectImg);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(16*HEIGHT));
    }];
    [self.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(11*HEIGHT);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(12*HEIGHT));
    }];
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(11*HEIGHT);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(12*HEIGHT));
    }];
    
}


-(void)setModel:(MessageModel *)model{
    if (model) {
        self.selectImg.hidden = YES;
        if ([[NSString stringWithFormat:@"%@",model.sts] isEqualToString:@"1"]) {
            self.selectImg.hidden = NO;
        }
        self.titleLab.text = model.msgTitle;
        
        CGRect tempRect = [model.msgContent  boundingRectWithSize:CGSizeMake(310*WIDTH,50*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12*HEIGHT]}context:nil];
        self.desLab.text = model.msgContent;
        [self.desLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(tempRect.size.height+2));
        }];
        self.timeLab.text = model.msgTime;
    }
}
-(CGFloat)getHeights{
    
    
    CGRect tempRect = [self.desLab.text  boundingRectWithSize:CGSizeMake(310*WIDTH,50*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12*HEIGHT]}context:nil];
    NSLog(@"---%f",tempRect.size.height);
    return (21+16+11+11+12+21)*WIDTH+tempRect.size.height+2;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

#pragma mark   -------------Controller-----
-(UIImageView *)selectImg
{
    if (!_selectImg) {
        _selectImg = [[UIImageView alloc] init];
        _selectImg.backgroundColor = LYColor_A1;
        _selectImg.layer.cornerRadius = 5.5f*WIDTH;
        _selectImg.clipsToBounds = YES;
    }
    return _selectImg;
}

-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16*WEIGHT];
        _titleLab.textColor = LYColor_A3;
        _titleLab.text = @"红包奖励";
    }
    return _titleLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab =[[UILabel alloc] init];
        _desLab.font = [UIFont systemFontOfSize:12*WEIGHT];
        _desLab.textColor = LYColor_A3;
        _desLab.numberOfLines = 0;
        _desLab.text = @"恭喜您获得新手红包，有效期30天，请尽快使用";
    }
    return _desLab;
}
-(UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.text = @"2016-12-29 14:25:00";
        _timeLab.textColor = LYColor_A4;
        _timeLab.font = [UIFont systemFontOfSize:12*WEIGHT];
    }
    return _timeLab;
}
@end
