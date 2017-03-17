//
//  LGLDatePickerView.m
//  LGLProgress
//
//  Created by ** on 2017/3/10.
//  Copyright © 2017年 **. All rights reserved.
//

#import "LGLDatePickerView.h"
#import "UIView+Frame.h"
#import "LYColor.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define LGLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface LGLDatePickerView ()

@property (nonatomic, strong) UIView       * bgView;
@property (nonatomic, strong) UIView       * dateView;
@property (nonatomic, strong) UIDatePicker * datePicker;
@property (nonatomic, copy)   NSString     * selectDate;

@end

@implementation LGLDatePickerView

    static id _instace;
+ (instancetype)shareDatePiker
{
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

- (void)datePikerShowWithMode:(LGLDatePickerrMode)mode {
    if (!self.dateView) {
        self.dateView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 240)];
        self.dateView.userInteractionEnabled = YES;
        self.dateView.backgroundColor = [UIColor whiteColor];
        
//  ============================= 添加分界线 =======================================================================
        UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
        lineView1.backgroundColor = [LYColor colorWithHexString:@"#e3e3e3"];
        [self.dateView addSubview:lineView1];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, 1)];
        lineView.backgroundColor = [LYColor colorWithHexString:@"#e3e3e3"];
        [self.dateView addSubview:lineView];
        

//  =====================  添加确定取消按钮  =========================================================================
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(10, 5, 50, 30);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.userInteractionEnabled = YES;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14*([UIScreen mainScreen].bounds.size.width / 375)];
        [cancelBtn addTarget:self action:@selector(cancelBtnclink) forControlEvents:UIControlEventTouchUpInside];
        [self.dateView addSubview:cancelBtn];
        
        UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        okBtn.frame = CGRectMake(WIDTH - 60, 5, 50, 30);
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        okBtn.titleLabel.font = [UIFont systemFontOfSize:14*([UIScreen mainScreen].bounds.size.width / 375)];
        [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(okBtnClink) forControlEvents:UIControlEventTouchUpInside];
        [self.dateView addSubview:okBtn];
        
// ====================  初始化UIDatePicker，旋转滚动选择日期类  =======================================================
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, WIDTH, 200)];
        [self.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        [self.datePicker setTimeZone:[NSTimeZone localTimeZone]];           // 设置时区
        [self.datePicker setDate:[NSDate date] animated:YES];                // 设置当前显示时间
        self.datePicker.backgroundColor = [UIColor whiteColor];
        //[datePicker setMaximumDate:[NSDate date]];                        // 设置显示最大时间（此处为当前时间）最大和最小同时设置就不能选择未来的时间
        UIDatePickerMode  pikcerMode = (mode == LGLDatePickerModeDate) ? (UIDatePickerModeDate) : ((mode == LGLDatePickerModeDateAndTime) ? UIDatePickerModeDateAndTime : ((mode == LGLDatePickerModeTime) ? UIDatePickerModeTime : UIDatePickerModeCountDownTimer));
        [self.datePicker setDatePickerMode:pikcerMode];    // 设置UIDatePicker的显示模式
        [self.datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.dateView addSubview:self.datePicker];
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [UIView animateWithDuration:0.5 animations:^{
            self.dateView.y = HEIGHT - 240;
        }];
        [window addSubview:self.dateView];
        self.selectDate = [self dateToStringWithDate:[NSDate date]];        // 防止用户不选择日期直接选择确定
    }
}

- (void)cancelBtnclink {
    [UIView animateWithDuration:0.5 animations:^{
        self.dateView.y = HEIGHT;
    }completion:^(BOOL finished) {
        [self.dateView removeFromSuperview];
         self.dateView = nil;
    }];
}

- (void)dateCallBackSelectBlock:(DateSelectBlock)block {
    self.block = block;
}

- (void)okBtnClink {
    self.block(self.selectDate);
    [self cancelBtnclink];
}

- (void)datePickerValueChanged:(UIDatePicker *)datepiker {
    self.selectDate = [self dateToStringWithDate:[datepiker date]];
}

- (NSString *)dateToStringWithDate:(NSDate *)selectDate {
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
//    selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss"; // 设置时间和日期的格式
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式

    NSString * dateAndTime = [selectDateFormatter stringFromDate:selectDate]; // 把date类型转为设置好格式的string类型
    return dateAndTime;
}
                           
@end
