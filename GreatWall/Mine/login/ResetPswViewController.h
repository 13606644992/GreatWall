//
//  ResetPswViewController.h
//  GreatWall
//
//  Created by GJ on 2016/12/28.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "RootViewController.h"

@interface ResetPswViewController : RootViewController<UITextFieldDelegate>
@property (nonatomic, copy)NSString *smsCode;
@property (nonatomic, copy)NSString *phoneStr;
@end
