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
#import "HPAlbumVC.h"
#import "HPRecipeTableVC.h"
#import "HPTRankableVC.h"
#import "HPTagButton.h"
#import "HPRankButton.h"
#import "HPRankMoreTableVC.h"
#import "HPImageCell.h"
#import "HPOneLabelCell.h"
#import "HPTwoLabelCell.h"
#import "HPRankCell.h"



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
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = @"测试";
//    return cell;
//}
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
            else if (cell1.tag == 1000)
            {
                HPAlbumVC *albumVC = [[HPAlbumVC alloc] init];
                [self.navigationController pushViewController:albumVC animated:NO];
            }
            else if( cell3.tag == 1)
            {
#warning 开始完善这个控制器
                HPRecipeTableVC *recipeVC = [[HPRecipeTableVC alloc] init];
                recipeVC.index = cell3.tag;
                [self.navigationController pushViewController:recipeVC animated:NO];
            }
            else if(cell2.tag == 0 || cell2.tag == 2 || cell2.tag == 3 || cell2.tag == 4)
            {
                HPRecipeTableVC *recipeVC = [[HPRecipeTableVC alloc] init];
                recipeVC.index = cell2.tag;
                [self.navigationController pushViewController:recipeVC animated:NO];
            }
            else if(indexPath.row == 7)
            {
                HPRecipeTableVC *recipeVC = [[HPRecipeTableVC alloc] init];
                recipeVC.index = indexPath.row - 2;
                [self.navigationController pushViewController:recipeVC animated:NO];
            }

    }
    else
    {
        HPTRankableVC *detailVC = [[HPTRankableVC alloc] init];
        detailVC.idStr = cell4.tag;
        [self.navigationController pushViewController:detailVC animated:NO];
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        //创建榜单按钮
        HPRankButton *rankBtn = [HPRankButton buttonWithType:UIButtonTypeCustom];
        [rankBtn.textLabel setText:@"榜单"];
        [rankBtn.moreLabel setText:@"更多榜单"];
        [rankBtn addTarget:self action:@selector(clickRankMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        return rankBtn;
    }else{
        return nil;
    }
}

//cell定制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //设置数据
    if(indexPath.section == 0)
    {
        
        static NSString *customCell1 = @"CustomCell1";
        static NSString *customCell2 = @"CustomCell2";
        static NSString *customCell3 = @"CustomCell3";
        
        
        HPImageCell *cell1 = (HPImageCell *)[tableView dequeueReusableCellWithIdentifier:customCell1];
        HPOneLabelCell *cell2 = (HPOneLabelCell *)[tableView dequeueReusableCellWithIdentifier:customCell2];
        HPTwoLabelCell *cell3 = (HPTwoLabelCell *)[tableView dequeueReusableCellWithIdentifier:customCell3];
        
        
        switch (indexPath.row)
        {
            case 0:
            {
                if (cell1 == nil) {
                    cell1 = [[HPImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell1];
                }
                //设置数据
                for (NSDictionary *dict in _arrayData) {
                    if ([@"album" isEqualToString:[dict objectForKey:@"title"]]) {
                        _albumArray = [dict objectForKey:@"array"];
                    }
                }
                HPHomeInfo *info = [[HPHomeInfo alloc] init];
                info = _albumArray[0];
                [cell1.coverImgView sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                [cell1.iconView sd_setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                //设置下面的小图片
                NSArray *smallImgArray = info.smallCover;
                for (int i = 0; i < smallImgArray.count; i++) {
                    UIImageView  *subImgView=[[UIImageView alloc] init];
                    CGFloat smallImgWidth = (JKScreenW - 30) / 5.0f;
                    subImgView.frame = CGRectMake(i * smallImgWidth - 1, 0, smallImgWidth, smallImgWidth);
                    [subImgView sd_setImageWithURL:[NSURL URLWithString:smallImgArray[i]] placeholderImage:nil];
                    [cell1.smallCoverImgView addSubview:subImgView];
                }
                cell1.titleLabel.text = info.title;
                cell1.introLabel.text = info.intro;
                //专辑没有利用传值
                cell1.tag = 1000;
                NSLog(@"cell1.titleLabel.text%@",cell1.titleLabel.text);
                //
                
                return cell1;
            }
                break;
            case 1:
            {
                if (cell1 == nil) {
                    cell1 = [[HPImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell1];
                }
                //设置数据
                for (NSDictionary *dict in _arrayData) {
                    if ([@"wiki" isEqualToString:[dict objectForKey:@"title"]]) {
                        _albumArray = [dict objectForKey:@"array"];
                    }
                }
                HPHomeInfo *info = [[HPHomeInfo alloc] init];
                info = _albumArray[0];
                [cell1.coverImgView sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                [cell1.iconView sd_setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                //设置下面的小图片
                cell1.imgIntroLabel.text = info.intro;
                cell1.titleLabel.text = info.title;
                cell1.introLabel.text = info.desc;
                
                cell1.tag = 5;
                return cell1;
                
            }
                break;
            case 2:
            {
                if (cell2 == nil) {
                    cell2 = [[HPOneLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell2] ;
                }
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HPHomeInfo *info = [[HPHomeInfo alloc] init];
                info = _recipeArray[0];
                if (info.icon.length == 0) {
                    [cell2.coverView  sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    cell2.rTitleLabel.text = info.rTitle;
                    cell2.introLabel.text = info.intro;
                    cell2.titleLabel.text = info.title;
                    cell2.descLabel.text = info.desc;
                    cell2.tag = 0;
                    
                    
                }
                return cell2;
            }
                break;
                
            case 4:
            {
                if (cell2 == nil) {
                    cell2 = [[HPOneLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell2] ;
                }
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HPHomeInfo *info = [[HPHomeInfo alloc] init];
                info = _recipeArray[2];
                if (info.icon.length == 0) {
                    [cell2.coverView  sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    cell2.rTitleLabel.text = info.rTitle;
                    cell2.introLabel.text = info.intro;
                    cell2.titleLabel.text = info.title;
                    cell2.descLabel.text = info.desc;
                    cell2.tag = 2;
                    
                }
                return cell2;
            }
                break;
                
            case 5:
            {
                if (cell2 == nil) {
                    cell2 = [[HPOneLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell2] ;
                }
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HPHomeInfo *info = [[HPHomeInfo alloc] init];
                info = _recipeArray[3];
                if (info.icon.length == 0) {
                    [cell2.coverView  sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    cell2.rTitleLabel.text = info.rTitle;
                    cell2.introLabel.text = info.intro;
                    cell2.titleLabel.text = info.title;
                    cell2.descLabel.text = info.desc;
                    cell2.tag = 3;
                    
                }
                return cell2;
            }
                break;
                
            case 6:{
                if (cell2 == nil) {
                    cell2 = [[HPOneLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell2] ;
                }
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                HPHomeInfo *info = [[HPHomeInfo alloc] init];
                info = _recipeArray[4];
                if (info.icon.length == 0) {
                    [cell2.coverView  sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    cell2.rTitleLabel.text = info.rTitle;
                    cell2.introLabel.text = info.intro;
                    cell2.titleLabel.text = info.title;
                    cell2.descLabel.text = info.desc;
                    ;cell2.tag = 4;
                    
                }
                
                return cell2;
            }
                break;
            case 3:
            {
                if (cell3 == nil)
                {
                    cell3 = [[HPTwoLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell3];
                }
                
                
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HPHomeInfo *info = [[HPHomeInfo alloc] init];
                info = _recipeArray[1];
                if (info.icon.length != 0) {
                    [cell3.coverView  sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    [cell3.iconImgView sd_setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                    cell3.rTitleLabel.text = info.rTitle;
                    cell3.introLabel.text = info.intro;
                    cell3.titleLabel.text = info.title;
                    cell3.descLabel.text = info.desc;
                    cell3.tag = 1;
                    
                    
                }
                return cell3;
            }
                break;
                
            case 7:{
                if (cell3 == nil) {
                    cell3 = [[HPTwoLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell3];
                }
                
                
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HPHomeInfo *info = [[HPHomeInfo alloc] init];
                info = _recipeArray[5];
                //                if (info.icon.length != 0) {
                [cell3.coverView  sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                [cell3.iconImgView sd_setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                cell3.rTitleLabel.text = info.rTitle;
                cell3.introLabel.text = info.intro;
                cell3.titleLabel.text = info.title;
                cell3.descLabel.text = info.desc;
                
                return cell3;
            }
                break;
            case 8:
            {
                if (cell1 == nil)
                {
                    cell1 = [[HPImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell1];
                }
                //设置数据
                for (NSDictionary *dict in _arrayData) {
                    if ([@"table" isEqualToString:[dict objectForKey:@"title"]]) {
                        _tableArray = [dict objectForKey:@"array"];
                    }
                }
                HPHomeInfo *info = [[HPHomeInfo alloc] init];
                info = _tableArray[0];
                [cell1.coverImgView sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                [cell1.iconView sd_setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                //设置下面的小图片
                cell1.titleLabel.text = info.title;
                cell1.introLabel.text = info.desc;
                
                cell1.tag = 6;
                return cell1;
            }
                break;
                
        }
    }
    else
    {
        static NSString *rankCell = @"RankCell";
        
        HPRankCell *cell4 = (HPRankCell *)[tableView dequeueReusableCellWithIdentifier:rankCell];
        if (cell4 == nil)
        {
            cell4 = [[HPRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rankCell];
        }
        //
        for (NSDictionary *dict in _arrayData) {
            if ([@"rank" isEqualToString:[dict objectForKey:@"title"]]) {
                _rankArray = [dict objectForKey:@"array"];
            }
        }
        HPHomeInfo *info = [[HPHomeInfo alloc] init];
        //        for (int i = 0; i < _rankArray.count; i++)
        //        {
        info = _rankArray[indexPath.row];
        [cell4.coverImgView sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
        cell4.titleLabel.text = info.title;
        cell4.introLabel.text = info.intro;
        if (indexPath.row == 0) {
            cell4.tag = 39;
        }else if(indexPath.row == 1)
        {
            cell4.tag = 30;
        }
        else
        {
            cell4.tag = 18;
        }
        
        return cell4;
        
        //        }
        
    }
    
    return nil;
}


#pragma mark - 点击了榜单按钮
- (void)clickRankMoreBtn:(HPRankButton *)btn
{
    JKLog(@"clickRankMoreBtn");
    HPRankMoreTableVC *rankMoreVC = [[HPRankMoreTableVC alloc] init];
    [self.navigationController pushViewController:rankMoreVC animated:NO];
}

#pragma mark scrollView method
-(void)EScrollerViewDidClicked:(NSUInteger)index;

{
    NSLog(@"EScrollerViewDidClicked%ld",index);
    HPFoodWebVC *webVC = [[HPFoodWebVC alloc] init];
    webVC.index = index - 1;
    [self.navigationController pushViewController:webVC animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 250; //section的高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}







@end
