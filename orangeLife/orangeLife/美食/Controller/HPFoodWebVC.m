//
//  HPFoodWebVC.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/5.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPFoodWebVC.h"
#import "HPCommentVC.h"

@interface HPFoodWebVC ()
{
    UIWebView *_webView;
    NSArray *_webArr;
}

@end

@implementation HPFoodWebVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.tintColor = JKRGBColor(116, 165, 0) ;
    
}


- (id)initWithIndex:(NSUInteger)index
{
    self = [super init];
    if (self) {
        self.index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    JKLog(@"webindex%ld",self.index);
    
    [self creatRightBtns];
    
    
    _webView = [[UIWebView alloc] init];
    _webView.frame = CGRectMake(0, 0, JKScreenW,JKScreenH);
    [self.view addSubview:_webView];
    _webArr = [NSArray array];
    _webArr = @[@"http://m.haodou.com/topic-323324.html",@"http://group.haodou.com/topic-324153.html",@"http://group.haodou.com/topic-321447.html",@"http://m.haodou.com/topic-176619.html",@"http://m.haodou.com/topic-323072.html",@"http://group.haodou.com/topic-324608.html",@"http://group.haodou.com/topic-278170.html"];
    
    NSString *urlStr = (NSString *)[_webArr objectAtIndex:self.index];
    //    NSString *urlStr = @"http://m.haodou.com/topic-323324.html";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    
}
- (void)creatRightBtns
{
    NSMutableArray *btnArr = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIButton *favorBtn = [[UIButton alloc] init];
    UIImage *favorImg = [UIImage imageNamed:@"ico_menu_favorites.png"];
    [favorBtn setBackgroundImage:favorImg forState:UIControlStateNormal];
    //颜色在点击后修改
    [favorBtn setBackgroundImage:[UIImage imageNamed:@"ico_topfavorites_over.png"] forState:UIControlStateSelected];
    favorBtn.frame = CGRectMake(0, 0, favorImg.size.width, favorImg.size.height);
    [favorBtn addTarget:self action:@selector(favorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *favorBtnItem = [[UIBarButtonItem alloc] initWithCustomView:favorBtn];
    [btnArr addObject:favorBtnItem];
    
    UIButton *commentBtn = [[UIButton alloc] init];
    UIImage *commentImg = [UIImage imageNamed:@"ico_topcomment.png"];
    [commentBtn setBackgroundImage:commentImg forState:UIControlStateNormal];
    commentBtn.frame = CGRectMake(0, 0, commentImg.size.width, commentImg.size.height);
    [commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *commentBtnItem = [[UIBarButtonItem alloc] initWithCustomView:commentBtn];
    [btnArr addObject:commentBtnItem];
    
    UIButton *topshareBtn = [[UIButton alloc] init];
    UIImage *topshareImg = [UIImage imageNamed:@"ico_topshare.png"];
    [topshareBtn setBackgroundImage:topshareImg forState:UIControlStateNormal];
    topshareBtn.frame = CGRectMake(0, 0, topshareImg.size.width, topshareImg.size.height);
    [topshareBtn addTarget:self action:@selector(topshareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *topshareBtnItem = [[UIBarButtonItem alloc] initWithCustomView:topshareBtn];
    [btnArr addObject:topshareBtnItem];
    
    UIToolbar *customToolbar = [[UIToolbar alloc]
                                initWithFrame:CGRectMake(0.0f, 0.0f, 120, 44.0f)];
    
    customToolbar.clearsContextBeforeDrawing = NO;
    customToolbar.clipsToBounds = NO;
    customToolbar.tintColor = [UIColor colorWithWhite:0.305f alpha:0.0f];
    customToolbar.barStyle = -1;
    [customToolbar setItems:btnArr animated:NO];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customToolbar];
    
}

- (void)favorBtnClick:(UIButton *)btn
{
    JKLog(@"favorBtnClick");
    [btn setImage:[UIImage imageNamed:@"ico_topfavorites_over.png"] forState:UIControlStateSelected];
    
    
}

- (void)commentBtnClick:(UIButton *)btn
{
    JKLog(@"commentBtnClick");
    //评论
    HPCommentVC *commentVC = [[HPCommentVC alloc] init];
    [self.navigationController pushViewController:commentVC animated:NO];
}

- (void)topshareBtnClick:(UIButton *)btn
{
    JKLog(@"topshareBtnClick");
    
}




@end
