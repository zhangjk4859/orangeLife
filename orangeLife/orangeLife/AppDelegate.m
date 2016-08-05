//
//  AppDelegate.m
//  orangeLife
//
//  Created by 张俊凯 on 16/7/30.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "AppDelegate.h"
#import "HPBasicViewController.h"
#import "HPTabBarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //2.创建根控制器
    //2.1创建视图
    HPTabBarVC *tabBarVC = [[HPTabBarVC alloc] init];
    self.window.rootViewController = tabBarVC;
    
    
    return YES;
}



@end
