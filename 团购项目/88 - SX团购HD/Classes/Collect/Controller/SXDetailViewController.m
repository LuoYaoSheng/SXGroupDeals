//
//  SXDetailViewController.m
//  88 - SX团购HD
//
//  Created by 董 尚先 on 15/2/7.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXDetailViewController.h"
#import "SXDeal.h"
#import "UIView+AutoLayout.h"

@interface SXDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, weak) UIActivityIndicatorView *loadingView;
@end

@implementation SXDetailViewController

#pragma mark - ******************** 懒加载
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.webView addSubview:loadingView];
        
        // 居中
        [loadingView autoCenterInSuperview];
        self.loadingView = loadingView;
    }
    return _loadingView;
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 10, 0);
    
    // 开始转圈圈
    [self.loadingView startAnimating];
    
    // 隐藏
    self.webView.scrollView.hidden = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
    
}

#pragma mark - ******************** 设置当前设备支持哪几个方向
//- (NSUInteger)supportedInterfaceOrientations
//{
//    //    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//    // 这两个不一样要分清
//    //    }
//    return UIInterfaceOrientationMaskLandscapeLeft;
//}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType //受否允许他发请求
//{
//    return YES;
//}

#pragma mark - ******************** webView加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([webView.request.URL.absoluteString isEqualToString:self.deal.deal_h5_url]) {// $$$$$
        // 截取id
        NSString *ID = [self.deal.deal_id substringFromIndex:2];
        NSString *url = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }else {
        // 加载详情完毕
        // 执行JS删掉不需要的节点
        NSString *js = @"document.getElementsByTagName('header')[0].remove();"
        "document.getElementsByClassName('cost-box')[0].remove();"
        "document.getElementsByClassName('buy-now')[0].remove();";
        [webView stringByEvaluatingJavaScriptFromString:js];
        
        [self.loadingView stopAnimating];
        
        self.webView.scrollView.hidden = NO;
    }
}

@end
