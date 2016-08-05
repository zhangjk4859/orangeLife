//
//  HPTabBarVC.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/5.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPTabBarVC.h"
#import "HPFoodVC.h"
#import "HPNewsVC.h"
@interface HPTabBarVC ()

@end

@implementation HPTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.加载两个子控制器
    [self loadChildViewControllers];
    
    
}

//1.加载两个子控制器
-(void)loadChildViewControllers
{
    [self setupChildVC:[[HPFoodVC alloc] init] WithTitle:@"美食" image:@"menu_ico_center" selectedImage:@"menu_ico_center_on"];
    [self setupChildVC:[[HPNewsVC alloc] init] WithTitle:@"新闻" image:@"menu_ico_find" selectedImage:@"menu_ico_find_on"];
}

//抽出来的方法，统一设置四个子控制器
-(void)setupChildVC:(UIViewController *)VC WithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //顶部底部标题与图片(原图呈现)
    VC.navigationItem.title = title;
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self addChildViewController:nav];
}



@end
