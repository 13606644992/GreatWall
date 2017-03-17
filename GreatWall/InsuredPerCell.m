//
//  InsuredPerCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "InsuredPerCell.h"

@implementation InsuredPerCell
+ (instancetype)cellWithTheInsureTableView:(UITableView *)tableView
{
    static NSString *ID = @"InsuredPerCell";
    InsuredPerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadTheInsurePerViewWithCell];
    }
    return cell;
}
-(void)loadTheInsurePerViewWithCell
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(65*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTrade:(PayTrade *)trade
{
    self.selectColor = LYColor_A3;
    if ([trade.sts isEqualToString:@"-11"]) {
        self.selectColor = LYColor_A4;
    }
    if (trade.insuredList.count>0) {
        OrderPersonal *person = trade.insuredList[0];
        self.titleLab.textColor = self.selectColor;
        NSInteger index = [person.relation integerValue];
        if (index == 9) {
            index = 4;
        }
        self.titleLab.text = self.relations[index-1];
    }
}
#pragma mark ---------Controller-------------
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.text = @"本人";
    }
    return _titleLab;
}
-(NSArray *)relations
{
    if (!_relations) {
        _relations = @[@"父母",@"子女",@"配偶",@"其他关系"];
    }
    return _relations;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
