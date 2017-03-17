//
//  AdressViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/22.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "AddressViewController.h"
#import "Header.h"
#import "AddressTableViewCell.h"
#import "AddViewController.h"
#import "GJModel.h"
@interface AddressViewController ()
@property (nonatomic, strong)UITableView *addressList;
@property (nonatomic, strong)NSMutableArray *addressArray;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)BOOL isTop;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.navigationItem.title = @"地址管理";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: LYColor_A1};//导航栏文字颜色及大小
    
    self.view.backgroundColor = LYColor_A7;
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:addBtn];
    addBtn.backgroundColor = LYColor_A1;
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(56*HEIGHT);
    }];
    [addBtn setTitle:@"＋ 新建地址" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    addBtn.titleLabel.textColor = [UIColor whiteColor];
    [addBtn addTarget:self action:@selector(addNewAdress:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH];
    
    [self.view addSubview:self.addressList];
    [self.addressList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(addBtn.mas_top);
    }];
    self.addressList.delegate = self;
    self.addressList.dataSource = self;
    self.addressList.separatorStyle = NO;
    
    self.page = 1;
//    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
//        NSLog(@"加载");
//        self.isTop = NO;
//        [self getAddressData];//获取地址信息
//    }];
//    [footer setTitle:@"" forState:MJRefreshStateIdle];
//    [footer setTitle:@"" forState:MJRefreshStatePulling];
//    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
//    footer.stateLabel.textColor = LYColor_A1;
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.addressArray removeAllObjects];
//        self.isTop = YES;
//        [self getAddressData];
//        NSLog(@"刷新");
//    }];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
//    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
//    [header setTitle:@"刷新中 ..." forState:MJRefreshStateRefreshing];
//    header.stateLabel.textColor = LYColor_A1;
//    self.addressList.mj_header = header;
//    self.addressList.mj_footer = footer;
    
    self.addressArray = [NSMutableArray array];//初始化地址数组
    [self getAddressData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    GJModel *model = self.addressArray[indexPath.row];//获取对应model
    cell.name.text = model.cneeName;//姓名
    NSString *str = model.mobile;//电话
    if (str.length == 11) {
        cell.phoneNum.text = [str stringByReplacingOccurrencesOfString:[str substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    }
    NSString *string = model.address;//地址
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    cell.address.attributedText = attributedString;
    [cell.selectBtn addTarget:self action:@selector(morenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shanchuBtn addTarget:self action:@selector(shanchuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.bianjiBtn addTarget:self action:@selector(bianjiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//修改被选中cell的✔️ 和文字颜色
    cell.selectIMG.image = [model.defaultFlag isEqualToString:@"1"] ? [UIImage imageNamed:@"gouxuan.png"] :  [UIImage imageNamed:@"Rectanglearrondi16copie.png"];
    cell.moren.textColor = [model.defaultFlag isEqualToString:@"1"]? LYColor_A1 : LYColor_A4;
    cell.cneeId = model.cneeId;//地址id（传值用）
    return cell;
}
/**
 删除按钮
 */
- (void)shanchuBtnAction:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确认删除地址?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddressTableViewCell *cell = (AddressTableViewCell *)[[[sender superview] superview] superview];
        NSIndexPath *path = [self.addressList indexPathForCell:cell];
        GJModel *model = [self.addressArray objectAtIndex:path.row];//获取对应model
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"], @"cneeId": model.cneeId}];
        [GJAFNetWork POST:URL_ALIANG params:params method:@"delConsignee" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"删除地址 %@", responseObject);
            NSLog(@"%@", responseObject[@"respMsg"]);
            if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
                [self.addressArray removeObjectAtIndex:path.row];
                [self.addressList reloadData];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"错误：%@", error);
            
        }];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 编辑按钮
 */
- (void)bianjiBtnAction:(UIButton *)sender{
    AddressTableViewCell *cell = (AddressTableViewCell *)[[[sender superview] superview] superview];
    NSIndexPath *path = [self.addressList indexPathForCell:cell];
    GJModel *model = [self.addressArray objectAtIndex:path.row];//获取对应model
    AddViewController *addVC = [[AddViewController alloc]init];
    addVC.isEdit =  YES;
    addVC.nameTextField.text = model.cneeName;
    addVC.numTextField.text = model.mobile;
    addVC.postalTextField.text = model.areaCode;
    addVC.addressTextField.text = model.address;
    addVC.morenBtn.selected = [model.defaultFlag isEqualToString:@"1"] ? YES : NO;
    addVC.cneeId  = model.cneeId;
    [self.navigationController pushViewController:addVC animated:YES];
}
/**
 默认按钮

 */
- (void)morenBtnAction:(UIButton *)sender{
    AddressTableViewCell *cell = (AddressTableViewCell *)[[[sender superview] superview] superview];
    NSIndexPath *path = [self.addressList indexPathForCell:cell];
    GJModel *model = [self.addressArray objectAtIndex:path.row];//获取对应model
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"], @"cneeId": model.cneeId, @"defaultFlag" : @"1", @"cneeName" : model.cneeName, @"mobile" : model.mobile, @"address" : model.address, @"areaCode" : model.areaCode}];
    NSLog(@"请求参数= %@", params);
    [GJAFNetWork POST:URL_ALIANG params:params method:@"updateConsignee" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"修改默认地址 %@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            [self.addressArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                GJModel *model = obj;
                model.defaultFlag = @"0";
            }];
            GJModel *model = [self.addressArray objectAtIndex:path.row];
            model.defaultFlag = @"1";
            [self.addressArray replaceObjectAtIndex:path.row withObject:model];
            [self.addressList reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}

- (void)getAddressData{
//    if (self.isTop) {
//        self.page = 1;
//    }else{
//        self.page++;
//    }
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userId": userId, @"pageIndex" : [NSString stringWithFormat:@"%ld", self.page], @"pageSize" : @"4"}];
    [GJAFNetWork POST:URL_ALIANG params:params method:@"getConsignees" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取地址 ========= %@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSDictionary *myDic = responseObject[@"output"];
            NSArray *addressArr = myDic[@"cneeList"];
            
                //遍历
                [addressArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    GJModel *model = [[GJModel alloc]init];
                    [model setValuesForKeysWithDictionary:obj];
                    [self.addressArray addObject:model];
                }];
                [self.addressList reloadData];
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取地址错误 = %@", error);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 151*HEIGHT + 13;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    StatusBarBlack;
}
- (void)addNewAdress:(UIButton *)sender{
    AddViewController *addVC = [[AddViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (UITableView *)addressList{
    if (!_addressList) {
        _addressList = [[UITableView alloc]init];
        _addressList.backgroundColor = LYColor_A7;
    }
    return _addressList;
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
