//
//  HPBasicViewController.m
//  orangeLife
//
//  Created by 张俊凯 on 16/7/30.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPBasicViewController.h"

@interface HPBasicViewController ()
//按钮指示条
@property(nonatomic,weak)UIView *indicatorView;
//第一个按钮的标题宽度
@property(nonatomic,weak)UIButton *firstBtn;

@end

@implementation HPBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //1.创建子视图控件
    [self setupUI];
    
    //2.设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = JKNavBarColor;
    self.navigationController.navigationBar.translucent = YES;
    
}

//1.创建子视图控件
-(void)setupUI
{
    //1.创建顶部标题栏视图
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0,statusBarHeight + navBarHeight, JKScreenW, titleViewHeight);
    [self.view addSubview:titleView];
    titleView.backgroundColor = [UIColor cyanColor];
    
    //2.添加指示条
    NSInteger font = 14;
    NSArray *titles = @[@"美食",@"新闻",@"金融",@"八卦"];
    //2.1 根据标题算出宽度
    NSString *firstTitle = titles[0];
    NSDictionary *attrsDic =@{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize firstTilteSize = [firstTitle sizeWithAttributes:attrsDic];
    CGFloat indicatorWidth = firstTilteSize.width;
    //2.2 创建指示器视图
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.size = CGSizeMake(indicatorWidth, 1);
    indicatorView.y = titleViewHeight - 1;
    indicatorView.centerX = JKScreenW / titles.count *0.5;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    
    
    //3.添加按钮
    CGFloat btnWidth = JKScreenW / titles.count;
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.textColor = [UIColor blackColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:font];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        btn.x = i * btnWidth;
        btn.width = btnWidth;
        btn.height = titleViewHeight;
        [titleView addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    
}

//按钮点击事件
-(void)btnClick:(UIButton *)btn
{
    //指示条跟按钮联动
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.width =  btn.titleLabel.width;
        self.indicatorView.x = btn.x + btn.titleLabel.x;
    }];
    
}


@end
