//
//  HPFoodVC.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/5.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPFoodVC.h"
#import "HPHomeModel.h"
#import "HPWebViewVC.h"
#import "HPFoodWebVC.h"

@interface HPFoodVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    HPHomeModel *_homeModel;
    NSMutableArray *_arrayData;
    NSMutableArray *_dataArray;
    UIPageControl *_pageController;
    //EScrollerView *_scrollView;
    NSArray *_albumArray;
    NSArray *_recipeArray;
    NSArray *_wikiArray;
    NSArray *_tableArray;
    NSArray *_rankArray;
    NSArray *_tagArray;
    NSMutableArray *_imgArray;
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
    [self setupTableView];
    //5.获取数据
    [self loadData];
    
    
    
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
//5.获取数据
-(void)loadData
{
    //可以获取到数据了
    _homeModel = [[HPHomeModel alloc] init];
    [_homeModel refreshData:^(BOOL isSucess, NSMutableArray *dataDic) {
        if (isSucess) {
            _arrayData = [dataDic mutableCopy];
            [_tableView reloadData];
            
        }
        JKLog(@"_arrayData%@",_arrayData);
        
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
        return JKScreenH * 0.5;
    }
    else
        return 65;
    
}

//设置header在不同section中的高度
#pragma mark 设置section的头部和尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return JKScreenH * 0.5;
    }
    else
        return 45;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell2 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell3 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell4 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (cell1.tag == 5 || cell1.tag == 6) {
            HPFoodWebVC *webVC = [[HPFoodWebVC alloc] init];
            webVC.index =cell1.tag;
            [self.navigationController pushViewController:webVC animated:NO];
        }
        //开始创建  AlbumViewControllerVC,逐个创建
//        else if (cell1.tag == 1000) {
//            AlbumViewController *albumVC = [[AlbumViewController alloc] init];
//            [self.navigationController pushViewController:albumVC animated:NO];
//        }
//        else if( cell3.tag == 1)
//        {
//            RecipeTableViewController *recipeVC = [[RecipeTableViewController alloc] init];
//            recipeVC.index = cell3.tag;
//            
//            [self.navigationController pushViewController:recipeVC animated:NO];
//        }else if(cell2.tag == 0 || cell2.tag == 2 || cell2.tag == 3 || cell2.tag == 4)    {
//            RecipeTableViewController *recipeVC = [[RecipeTableViewController alloc] init];
//            recipeVC.index = cell2.tag;
//            [self.navigationController pushViewController:recipeVC animated:NO];
//        }else if(indexPath.row == 7)
//        {
//            RecipeTableViewController *recipeVC = [[RecipeTableViewController alloc] init];
//            recipeVC.index = indexPath.row - 2;
//            
//            [self.navigationController pushViewController:recipeVC animated:NO];
//        }
//        
//    }
//    else
//    {
//        RankDetailTableViewController *detailVC = [[RankDetailTableViewController alloc] init];
//        detailVC.idStr = cell4.tag;
//        [self.navigationController pushViewController:detailVC animated:NO];
//        
    }
}

@end
