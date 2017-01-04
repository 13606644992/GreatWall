//
//  AddViewController.h
//  GreatWall
//
//  Created by GJ on 2016/12/22.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "RootViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
@interface AddViewController : RootViewController<CNContactPickerDelegate,UITextFieldDelegate>
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UITextField *numTextField;
@property (nonatomic, strong)UITextField *postalTextField;
@property (nonatomic, strong)UITextField *areaTextField;
@property (nonatomic, strong)UITextField *addressTextField;
@property (nonatomic, strong)UIButton *morenBtn;
@end
