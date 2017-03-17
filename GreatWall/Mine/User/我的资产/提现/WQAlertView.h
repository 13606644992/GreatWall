//
//  WQAlertView.h
//  GreatWall
//
//  Created by GJ on 2017/3/15.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WQAlertViewDelegate <NSObject>

- (void)WQAlertTextField:(NSString *)textField;
- (void)AlertCancelBtn:(UIButton *)sender;
- (void)AlertForgetPSWBtn:(UIButton *)sender;
- (void)queRenAction:(UIButton *)sender;

@end

@interface WQAlertView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIView *alphBackView;

@property (nonatomic, strong) UIView *alertBackView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *forgetPSWBtn;

@property (nonatomic, strong) UIButton *queRenBtn;

@property (nonatomic, weak) id<WQAlertViewDelegate>delegate;

- (void)showView;
- (void)hideView;

@end
