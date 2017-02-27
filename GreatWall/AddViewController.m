//
//  AddViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/22.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "AddViewController.h"
#import "Header.h"
#import "Address.h"
@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"新建收货人";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    self.view.backgroundColor = LYColor_A7;
    self.navigationController.navigationBar.translucent = NO;
    [self creatSubview];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    StatusBarBlack;
}

- (void)creatSubview{
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.numTextField];
    [self.view addSubview:self.postalTextField];
    [self.view addSubview:self.areaTextField];
    [self.view addSubview:self.addressTextField];
    UIColor *backgroundColor = [UIColor whiteColor];
    self.nameTextField.backgroundColor= backgroundColor;
    self.numTextField.backgroundColor = backgroundColor;
    self.postalTextField.backgroundColor = backgroundColor;
    self.areaTextField.backgroundColor = backgroundColor;
    self.addressTextField.backgroundColor = backgroundColor;
    UIFont *font = [UIFont systemFontOfSize:14.0*HEIGHT];
    self.nameTextField.font = font;
    self.numTextField.font = font;
    self.postalTextField.font = font;
    self.areaTextField.font = font;
    self.addressTextField.font = font;
    self.nameTextField.textColor = LYColor_A3;
    self.numTextField.textColor = LYColor_A3;
    self.postalTextField.textColor = LYColor_A3;
    self.areaTextField.textColor = LYColor_A3;
    self.addressTextField.textColor = LYColor_A3;
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13*HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(56*HEIGHT);
    }];
    [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTextField.mas_bottom);
        make.left.mas_equalTo(self.nameTextField);
        make.size.mas_equalTo(self.nameTextField);
    }];
    [self.postalTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numTextField.mas_bottom);
        make.left.mas_equalTo(self.nameTextField);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(self.nameTextField);
    }];
    [self.areaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.postalTextField.mas_bottom);
        make.left.mas_equalTo(self.nameTextField);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(self.nameTextField);
    }];
    [self.addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.areaTextField.mas_bottom);
        make.left.mas_equalTo(self.nameTextField);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(self.nameTextField);
    }];

    [self setTextFieldLeftPadding:self.nameTextField forWidth:85*WIDTH title:@"    收货人"];
    [self setTextFieldLeftPadding:self.numTextField forWidth:85*WIDTH title:@"    联系方式"];
    [self setTextFieldLeftPadding:self.postalTextField forWidth:85*WIDTH title:@"    邮政编码"];
    [self setTextFieldLeftPadding:self.areaTextField forWidth:85*WIDTH title:@"    所在地区"];
    [self setTextFieldLeftPadding:self.addressTextField forWidth:85*WIDTH title:@"    详细地址"];
    
    
    [self.nameTextField setPlaceholder:@"请输入真实姓名"];
    [self.numTextField setPlaceholder:@"您的电话号码"];
    [self.postalTextField setPlaceholder:@"您的邮编"];
    [self.areaTextField setPlaceholder:@"省、市、区"];
    [self.addressTextField setPlaceholder:@"街道/楼牌号等"];
    
    self.numTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.postalTextField.keyboardType = UIKeyboardTypeNumberPad;
    for (NSInteger i = 0; i < 5; i++) {
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = LYColor_A7;
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.top.mas_equalTo(55*(i + 1)*HEIGHT + 13*HEIGHT + i);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    UIImageView *jiantouIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    [self.view addSubview:jiantouIMG];
    [jiantouIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.areaTextField);
        make.right.mas_equalTo(-10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(14 * WIDTH, 12 * HEIGHT));
    }];
    jiantouIMG.contentMode = UIViewContentModeScaleAspectFit;
    //联系人按钮
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameTextField);
        make.right.mas_equalTo(-12*WIDTH);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 30*WIDTH));
    }];
    [selectBtn setImage:[UIImage imageNamed:@"contacts.png"] forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.areaTextField.delegate = self;
    //添加地址选择器
    
    //设为默认
    UILabel *morenLabel = [[UILabel alloc]init];
    morenLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:morenLabel];
    [morenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.addressTextField.mas_bottom).with.offset(13*HEIGHT);
        make.height.mas_equalTo(56*HEIGHT);
    }];
    morenLabel.text = @"    设为默认地址";
    morenLabel.font = font;
    morenLabel.textColor = LYColor_A3;
    
    [self.view addSubview:self.morenBtn];
    self.morenBtn.backgroundColor = [UIColor whiteColor];
    [self.morenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(morenLabel);
        make.right.mas_equalTo(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(40*WIDTH, 24*HEIGHT));
    }];
    [self.morenBtn addTarget:self action:@selector(setToMoren:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = self.morenBtn.isSelected ? [UIImage imageNamed:@"on.png"] : [UIImage imageNamed:@"off.png"];
    [self.morenBtn setImage:image forState:UIControlStateNormal];
    //保存按钮
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = LYColor_A1;
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(morenLabel.mas_bottom).with.offset(31*HEIGHT);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(339*WIDTH, 44*HEIGHT));
    }];
    saveBtn.layer.cornerRadius = 4.0f;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    if (self.isEdit) {
       [saveBtn addTarget:self action:@selector(saveBtnEditAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
       [saveBtn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)setToMoren:(UIButton *)sender{
    sender.selected = !sender.selected;
    UIImage *image = sender.isSelected ? [UIImage imageNamed:@"on.png"] : [UIImage imageNamed:@"off.png"];
    [sender setImage:image forState:UIControlStateNormal];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
     [self.nameTextField resignFirstResponder];
     [self.numTextField resignFirstResponder];
     [self.postalTextField resignFirstResponder];
     [self.addressTextField resignFirstResponder];
    NSLog(@"选择地址");
    Address *address = [[Address alloc]init];
    self.definesPresentationContext = YES; //self is presenting view controller
    address.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    address.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:address animated:YES completion:nil];
    return NO;
}

- (void)saveBtnAction:(UIButton *)sender{

    if (![self.nameTextField.text isEqualToString:@""] && ![self.numTextField.text isEqualToString:@""] && ![self.postalTextField.text isEqualToString:@""] && ![self.addressTextField.text isEqualToString:@""]) {
        NSString *defaultFlag = self.morenBtn.isSelected ? @"1" : @"0"; // 是否为默认
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"], @"cneeName": self.nameTextField.text, @"mobile" : self.numTextField.text, @"zipCode" : self.postalTextField.text, @"address" : self.addressTextField.text, @"syncUser" : @"1", @"defaultFlag" : defaultFlag, @"areaId" : @"330382"}];
        [GJAFNetWork POST:URL_ALIANG params:params method:@"addConsignee" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"新增收货人：%@", responseObject);
            NSLog(@"%@", responseObject[@"respMsg"]);
            if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"错误：%@", error);
        }];
    }
}
- (void)saveBtnEditAction:(UIButton *)sender{
    if (![self.nameTextField.text isEqualToString:@""] && ![self.numTextField.text isEqualToString:@""] && ![self.postalTextField.text isEqualToString:@""] && ![self.addressTextField.text isEqualToString:@""]) {
        NSString *defaultFlag = self.morenBtn.isSelected ? @"1" : @"0"; // 是否为默认
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"], @"cneeName": self.nameTextField.text, @"mobile" : self.numTextField.text, @"zipCode" : self.postalTextField.text, @"address" : self.addressTextField.text, @"syncUser" : @"1", @"defaultFlag" : defaultFlag, @"areaId" : @"330382", @"cneeId" : self.cneeId}];
        [GJAFNetWork POST:URL_ALIANG params:params method:@"updateConsignee" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"修改收货人：%@", responseObject);
            NSLog(@"%@", responseObject[@"respMsg"]);
            if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"错误：%@", error);
        }];
    }

}
- (void)selectBtnAction:(UIButton *)sender{
    NSLog(@"1");
    // 1.创建选择联系人的控制器
    CNContactPickerViewController *contactVc = [[CNContactPickerViewController alloc] init];
    // 2.设置代理
    contactVc.delegate = self;
    // 3.弹出控制器
    [self presentViewController:contactVc animated:YES completion:nil];
}

