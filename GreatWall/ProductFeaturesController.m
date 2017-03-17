//
//  ProductFeaturesController.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/11.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ProductFeaturesController.h"
#import "Header.h"

@interface ProductFeaturesController ()<WKNavigationDelegate>
/*
 *  WKWebView
 */
@property (nonatomic ,strong)  WKWebView *webView;

@end

@implementation ProductFeaturesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYColor_A7;

    [self setProductFeaturesTopView];
    [self.view addSubview:self.webView];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.32.152:8080/views/ahealthNotice.html&productId=%@",self.productId]]]];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)setProductFeaturesTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 120, 17*HEIGHT)];
    titleLab.text = @"产品特色";
    titleLab.center = CGPointMake(ScreenWindowWidth/2, titleLab.center.y);
    titleLab.font = [UIFont systemFontOfSize:17*WIDTH];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = LYColor_A1;
    [topView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(18*WIDTH,33,10, 17.5);
    [backBtn addTarget:self action:@selector(productFeaturesbackClick) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:backBtn];
   
}
-(void)productFeaturesbackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - WKWebView WKNavigationDelegate 相关
/// 是否允许加载网页 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    
    urlString = [urlString stringByRemovingPercentEncoding];
    NSLog(@"urlString=%@",urlString);
    // 用://截取字符串
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        // 获取协议头
        NSString *protocolHead = [urlComps objectAtIndex:0];
        NSLog(@"protocolHead=%@",protocolHead);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}
#pragma mark ---------Controller--------
-(WKWebView *)webView{
    if (!_webView) {
        _webView  = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWindowWidth, ScreenWindowHeight-64)];
        _webView.navigationDelegate= self;
    }
    return _webView;
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
