//
//  AddCustomerVC.h
//  GreatWall
//
//  Created by GJ on 2017/2/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "RootViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
@interface AddCustomerVC : RootViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,CNContactPickerDelegate>
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *birthday;
@property (nonatomic,copy)NSString *phoneNum;
@property (nonatomic,copy)NSString *IDType;
@property (nonatomic,copy)NSString *IDNumber;
@property (nonatomic,copy)NSString *area;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *Email;
@property (nonatomic,copy)NSString *other;



- (void)daoruBtnAction:(UIButton *)sender;
@end
