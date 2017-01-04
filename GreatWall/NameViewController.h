//
//  NameViewController.h
//  GreatWall
//
//  Created by GJ on 2016/12/22.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "RootViewController.h"

@interface NameViewController : RootViewController<UIAlertViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong)UITextField *nameField;

@end
