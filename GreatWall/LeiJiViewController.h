//
//  LeiJiViewController.h
//  GreatWall
//
//  Created by GJ on 2017/1/12.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "RootViewController.h"

@interface LeiJiViewController : RootViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UILabel *moneyLabel;
@end
