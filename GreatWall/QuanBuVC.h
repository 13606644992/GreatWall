//
//  QuanBuVC.h
//  GreatWall
//
//  Created by GJ on 2017/1/18.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "RootViewController.h"

@interface QuanBuVC : RootViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *quanbuList;
@end
