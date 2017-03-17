//
//  CheXianDetailVC.h
//  GreatWall
//
//  Created by GJ on 2017/2/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "RootViewController.h"

@interface CheXianDetailVC : RootViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString *detailID;
@end
