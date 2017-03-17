//
//  AddCustomerVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/10.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "AddCustomerVC.h"
#import "Header.h"
#import "AddCustomerCell.h"
@interface AddCustomerVC ()
@property (nonatomic ,strong)UIButton *loginBtn;
@end

@implementation AddCustomerVC
{
    UIView *headerView;
    UITableView *infoList;
    BOOL isUp;
    UIButton *saveBtn;
    BOOL isOK;
    NSArray *infoArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"guanbi.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:dismissBtn];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView).with.offset(10);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(35*WIDTH, 35*HEIGHT));
    }];
    UILabel *titleLabel = [[UILabel alloc]init];
    [headerView addSubview:titleLabel];
    titleLabel.textColor = LYColor_A1;
    titleLabel.text = @"添加客户";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView);
        make.centerY.mas_equalTo(dismissBtn);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    UIButton *daoruBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:daoruBtn];
    [daoruBtn setTitle:@"从联系人导入" forState:UIControlStateNormal];
    [daoruBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    daoruBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    daoruBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [daoruBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel);
        make.right.mas_equalTo(-14*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [daoruBtn addTarget:self action:@selector(daoruBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    infoList = [[UITableView alloc]init];
    infoList.delegate = self;
    infoList.dataSource = self;
    [self.view addSubview:infoList];
    [infoList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom);
        make.height.mas_equalTo(50*10*HEIGHT + 31);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    infoList. bounces = NO;
    [infoList layoutIfNeeded];//约束生效
    //重新设置分割线
    if ([infoList respondsToSelector:@selector(setSeparatorInset:)]) {
        [infoList setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [infoList setSeparatorColor:LYColor_A6];
    [self.view bringSubviewToFront:headerView];
    isUp = NO;//标记为未向上移动，弹出键盘之后为向上
    //保存按钮
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:saveBtn];
    saveBtn.backgroundColor = LYColor_A1;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius = 4.0f;
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-(self.view.frame.size.height - headerView.frame.size.height - infoList.frame.size.height) / 2 + 22*HEIGHT);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(339*WIDTH);
        make.height.mas_equalTo(44*HEIGHT);
    }];
    [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    infoArray = [NSArray array];
    self.name = @"";
    self.sex = @"";
    self.birthday = @"";
    self.phoneNum = @"";
    self.IDNumber = @"";
    self.IDType = @"";
    self.area = @"";
    self.address = @"";
    self.Email = @"";
    self.other = @"";

}
#pragma mark - 数据解析（添加联系人）
- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"],@"insuredName":@"王琦",@"idType":@"1",@"idNo":@"230521199406011117",@"gender":@"男",@"birthday":@"19940601",@"mobile":@"18646373390"}];
    NSLog(@"dic==================%@",dic);
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"addInsured" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"手动添加联系responseObject=======%@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)saveAction:(UIButton *)sender{
    infoArray = @[self.name, self.sex, self.birthday, self.phoneNum, self.IDType, self.IDNumber, self.area, self.address, self.Email, self.other];
    for (NSString *str in infoArray) {
        if ([str isEqualToString:@""]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请输入完整信息" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    NSLog(@"OK");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = LYColor_A7;
    if (section == 0) {
        headView.frame = CGRectMake(0, 0, ScreenWindowWidth, 13);
    }else{
        headView.frame = CGRectMake(0, 0, ScreenWindowWidth, 18);
    }
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 13;
    }else{
        return 18;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*HEIGHT;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 6;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    AddCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddCustomerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.content.delegate = self;
    [cell.content addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    cell.content.tag = indexPath.row;
    if (indexPath.section == 0) {
        cell.content.selected = YES;
    }else{
        cell.content.selected = NO;
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.titleLabel.text = @"姓名";
        cell.content.text = self.name;
        cell.content.placeholder = @"请输入姓名";
    }else if (indexPath.section == 0 && indexPath.row == 1){
        cell.titleLabel.text = @"性别";
        cell.content.placeholder = @"请选择";
    }else if (indexPath.section == 0 && indexPath.row == 2){
        cell.titleLabel.text = @"出生年月";
        cell.content.placeholder = @"请选择";
    }else if (indexPath.section == 0 && indexPath.row == 3){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWindowWidth);
        cell.titleLabel.text = @"联系电话";
        cell.content.text = self.phoneNum;
        cell.content.placeholder = @"请输入联系电话";
    }else if (indexPath.section == 1 && indexPath.row == 0){
        cell.titleLabel.text = @"证件类型";
        cell.content.placeholder = @"身份证";
    }else if (indexPath.section == 1 && indexPath.row == 1){
        cell.titleLabel.text = @"证件号码";
        cell.content.placeholder = @"请输入证件号码";
    }else if (indexPath.section == 1 && indexPath.row == 2){
        cell.titleLabel.text = @"所在地区";
        cell.content.placeholder = @"请选择所在地区";
    }else if (indexPath.section == 1 && indexPath.row == 3){
        cell.titleLabel.text = @"详细地址";
        cell.content.placeholder = @"请输入详细地址";
    }else if (indexPath.section == 1 && indexPath.row == 4){
        cell.titleLabel.text = @"电子邮箱";
        cell.content.placeholder = @"请输入邮箱";
    }else if (indexPath.section == 1 && indexPath.row == 5){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWindowWidth);
        cell.titleLabel.text = @"备注";
        cell.content.placeholder = @"最多支持200字";
    }
    return cell;
}
- (void)textFieldWithText:(UITextField *)textField{
    if (textField.isSelected == YES) {
        switch (textField.tag) {
            case 0:
                self.name = textField.text;
                break;
            case 1:
                self.sex = textField.text;
                break;
            case 2:
                self.birthday = textField.text;
                break;
            case 3:
                self.phoneNum = textField.text;
                break;
            default:
                break;
        }
    }else{
        switch (textField.tag) {
            case 0:
                self.IDType = textField.text;
                break;
            case 1:
                self.IDNumber = textField.text;
                break;
            case 2:
                self.area = textField.text;
                break;
            case 3:
                self.address = textField.text;
                break;
            case 4:
                self.Email = textField.text;
                break;
            case 5:
                self.other = textField.text;
                break;
            default:
                break;
        }
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!isUp) {
        AddCustomerCell *cell = (AddCustomerCell *)[[textField superview] superview];
        NSIndexPath *indexPath = [infoList indexPathForCell:cell];
        if (indexPath.section == 1 && indexPath.row > 1) {
            NSLog(@"移动");
            [UIView animateWithDuration:0.5 animations:^{
                [infoList mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(headerView.mas_bottom).with.offset(-200);
                }];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                isUp = YES;//标记为已经向上移动，点击输入之后不走[self layoutIfNeed]方法，避免文字弹跳bug。
            }];
    }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"回来");
    if (isUp) {
        [UIView animateWithDuration:0.5 animations:^{
            [infoList mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(headerView.mas_bottom);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            isUp = NO;//标记为未向上移动
        }];
    }
    return YES;
}
- (void)daoruBtnAction:(UIButton *)sender{
    NSLog(@"从联系人导入");
    // 1.创建选择联系人的控制器
    CNContactPickerViewController *contactVc = [[CNContactPickerViewController alloc] init];
    // 2.设置代理
    contactVc.delegate = self;
    // 3.弹出控制器
    [self presentViewController:contactVc animated:YES completion:nil];
}
- (void)btnAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    self.name = [NSString stringWithFormat:@"%@%@", lastname,firstname];
    
    // 2.获取联系人的电话号码(此处获取的是该联系人的第一个号码,也可以遍历所有的号码)
    NSArray *phoneNums = contact.phoneNumbers;
    CNLabeledValue *labeledValue = phoneNums[0];
    CNPhoneNumber *phoneNumer = labeledValue.value;
    NSString *phoneNumber = phoneNumer.stringValue;
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"+86 " withString:@""];
    self.phoneNum = phoneNumber;
    [infoList reloadData];
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
