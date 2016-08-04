//
//  HPNewsViewController.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/3.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPNewsViewController.h"
#import "REMenu.h"
#import "UIBarButtonItem+HPExtension.h"
#import "HPWebViewVC.h"
@interface HPNewsViewController ()
@property (nonatomic, strong) REMenu *menu;
@end

#define baiduNewUrl @"http://news.baidu.com"
#define fengNewUrl @"http://3g.ifeng.com"
#define sinaNewUrl @"http://news.sina.cn"
#define tencenNewUrl @"http://info.3g.qq.com"
#define wangyiNewUrl @"http://3g.163.com"
#define souhuNewsUrl @"http://news.sohu.com/"
#define toutiaoNewsUrl @"http://m.toutiao.com/"
#define baiduSearchUrl @"http://m.baidu.com/"

@implementation HPNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景
    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"audionews_play_bg_morning.jpg"]];
    backgroundView.frame = self.view.bounds;
    [self.view addSubview:backgroundView];
    // 设置menuview
    [self setupMenuView];
}

#pragma mark 设置menuview
- (void)setupMenuView
{
    // 消除block强引用
    __typeof (self) __weak weakSelf = self;
    REMenuItem *baiduItem = [[REMenuItem alloc] initWithTitle:@"百度新闻"
                                                     subtitle:@"全球最大的中文新闻平台"
                                                        image:nil
                                             highlightedImage:nil
                                                       action:^(REMenuItem *item) {
                                                           [weakSelf pushViewControllerWithUrl:baiduNewUrl];
                                                       }];
    REMenuItem *fengItem = [[REMenuItem alloc] initWithTitle:@"凤凰新闻"
                                                    subtitle:@"24小时提供最及时，最权威，最客观的新闻资讯"
                                                       image:nil
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          [weakSelf pushViewControllerWithUrl:fengNewUrl];
                                                      }];
    REMenuItem *sinaItem = [[REMenuItem alloc] initWithTitle:@"新浪新闻"
                                                    subtitle:@"最新，最快头条新闻一网打尽"
                                                       image:nil
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          [weakSelf pushViewControllerWithUrl:sinaNewUrl];
                                                      }];
    REMenuItem *tencenItem = [[REMenuItem alloc] initWithTitle:@"腾讯新闻"
                                                      subtitle:@"中国浏览最大的中文门户网站"
                                                         image:nil
                                              highlightedImage:nil
                                                        action:^(REMenuItem *item) {
                                                            [weakSelf pushViewControllerWithUrl:tencenNewUrl];
                                                        }];
    REMenuItem *wangyiItem = [[REMenuItem alloc] initWithTitle:@"网易新闻"
                                                      subtitle:@"因新闻最快速，评论最犀利而备受推崇"
                                                         image:nil
                                              highlightedImage:nil
                                                        action:^(REMenuItem *item) {
                                                            [weakSelf pushViewControllerWithUrl:wangyiNewUrl];
                                                        }];
    REMenuItem *souhuItem = [[REMenuItem alloc] initWithTitle:@"搜狐新闻"
                                                      subtitle:@"提供及时的新闻评论，原创爆料"
                                                        image:nil
                                              highlightedImage:nil
                                                        action:^(REMenuItem *item) {
                                                            [weakSelf pushViewControllerWithUrl:souhuNewsUrl];
                                                        }];
    REMenuItem *toutiaoItem = [[REMenuItem alloc] initWithTitle:@"今日头条"
                                                     subtitle:@"你的关心，才是头条！"
                                                        image:nil
                                             highlightedImage:nil
                                                       action:^(REMenuItem *item) {
                                                           [weakSelf pushViewControllerWithUrl:toutiaoNewsUrl];
                                                       }];
    REMenuItem *baiduSearchItem = [[REMenuItem alloc] initWithTitle:@"百度搜索"
                                                       subtitle:nil
                                                          image:nil
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             [weakSelf pushViewControllerWithUrl:baiduSearchUrl];
                                                         }];
    
    
    self.menu = [[REMenu alloc] initWithItems:@[fengItem, baiduItem, sinaItem, tencenItem, wangyiItem,souhuItem,toutiaoItem,baiduSearchItem]];
    self.menu.liveBlur = YES;
    self.menu.liveBlurBackgroundStyle = REMenuLiveBackgroundStyleDark;
    self.menu.textColor = [UIColor whiteColor];
    self.menu.subtitleTextColor = [UIColor whiteColor];
    
    [self.menu showInView:self.view];
    
}

- (void)pushViewControllerWithUrl:(NSString *)url
{
    //推出一个webView控制器
    HPWebViewVC *webVC = [[HPWebViewVC alloc] init];
    webVC.link = url;
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.menu showInView:self.view];
    
}

@end
