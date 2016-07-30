//
//  AppDelegate.m
//  orangeLife
//
//  Created by 张俊凯 on 16/7/30.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "AppDelegate.h"
#import "HPBasicViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //2.创建根控制器
    //2.1创建视图
    HPBasicViewController *basicVC = [[HPBasicViewController alloc] init];
    //2.2创建导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:basicVC];
    self.window.rootViewController = nav;
    
    
    return YES;
}



@end
