//
//  HPWebViewVC.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/2.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPWebViewVC.h"

@interface HPWebViewVC ()

@end

@implementation HPWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
}

-(void)setupWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.link]];
    [webView loadRequest:request];
    
}


@end
