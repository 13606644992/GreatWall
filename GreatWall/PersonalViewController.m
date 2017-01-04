//
//  PersonalViewController.m
//  GreatWall
//
//  Created by GJ on 2016/12/21.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "PersonalViewController.h"
#import "Header.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NameViewController.h"
#import "SexViewController.h"
#import "AddressViewController.h"
@interface PersonalViewController ()

@property (nonatomic, strong)UIImageView *headerIMGView;
@end

@implementation PersonalViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    StatusBarBlack;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人资料设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor : LYColor_A1}];//修改字体颜色
    [self.navigationController.navigationBar setTintColor:LYColor_A1];//返回按钮颜色
    self.view.backgroundColor = LYColor_A7;
    [self creatSubView];
}
- (void)creatSubView{
    self.headerIMG = [UIImage imageNamed:@"head.jpg"];
    
    UIView *backgroundView = [[UIView alloc]init];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13 * HEIGHT);
        make.left.mas_equalTo(0);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(376 * HEIGHT);
    }];
    backgroundView.backgroundColor = [UIColor whiteColor];
    //分割线、标题
    for (NSInteger i = 2; i < 8; i ++) {
        UILabel *line = [[UILabel alloc]init];
        [backgroundView addSubview:line];
        line.backgroundColor = LYColor_A7;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(357 * WIDTH);
            make.top.mas_equalTo(i * 58 * HEIGHT - 30*HEIGHT);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont systemFontOfSize:14*WIDTH];
        title.textColor = LYColor_A3;
        [backgroundView addSubview:title];
        title.backgroundColor = [UIColor whiteColor];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.centerY.mas_equalTo(line.mas_top).with.offset(-29 * HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100 * WIDTH, 25 * HEIGHT));
        }];
        if (i == 2) {
            [title mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(line.mas_top).with.offset(-43 * HEIGHT);
            }];
            title.text = @"头像";
            //头像imageView
            [backgroundView addSubview:self.headerIMGView];
            [self.headerIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-33 * WIDTH);
                make.centerY.mas_equalTo(title);
                make.size.mas_equalTo(CGSizeMake(44*WIDTH, 44*HEIGHT));
            }];
            self.headerIMGView.layer.masksToBounds = YES;
            self.headerIMGView.layer.cornerRadius = 22.0*WIDTH;
            [self.headerIMGView setImage:self.headerIMG];
            self.headerIMGView.contentMode = UIViewContentModeScaleAspectFit;
            self.headerIMGView.backgroundColor = [UIColor whiteColor];
            self.headerIMGView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getPhoto)];
            [self.headerIMGView addGestureRecognizer:tapGesture];
        }else if (i == 3){
            title.text = @"昵称";
            [backgroundView addSubview:self.nameLabel];
            self.nameLabel.text = @"泰森";
            self.nameLabel.backgroundColor = [UIColor whiteColor];
            self.nameLabel.textAlignment = NSTextAlignmentRight;
            self.nameLabel.font = [UIFont systemFontOfSize:13 * WIDTH];
            self.nameLabel.textColor = LYColor_A4;
            [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.headerIMGView);
                make.centerY.mas_equalTo(title);
                make.size.mas_equalTo(CGSizeMake(100 * WIDTH, 25 * HEIGHT));
            }];
        }else if (i == 4){
            title.text = @"性别";
            [backgroundView addSubview:self.sexLabel];
            self.sexLabel.text = @"男";
            self.sexLabel.backgroundColor = [UIColor whiteColor];
            self.sexLabel.textAlignment = NSTextAlignmentRight;
            self.sexLabel.font = [UIFont systemFontOfSize:13 * WIDTH];
            self.sexLabel.textColor = LYColor_A4;
            [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.headerIMGView);
                make.centerY.mas_equalTo(title);
                make.size.mas_equalTo(CGSizeMake(100 * WIDTH, 25 * HEIGHT));
            }];

        }else if (i == 5){
            title.text = @"手机号";
            [backgroundView addSubview:self.numberLabel];
            NSString *phoneNum = @"18686570371";
            NSString *string=[phoneNum stringByReplacingOccurrencesOfString:[phoneNum substringWithRange:NSMakeRange(3,4)]withString:@"****"];
            self.numberLabel.text = string;
            self.numberLabel.backgroundColor = [UIColor whiteColor];
            self.numberLabel.textAlignment = NSTextAlignmentRight;
            self.numberLabel.font = [UIFont systemFontOfSize:13 * WIDTH];
            self.numberLabel.textColor = LYColor_A4;
            [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.headerIMGView);
                make.centerY.mas_equalTo(title);
                make.size.mas_equalTo(CGSizeMake(200 * WIDTH, 25 * HEIGHT));
            }];
        }else if (i == 6){
            title.text = @"邮箱";
            [backgroundView addSubview:self.emailLabel];
            self.emailLabel.text = @"liguanjian@163.com";
            self.emailLabel.backgroundColor = [UIColor whiteColor];
            self.emailLabel.textAlignment = NSTextAlignmentRight;
            self.emailLabel.font = [UIFont systemFontOfSize:13 * WIDTH];
            self.emailLabel.textColor = LYColor_A4;
            [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.headerIMGView);
                make.centerY.mas_equalTo(title);
                make.size.mas_equalTo(CGSizeMake(200 * WIDTH, 25 * HEIGHT));
            }];

        }else if (i == 7){
            title.text = @"地址管理";
        }
        //按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backgroundView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(title);
            make.right.mas_equalTo(-5 * WIDTH);
            make.size.mas_equalTo(CGSizeMake(25 * WIDTH, 25 * HEIGHT));
        }];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
        btn.tag = i;
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    //下方
    UIView *footView = [[UIView alloc]init];
    [self.view addSubview:footView];
    footView.backgroundColor = [UIColor whiteColor];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backgroundView.mas_bottom).with.offset(13*HEIGHT);
        make.left.mas_equalTo(backgroundView);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(116*HEIGHT);
    }];
    UILabel *line_foot = [[UILabel alloc]init];
    [footView addSubview:line_foot];
    line_foot.backgroundColor = LYColor_A7;
    [line_foot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(357*WIDTH);
        make.top.mas_equalTo(footView.mas_centerY);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    for (NSInteger i = 0; i < 2; i ++) {
        UILabel *title_foot = [[UILabel alloc]init];
        [footView addSubview:title_foot];
        title_foot.backgroundColor = [UIColor whiteColor];
        title_foot.font = [UIFont systemFontOfSize:14*WIDTH];
        title_foot.textColor = LYColor_A3;
        [title_foot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line_foot);
            make.size.mas_equalTo(CGSizeMake(100*WIDTH, 25*HEIGHT));
            make.centerY.mas_equalTo(line_foot.mas_top).with.offset(-29*HEIGHT);
            
        }];
        if (i == 0) {
            title_foot.text = @"实名认证";
            [footView addSubview:self.renzhengLabel];
            [self.renzhengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(title_foot);
                make.right.mas_equalTo(self.headerIMGView);
                make.size.mas_equalTo(CGSizeMake(200*WIDTH, 25*HEIGHT));
            }];
            self.renzhengLabel.font = [UIFont systemFontOfSize:13*HEIGHT];
            self.renzhengLabel.textColor = UIColorRGBA(255, 93, 89, 1);
            self.renzhengLabel.textAlignment = NSTextAlignmentRight;
            self.renzhengLabel.text = @"未认证";
        }else if (i == 1) {
            title_foot.text = @"账户安全";
            [title_foot mas_updateConstraints:^(MASConstraintMaker *make) {
               make.centerY.mas_equalTo(line_foot.mas_top).with.offset(29*HEIGHT);
            }];
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [footView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(title_foot);
            make.right.mas_equalTo(-10 * WIDTH);
            make.size.mas_equalTo(CGSizeMake(25 * WIDTH, 25 * HEIGHT));
        }];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
        btn.tag = i;
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.pickerImage = [[UIImagePickerController alloc] init];
    
    //通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeName:) name:@"changeName" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSex:) name:@"changeSex" object:nil];
}





