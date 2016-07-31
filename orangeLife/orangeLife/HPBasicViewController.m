//
//  HPBasicViewController.m
//  orangeLife
//
//  Created by 张俊凯 on 16/7/30.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPBasicViewController.h"

//引入四个子控制器
#import "HPFoodVC.h"
#import "HPNewsVC.h"
#import "HPFinanceVC.h"
#import "HPGossipyVC.h"

//引入芝麻信用
#import <ZMCreditSDK/ALCreditService.h>

//常量，只读,tag标识
NSUInteger const basicTag = 100;

@interface HPBasicViewController ()<UIScrollViewDelegate>
//顶部标题视图
@property(nonatomic,weak)UIView *titleView;
//按钮指示条
@property(nonatomic,weak)UIView *indicatorView;
//记录按钮可用状态
@property(nonatomic,weak)UIButton *selectedButton;
//视图内的滚动视图
@property(nonatomic,weak)UIScrollView *scrollView;

@end

@implementation HPBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //0. 设置子控制器
    [self setupChildVC];
    
    //1.创建子视图控件
    [self setupUI];
    
    //2.设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = JKNavBarColor;
    
    
    
}

//1.创建子视图控件
-(void)setupUI
{
    //1.创建顶部标题栏视图
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0,statusBarHeight + navBarHeight, JKScreenW, titleViewHeight);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor cyanColor];
    
    //2. 添加指示条
    NSInteger font = 14;
    NSArray *titles = @[@"美食",@"新闻",@"金融",@"八卦"];
    //2.1 根据标题算出宽度
    NSString *firstTitle = titles[0];
    NSDictionary *attrsDic =@{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize firstTilteSize = [firstTitle sizeWithAttributes:attrsDic];
    CGFloat indicatorWidth = firstTilteSize.width;
    CGFloat indicatorHeight = 2;
    //2.2 创建指示器视图
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor orangeColor];
    indicatorView.size = CGSizeMake(indicatorWidth, indicatorHeight);
    indicatorView.y = titleViewHeight - indicatorHeight;
    indicatorView.centerX = JKScreenW / titles.count * 0.5;
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
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        btn.x = i * btnWidth;
        btn.width = btnWidth;
        btn.height = titleViewHeight;
        btn.tag = basicTag + i;
        [titleView addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //默认第一个按钮点击
        if (i == 0) {
            btn.enabled = NO;
            self.selectedButton = btn;
        }
    }
    
    //4.添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat scrollViewY = CGRectGetMaxY(titleView.frame);
    scrollView.x = 0;
    scrollView.y = scrollViewY;
    scrollView.width = JKScreenW;
    scrollView.height = JKScreenH - scrollViewY;
    scrollView.contentSize = CGSizeMake(JKScreenW * titles.count, scrollView.height);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    self.scrollView = scrollView;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    //默认加载第一页视图
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

//按钮点击事件
-(void)btnClick:(UIButton *)btn
{
    //1.更换按钮的状态
    self.selectedButton.enabled = YES;
    self.selectedButton = btn;
    btn.enabled = NO;
    

    //2.指示条宽度适应标题按钮
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = btn.titleLabel.width;
    }];
    
    //3.添加对应的子视图
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = (btn.tag - basicTag) * JKScreenW;
    [self.scrollView setContentOffset:offset animated:YES];
    
}

//0. 设置子控制器
-(void)setupChildVC
{
    NSString *vcClass = @"vcClass";
    NSArray *vcArray = @[  @{vcClass:[HPFoodVC class]},
                           @{vcClass:[HPNewsVC class]},
                           @{vcClass:[HPFinanceVC class]},
                           @{vcClass:[HPGossipyVC class]}
                           ];
    for (int i = 0; i < vcArray.count; i++) {
        NSDictionary *infoDic = vcArray[i];
        UIViewController *vc = [[[infoDic objectForKey:vcClass] alloc] init];
        [self addChildViewController:vc];
    }
    
}

#pragma mark scrollView Delagate
//点击按钮，添加视图
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidScroll:scrollView];
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.size = scrollView.size;
    [scrollView addSubview:vc.view];
}

//滑动视图添加子视图
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滑动添加子视图
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //让按钮跟随发生改变
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *btn = (UIButton *)[self.titleView viewWithTag:basicTag + index];
    [self btnClick:btn];
    
}

//让指示条随着scrollView滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.指示条左边固定的间隙
    CGFloat gap = JKScreenW / self.childViewControllers.count *0.5;
    
    //2.指示条实时滑动
    self.indicatorView.centerX = gap + scrollView.width * scrollView.contentOffset.x / scrollView.contentSize.width;
    
}


@end