-(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth title:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftWidth, 50*HEIGHT)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = title;
    titleLabel.textColor = LYColor_A3;
    titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = (UIView *)titleLabel;
}


// 1.点击取消按钮调用的方法
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    NSLog(@"取消选择联系人");
    
}
// 2.当选中某一个联系人时会执行该方法
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    // 1.获取联系人的姓名
    NSString *lastname = contact.familyName;
    NSString *firstname = contact.givenName;
    self.nameTextField.text = [NSString stringWithFormat:@"%@%@", lastname,firstname];
    
    // 2.获取联系人的电话号码(此处获取的是该联系人的第一个号码,也可以遍历所有的号码)
    NSArray *phoneNums = contact.phoneNumbers;
    CNLabeledValue *labeledValue = phoneNums[0];
    CNPhoneNumber *phoneNumer = labeledValue.value;
    NSString *phoneNumber = phoneNumer.stringValue;
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"+86 " withString:@""];
    self.numTextField.text = phoneNumber;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameTextField resignFirstResponder];
    [self.numTextField resignFirstResponder];
    [self.postalTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
}

/*            lazyLoading...... .          */
- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]init];
    }
    return _nameTextField;
}
- (UITextField *)numTextField{
    if (!_numTextField) {
        _numTextField = [[UITextField alloc]init];
    }
    return _numTextField;
}
- (UITextField *)postalTextField{
    if (!_postalTextField) {
        _postalTextField = [[UITextField alloc]init];
    }
    return _postalTextField;
}
- (UITextField *)addressTextField{
    if (!_addressTextField) {
        _addressTextField = [[UITextField alloc]init];
    }
    return _addressTextField;
}
- (UITextField *)areaTextField{
    if (!_areaTextField) {
        _areaTextField = [[UITextField alloc]init];
    }
    return _areaTextField;
}
- (UIButton *)morenBtn{
    if (!_morenBtn) {
        _morenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _morenBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
