//
//  WQAlertView.m
//  GreatWall
//
//  Created by GJ on 2017/3/15.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "WQAlertView.h"
#import "Header.h"

@implementation WQAlertView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self addSubview:self.alphBackView];
    [self addSubview:self.alertBackView];
    [self bringSubviewToFront:self.alertBackView];
    [self.alertBackView addSubview:self.titleLabel];
    [self.alertBackView addSubview:self.cancelBtn];
    [self.alertBackView addSubview:self.textField];
    [self.alertBackView addSubview:self.line];
    [self.alertBackView addSubview:self.forgetPSWBtn];
    [self.alertBackView addSubview:self.queRenBtn];
    
    [self.alphBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    [self.alertBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
//        make.centerY.mas_equalTo(0);
        make.top.mas_equalTo(180*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(329*WIDTH, 264*HEIGHT));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(33*HEIGHT);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(12*HEIGHT);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13*HEIGHT);
        make.right.mas_equalTo(-13*WIDTH);
        make.size.mas_equalTo(CGSizeMake(13*HEIGHT, 13*HEIGHT));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(55*HEIGHT);
        make.centerX.mas_equalTo(self.alertBackView);
        make.size.mas_equalTo(CGSizeMake(130*WIDTH, 18*HEIGHT));
//        make.left.mas_equalTo(23*WIDTH);
//        make.right.mas_equalTo(-23*WIDTH);
//        make.height.mas_equalTo(18*HEIGHT);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23*WIDTH);
        make.right.mas_equalTo(-23*WIDTH);
        make.top.mas_equalTo(self.textField.mas_bottom).offset(13*HEIGHT);
        make.height.mas_equalTo(1*HEIGHT);
    }];
    [self.forgetPSWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(18*HEIGHT);
        make.right.mas_equalTo(-23*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 12*HEIGHT));
    }];
    [self.queRenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.forgetPSWBtn.mas_bottom).offset(31*HEIGHT);
        make.centerX.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(283*WIDTH, 44*HEIGHT));
    }];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    return 1;
//}


- (void)guanBi:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(AlertCancelBtn:)]) {
        [self.delegate AlertCancelBtn:sender];
    }
}

- (void)forgetPSW:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(AlertForgetPSWBtn:)]) {
        [self.delegate AlertForgetPSWBtn:sender];
    }
}

- (void)queRen{
    if ([self.delegate respondsToSelector:@selector(WQAlertTextField:)]) {
        [self.delegate WQAlertTextField:self.textField.text];
    }
}

- (void)showView{
    self.textField.text = @"";
    [self.textField becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}
- (void)hideView{
    [self.textField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}


- (UIView *)alphBackView{
    if (!_alphBackView) {
        _alphBackView = [[UIView alloc]init];
        _alphBackView.backgroundColor = [UIColor blackColor];
        _alphBackView.backgroundColor = UIColorRGBA(51, 51, 51, 0.7);
    }
    return _alphBackView;
}

- (UIView *)alertBackView{
    if (!_alertBackView) {
        _alertBackView = [[UIView alloc]init];
        _alertBackView.layer.cornerRadius = 4;
        _alertBackView.backgroundColor = [UIColor whiteColor];
    }
    return _alertBackView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = LYColor_A3;
        _titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"请输入支付密码";
    }
    return _titleLabel;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(guanBi:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"请输入支付密码";
        _textField.delegate = self;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.font = [UIFont systemFontOfSize:18*HEIGHT];
        _textField.secureTextEntry = YES;
    }
    return _textField;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = LYColor_A6;
    }
    return _line;
}

- (UIButton *)forgetPSWBtn{
    if (!_forgetPSWBtn) {
        _forgetPSWBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPSWBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        _forgetPSWBtn.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        [_forgetPSWBtn addTarget:self action:@selector(forgetPSW:) forControlEvents:UIControlEventTouchUpInside];
        [_forgetPSWBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPSWBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _forgetPSWBtn;
}

- (UIButton *)queRenBtn{
    if (!_queRenBtn) {
        _queRenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_queRenBtn setBackgroundColor:LYColor_A1];
        [_queRenBtn setTitle:@"确认" forState:UIControlStateNormal];
        _queRenBtn.layer.cornerRadius = 4;
        [_queRenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_queRenBtn addTarget:self action:@selector(queRen) forControlEvents:UIControlEventTouchUpInside];
    }
    return _queRenBtn;
}


@end
