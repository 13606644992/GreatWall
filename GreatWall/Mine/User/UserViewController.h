//
//  UserViewController.h
//  GreatWall
//
//  Created by GJ on 2016/12/21.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "RootViewController.h"

@interface UserViewController : RootViewController<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic ,strong) NSString *result;

@end
