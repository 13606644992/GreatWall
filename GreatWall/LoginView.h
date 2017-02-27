//
//  loginView.h
//  GreatWall
//
//  Created by GJ on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView<UITextFieldDelegate>

@property (nonatomic, strong, nonnull)UIImageView *logoIMGView;
@property (nonatomic, strong, nonnull)UIImageView *titleIMGView;
@property (nonatomic, strong, nonnull)UIView *backgroundView;
@property (nonatomic, strong, nonnull)UITextField *phoneNum;
@property (nonatomic, strong, nonnull)UITextField *codeNum;
@property (nonatomic, strong, nonnull)UIButton *btn;
@property (nonatomic, strong, nonnull)UIButton *codeBtn;
@property (nonatomic, strong, nonnull)UIButton *loginBtn;
@property (nonatomic, strong, nonnull)NSTimer *myTimer;
@property (nonatomic, assign)NSInteger currentcountDown;
//@property (nonatomic, strong, nonnull)UILabel *timeLabel;
- (instancetype)init;
@end