- (void)btnAction:(UIButton *)sender{
    if (sender.tag == 2) {
        [self getPhoto];
    }else if (sender.tag == 3){
        [self pushToNameVC];
    }else if (sender.tag == 4){
        [self pushToSexVC];
    }else if (sender.tag == 7){
        [self pushToAddressVC];
    }
}
- (void)pushToAddressVC{
    AddressViewController *addressVC = [[AddressViewController alloc]init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:addressVC animated:YES];
}
- (void)pushToSexVC{
    SexViewController *sexVC = [[SexViewController alloc]init];
    sexVC.sexStr  = self.sexLabel.text;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:sexVC animated:YES];
}
- (void)changeName:(NSNotification *)sender{
    self.nameLabel.text = sender.userInfo[@"name"];
}
- (void)changeSex:(NSNotification *)sender{
    self.sexLabel.text = sender.userInfo[@"sex"];
}

- (void)pushToNameVC{
    NameViewController *nameVC = [[NameViewController alloc]init];
    nameVC.nameField.text = self.nameLabel.text;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nameVC animated:YES];
}


- (void)getPhoto{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.pickerImage.sourceType];
        self.pickerImage.delegate = self;
        self.pickerImage.allowsEditing = YES;
        //[self presentModalViewController:self.pickerImage animated:YES];
        [self presentViewController:self.pickerImage animated:YES completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍照");
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];

//        self.pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
//        self.pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.pickerImage.sourceType];
//        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
//        NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType,nil];
//        [self.pickerImage setMediaTypes:arrMediaTypes];
//        self.pickerImage.delegate = self;
//        self.pickerImage.allowsEditing = YES;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"截取");
    UIImage *crop = [info objectForKey:UIImagePickerControllerEditedImage];//截取后的图片
    self.headerIMGView.image = crop;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeHeadIMG" object:nil userInfo:@{@"headIMG" : crop}];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/*            lazyLoading...... .          */


- (UIImageView *)headerIMGView{
    if (!_headerIMGView) {
        _headerIMGView = [[UIImageView alloc]init];
    }
    return _headerIMGView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
    }
    return _nameLabel;
}
- (UILabel *)sexLabel{
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc]init];
    }
    return _sexLabel;
}
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
    }
    return _numberLabel;
}
- (UILabel *)emailLabel{
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc]init];
    }
    return _emailLabel;
}
- (UILabel *)renzhengLabel{
    if (!_renzhengLabel) {
        _renzhengLabel = [[UILabel alloc]init];
    }
    return _renzhengLabel;
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
