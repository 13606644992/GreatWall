//
//  IdeaVC.m
//  GreatWall
//
//  Created by GJ on 2017/3/2.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "IdeaVC.h"
#import "Header.h"

@interface IdeaVC ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *textViewPlaceholderLabel;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation IdeaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    
    UIView *backgroung = [[UIView alloc]init];
    backgroung.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroung];
    [backgroung mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(18*HEIGHT);
        make.height.mas_equalTo(172*HEIGHT);
    }];
    
    //1、在UITextView上加上一个UILabel
    self.textViewPlaceholderLabel = [[UILabel alloc] init];
    NSString *text = @"感谢您对汇保险的关注与支持，您的宝贵意见将帮助我们不断进步，谢谢！";
    self.textViewPlaceholderLabel.textColor = LYColor_A5;
//    self.textViewPlaceholderLabel.backgroundColor = [UIColor redColor];
    self.textViewPlaceholderLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    self.textViewPlaceholderLabel.numberOfLines = 0;
    [backgroung addSubview: self.textViewPlaceholderLabel];
    
    [self.textViewPlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(20*HEIGHT);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(50*HEIGHT);
    }];
//    [self.textViewPlaceholderLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:11*HEIGHT];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.textViewPlaceholderLabel.attributedText = attributedString;

    //textView
    self.textView = [[UITextView alloc]init];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.font = [UIFont systemFontOfSize:14*HEIGHT];
    self.textView.layer.borderWidth = 1.0f;
    self.textView.layer.borderColor = [UIColor clearColor].CGColor;
    [backgroung addSubview: self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*WIDTH);
        make.top.mas_equalTo(16*HEIGHT);
        make.right.mas_equalTo(-15*WIDTH);
        make.height.mas_equalTo((172- 16)*HEIGHT);
    }];
    //textview行间距、字体大小
    NSMutableAttributedString *textAttributedString = [[NSMutableAttributedString alloc]initWithString:self.textView.text];;
    NSMutableParagraphStyle *textParagraphStyle = [[NSMutableParagraphStyle alloc]init];
    textParagraphStyle.lineSpacing = 11*HEIGHT;
    [textAttributedString addAttribute:NSParagraphStyleAttributeName value:textParagraphStyle range:NSMakeRange(0, self.textView.text.length)];
    self.textView.attributedText = textAttributedString;
    
    UIButton *tiJiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tiJiaoBtn.backgroundColor = LYColor_A1;
    [tiJiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tiJiaoBtn.layer.cornerRadius = 4.0f;
    tiJiaoBtn.clipsToBounds = YES;
    [tiJiaoBtn addTarget:self action:@selector(tiJiaoBtnAcion:) forControlEvents:UIControlEventTouchUpInside];
    [tiJiaoBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:tiJiaoBtn];
    
    [tiJiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backgroung.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44 *HEIGHT);
    }];
    
    
}
//设置textView的placeholder

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //[text isEqualToString:@""] 表示输入的是退格键
    if (![text isEqualToString:@""]){
        self.textViewPlaceholderLabel.hidden = YES;
    }
    //range.location == 0 && range.length == 1 表示输入的是第一个字符
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        self.textViewPlaceholderLabel.hidden = NO;
    }
    
    return YES;
}

#pragma mark - 提交
- (void)tiJiaoBtnAcion:(UIButton *)sender{
    
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
