//
//  Address.m
//  GreatWall
//
//  Created by GJ on 2017/1/18.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "Address.h"
#import "Header.h"
#import "AddressCell.h"
#import "AddressModel.h"
@interface Address ()
@property (nonatomic, strong)NSMutableArray *tableViewArray;
@property (nonatomic, strong)NSMutableArray *buttonArray;
@property (nonatomic, strong)UIButton *shengBtn;
@property (nonatomic, strong)UIButton *shiBtn;
@property (nonatomic, strong)UIButton *quBtn;
@end

@implementation Address
{
    UITableView *areaList;
    NSMutableArray *modelArray;
    UILabel *line;
    UIView *background;
    NSInteger areaType;
    NSArray *provenceArr;
    NSArray *cityArr;
    NSArray *locationArr;
    
    NSArray *dataArr;
    
    UIView *underLine;;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   //背景板
    background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(416);
    }];
    [background layoutIfNeeded];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:background.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = background.bounds;
    maskLayer.path = maskPath.CGPath;
    background.layer.mask = maskLayer;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.backgroundColor = [UIColor clearColor];
    [background addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *backIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shanchu.png"]];
    backIMG.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addSubview:backIMG];
    [backIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(backBtn);
        make.size.mas_equalTo(CGSizeMake(9, 9));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = @"请选择所在地区";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = LYColor_A4;
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [background addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.centerX.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(200, 14));
    }];
    
    line = [[UILabel alloc]init];
    line.backgroundColor = LYColor_A7;
    [background addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(90);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    provenceArr = @[@"浙江省", @"黑龙江省", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    cityArr = @[@"杭州市", @"哈尔滨市", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k"];
    locationArr = @[@"江干区", @"嘿嘿", @"呵呵", @"嘎嘎", @"哇哇哇哇哇哇哇哇哇哇", @"呦呦", @"啪啪", @"噗噗", @"嘻嘻", @"哦哦", @"嗯嗯"];
    //areaType
    areaType = 0;
    //按钮
    self.shengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shengBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.shengBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [self.shengBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [background addSubview:self.shengBtn];
    [self.shengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25*WIDTH);
        make.top.mas_equalTo(50*HEIGHT);
        make.height.mas_equalTo(30*HEIGHT);
        make.width.mas_equalTo(60);
    }];
    [self.shengBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.shengBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    self.shengBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.shengBtn.tag = 1000;
    
    self.shiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shiBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.shiBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [self.shiBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [background addSubview:self.shiBtn];
    [self.shiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shengBtn.mas_right).with.offset(15);
        make.top.mas_equalTo(50*HEIGHT);
        make.height.mas_equalTo(30*HEIGHT);
        make.width.mas_equalTo(60);
    }];
    [self.shiBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.shiBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    self.shiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.shiBtn.tag = 1001;
    self.shiBtn.hidden = YES;
    
    self.quBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.quBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.quBtn.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [self.quBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    [background addSubview:self.quBtn];
    [self.quBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shiBtn.mas_right).with.offset(15);
        make.top.mas_equalTo(50*HEIGHT);
        make.height.mas_equalTo(30*HEIGHT);
        make.width.mas_equalTo(60);
    }];
    [self.quBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.quBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.quBtn.tag = 1002;
    self.quBtn.hidden = YES;
    self.quBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    
    dataArr = [NSArray array];
    modelArray = [NSMutableArray array];
//    [self getAreaDate]; //获取省市区date
//    [self loadDate];
    underLine = [[UIView alloc]init];
    underLine.backgroundColor = LYColor_A4;
    [background addSubview:underLine];
    [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shengBtn);
        make.bottom.mas_equalTo(line.mas_bottom);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(self.shengBtn);
    }];
    [underLine layoutIfNeeded];
    [self addTableView];
}

- (void)getAreaDate{
    NSMutableDictionary *paramer = [NSMutableDictionary dictionaryWithDictionary:@{@"findAllFlag" : @"true"}];
    [GJAFNetWork POST:URL_ALIANG params:paramer method:@"getAreaList" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSLog(@"省市区成功");
            //储存地址列表
            NSArray *areaArr = responseObject[@"output"][@"areasList"];
            NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *filePath = [documentPath stringByAppendingPathComponent:@"areaList.plist"];
            [areaArr writeToFile:filePath atomically:YES];
            NSLog(@"%@", filePath);
            [self loadDate];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}
- (void)loadDate{
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath = [documentPath stringByAppendingPathComponent:@"areaList.plist"];
//            NSLog(@"地址 = %@",[NSArray arrayWithContentsOfURL:fileUrl]);
//    NSLog(@"%@", [NSArray arrayWithContentsOfFile:filePath]);
    for (NSDictionary *dic in [NSArray arrayWithContentsOfFile:filePath]) {
        AddressModel *model = [[AddressModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    [self addTableView];
}

- (void)addTableView{

    areaList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [background addSubview:areaList];
    [areaList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    areaList.delegate = self;
    areaList.dataSource = self;
    areaList.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (areaType) {
        case 0:
            return provenceArr.count;
            break;
        case 1:
            return cityArr.count;
            break;
        case 2:
            return locationArr.count;
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41*HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (areaType) {
        case 0:
            dataArr = provenceArr;
            break;
        case 1:
            dataArr = cityArr;
            break;
        case 2:
            dataArr = locationArr;
            break;
        default:
            break;
    }
    cell.area.text = [dataArr objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)areaType);
    CGRect rect = underLine.frame;
    switch (areaType) {
        case 0:
            areaType = 1;
            [self.shengBtn setTitle:[provenceArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            [self.shengBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
             [self.shiBtn setTitle:@"请选择" forState:UIControlStateNormal];
             [self.shiBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
            self.shiBtn.hidden = NO;
            self.quBtn.hidden = YES;
            break;
        case 1:
            areaType = 2;
            [self.shiBtn setTitle:[cityArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            [self.shiBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
            [self.quBtn setTitle:@"请选择" forState:UIControlStateNormal];
            [self.quBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
            self.quBtn.hidden = NO;
            break;
        case 2:
            self.quBtn.userInteractionEnabled = YES;
            [self.quBtn setTitle:[locationArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            [self.quBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [tableView reloadData];
    [UIView animateWithDuration:0.2 animations:^{
        if (areaType == 0) {
            underLine.frame = CGRectMake(self.shengBtn.frame.origin.x, rect.origin.y, self.shengBtn.frame.size.width,  rect.size.height);
        }else if (areaType == 1){
            underLine.frame = CGRectMake(self.shiBtn.frame.origin.x, rect.origin.y, self.shiBtn.frame.size.width,  rect.size.height);
        }else{
            underLine.frame = CGRectMake(self.quBtn.frame.origin.x, rect.origin.y, self.quBtn.frame.size.width,  rect.size.height);
        }
    }];

    tableView.contentOffset = CGPointMake(0, 0);
}

- (void)btnAction:(UIButton *)sender{
    NSLog(@"%ld", sender.tag);
    switch (sender.tag) {
        case 1000:
            areaType = 0;
            break;
        case 1001:
            areaType = 1;
            break;
        case 1002:
            areaType = 2;
            break;
        default:
            break;
    }
    [areaList reloadData];
    [sender layoutIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = underLine.frame;
        underLine.frame = CGRectMake(sender.frame.origin.x, rect.origin.y, sender.frame.size.width, rect.size.height);
    }];
}




- (void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (self.view == [touch view]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
