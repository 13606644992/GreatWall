//
//  DescriptionImageCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DescriptionImageCell.h"

@implementation DescriptionImageCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DescriptionImageCell";
    
    DescriptionImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initAnyThingWithCell];
    }
    return cell;
}
-(void)initAnyThingWithCell
{
    [self.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(13*WIDTH);
        make.right.equalTo(self.contentView).with.offset(-13*WIDTH);
    }];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:PlaceImage];
    }
    return _titleImg;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
