//
//  LYPickerView.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/15.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "LYPickerView.h"
#import "Header.h"
#import "UIView+Frame.h"

@interface LYPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *titleArray;
}
@property (nonatomic, strong) UIView       * bgView;
@property (nonatomic, strong) UIView       * dateView;
@property (nonatomic, strong) UIPickerView * pickerView;
@property (nonatomic, strong)   NSString     * selectDate;
@property (nonatomic, assign)   NSInteger     index;

@end

@implementation LYPickerView

static id _instace;

+ (instancetype)shareShareType{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{// 只创建一次
        _instace = [[self alloc] init];
    });
    return _instace;
}
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{// 只初始化一次
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}

- (void)PickerViewShowModeWithArray:(NSArray *)shengarray{
    if (!_dateView) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight)];
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.alpha = 0.3;

        titleArray = @[];
        titleArray = shengarray;
        self.dateView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWindowHeight, ScreenWindowWidth, 240*HEIGHT)];
        self.dateView.backgroundColor = [UIColor whiteColor];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnclink) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
        [self.dateView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.dateView);
            make.size.mas_equalTo(CGSizeMake(80*WIDTH, 40*HEIGHT));
        }];
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
        [sureBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(okBtnClink) forControlEvents:UIControlEventTouchUpInside];
        [self.dateView addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self.dateView);
            make.size.mas_equalTo(CGSizeMake(80*WIDTH, 40*HEIGHT));
        }];

        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40*HEIGHT, ScreenWindowWidth, 200*HEIGHT)];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.backgroundColor = LYColor_A7;
        [self.dateView addSubview:pickerView];
        
        
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.bgView];
        [window addSubview:self.dateView];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView.y = ScreenWindowHeight - 240*HEIGHT;
        }];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return titleArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    title = titleArray[row];
    self.selectDate = title;
    self.index = row;
    return title;
}

- (void)cancelBtnclink {
    [UIView animateWithDuration:0.5 animations:^{
        self.dateView.y = ScreenWindowHeight;
    }completion:^(BOOL finished) {
        [self.dateView removeFromSuperview];
        self.dateView = nil;
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
}
- (void)okBtnClink {
    self.block(self.selectDate,self.index);
    [self cancelBtnclink];
}

- (void)PickerViewBackSelectBlock:(PickerViewBlock)block{
    self.block = block;
}
@end
