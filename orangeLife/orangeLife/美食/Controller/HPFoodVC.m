//
//  HPFoodVC.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/5.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPFoodVC.h"

@interface HPFoodVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@end

@implementation HPFoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1.设置tabbar
    [self setupTabBar];
    //2.设置首页logo
    [self createHomeTitleView];
    
    //3.设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //4.设置表格视图
    //[self setupTableView];
    //5.网络加载数据
    [self downloadData];
    
    
}
//1.设置tabbar
-(void)setupTabBar
{
    //选中是绿色
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : JKRGBColor(116, 165, 0)} forState:UIControlStateSelected];
    
    //未选中是深灰色
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : JKRGBColor(170, 170, 170)} forState:UIControlStateNormal];
}
//2.设置首页logo
-(void)createHomeTitleView
{
    UIImage *navImg = [UIImage imageNamed:@"system_logo"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, navImg.size.width, navImg.size.height)];
    imgView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height /2);
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [imgView setImage:navImg];
    self.navigationItem.titleView = imgView;
}
//4.设置表格视图
-(void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JKScreenW, JKScreenH - normalHeight)];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
}
//5.网络加载数据
-(void)downloadData
{
    NSString *urlString = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=&method=Search.getHotSearch&sessionid=1422278993&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    NSDictionary *parameters = @{@"sign":@"",@"uid":@"",@"uuid":@"17EF523E05B42597F70A95681590F28B"};
    
    [[HPHttpManager shareManager] getReqWithBaseUrlStr:urlString surfixUrlStr:nil params:parameters success:^(NSDictionary *responseObject) {
        JKLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        JKLog(@"%@",error);
    }];
    
}
#pragma mark <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    }
    else
        return 3;
    
}

#pragma mark 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 270;
    }
    else
        return 65;
    
}

//设置header在不同section中的高度
#pragma mark 设置section的头部和尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 250;
    }
    else
        return 45;
    
}

@end
