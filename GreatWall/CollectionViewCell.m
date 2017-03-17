//
//  CollectionViewCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CollectionItemCell.h"

@implementation CollectionViewCell
+ (instancetype)cellWithTheCollectionViewTableView:(UITableView *)tableView
{
    static NSString *ID = @"CollectionViewCell";
    CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadTheCollectViewWithCell];
    }
    return cell;
}
-(void)loadTheCollectViewWithCell
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(18*WIDTH));
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*WIDTH));
    }];
    [self.contentView addSubview:self.collect];
    [self.contentView addSubview:self.bottomTitle];
    [self.bottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.bottom.equalTo(@(-21*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 14*HEIGHT));
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.type.insureList.count+1);
    return self.type.insureList.count+1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionItemCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    if (indexPath.row!=0) {
        OrderInsureList *list = self.type.insureList[indexPath.row-1];
        cell.titleLab.text = list.insureName;
        cell.detailLab.text = list.insureAmount;
    }

    return cell;
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
    self.titleLab.textColor = self.selectColor;
    self.bottomTitle.textColor = self.selectColor;
    if (trade.typeList.count>0) {
        self.type = trade.typeList[0];
        self.collect.frame =CGRectMake(18*WIDTH, 46*WIDTH, ScreenWindowWidth-36*WIDTH, 40*HEIGHT+self.type.insureList.count*41*WIDTH);
        [self.collect reloadData];
    }
}
#pragma mark ---------Controller-------------
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.text = @"保险责任:";
    }
    return _titleLab;
}
-(UILabel *)bottomTitle
{
    if (!_bottomTitle) {
        _bottomTitle = [[UILabel alloc] init];
        _bottomTitle.textColor = LYColor_A3;
        _bottomTitle.font = [UIFont systemFontOfSize:14*WIDTH];
        _bottomTitle.text = @"受益人：法定受益人";
    }
    return _bottomTitle;
}
-(UICollectionView *)collect
{
    if (!_collect) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(ScreenWindowWidth-36*WIDTH, 40*HEIGHT);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(18*WIDTH, 46*HEIGHT, ScreenWindowWidth-36*WIDTH, 40*HEIGHT) collectionViewLayout:layout];
        _collect.backgroundColor = [UIColor whiteColor];
        _collect.layer.borderColor = LYColor_A7.CGColor;
        _collect.layer.cornerRadius = 4.0f;
        _collect.layer.borderWidth = 1.0f;
        _collect.clipsToBounds = YES;
        _collect.userInteractionEnabled = NO;
        _collect.delegate=self;
        _collect.dataSource=self;
        [_collect registerClass:[CollectionItemCell class] forCellWithReuseIdentifier:@"cellid"];
    }
    return _collect;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
