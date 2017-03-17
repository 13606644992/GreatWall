//
//  CollectionViewCell.h
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface CollectionViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic ,strong)PayTrade *trade;
@property (nonatomic ,strong)OrderType *type;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *bottomTitle;
@property (nonatomic ,strong) UICollectionView * collect;
@property (nonatomic ,strong)UIColor *selectColor;



+ (instancetype)cellWithTheCollectionViewTableView:(UITableView *)tableView;
@end
