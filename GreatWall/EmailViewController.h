//
//  EmailViewController.h
//  GreatWall
//
//  Created by GJ on 2017/1/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "RootViewController.h"

@interface EmailViewController : RootViewController<UIAlertViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong)UITextField *emailTextField;
@end
