//
//  HPAlbumVC.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/8.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPAlbumVC.h"
#import "HPHomeModel.h"
#import "MJRefresh.h"
#import "HPListCell.h"
#import "HPFoodMenuVC.h"


@interface HPAlbumVC ()<UITableViewDataSource,UITableViewDelegate>
{
    HPHomeModel *_homeModel;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    NSMutableArray *_infoArray;
    NSMutableArray *_listArray;
    CGFloat _heightCell;
    NSMutableDictionary *_dict;
    NSInteger _offset;
    NSMutableArray *_array;
}
@end

@implementation HPAlbumVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, JKScreenW, JKScreenH- 64);
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _homeModel = [[HPHomeModel alloc] init];
    
    //集成刷新
    [self setupREfresh];
    
    [_homeModel getAidDataWithAid:@"4275308" andLimit:@"10" andOffset:@"0" andSign:@"33e3696577645da906cd6a378119b243"  andUid:@"6832623" andUuid:@"17EF523E05B42597F70A95681590F28B" andAidBlock:^(BOOL isSucess, NSMutableArray *dataArr) {
        if (isSucess) {
            _dataArray = [dataArr mutableCopy];
            //停止刷新
            [_tableView.mj_header endRefreshing];
            [_tableView reloadData];
        }
    }];
    
    
}

- (void)setupREfresh
{
   
    //1.添加顶部控件
    MJRefreshHeader *header = _tableView.mj_header;
    header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [_tableView.mj_header beginRefreshing];
    
    //2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
     MJRefreshFooter *footer = _tableView.mj_footer;
     footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

    
//    _tableView.headerPullToRefreshText = @"下拉更新…";
//    _tableView.headerReleaseToRefreshText = @"";
//    _tableView.headerRefreshingText = @"数据刷新…";
//    
//    _tableView.footerPullToRefreshText = @"上拉加载数据…";
//    _tableView.footerReleaseToRefreshText = @"";
//    _tableView.footerRefreshingText = @"数据刷新…";
    
}

#pragma mark --开始进入刷新状态
- (void)headerRereshing
{
    _offset = 0;
    [_homeModel getAidDataWithAid:@"4275308" andLimit:@"10" andOffset:[NSString stringWithFormat:@"%ld",(long)_offset] andSign:@"33e3696577645da906cd6a378119b243"  andUid:@"6832623" andUuid:@"17EF523E05B42597F70A95681590F28B" andAidBlock:^(BOOL isSucess, NSMutableArray *dataArr) {
        if (isSucess) {
            //上拉刷新始终保持原始的数据条目个数
            [_dataArray removeAllObjects];
            _dataArray = [dataArr mutableCopy];
            [_tableView.mj_header endRefreshing];
            //            NSLog(@"magi%@",_dataArray);
            [_tableView reloadData];
        }
    }];
    
    
    
}

- (void)footerRereshing
{
    //网络请求后面的数据
    _offset+= 10;
    
    [_homeModel getAidDataWithAid:@"4275308" andLimit:@"10" andOffset:[NSString stringWithFormat:@"%ld",(long)_offset] andSign:@"33e3696577645da906cd6a378119b243"  andUid:@"6832623" andUuid:@"17EF523E05B42597F70A95681590F28B" andAidBlock:^(BOOL isSucess, NSMutableArray *dataArr) {
        if (isSucess) {
            _dataArray = [dataArr mutableCopy];
            [_tableView.mj_footer endRefreshing];
            //            NSLog(@"magi%@",_dataArray);
            [_tableView reloadData];
        }
    }];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //    return _listArray.count ;
    NSInteger count = 0;
    for (NSDictionary *dict in _dataArray)
    {
        if ([@"list" isEqualToString:[dict objectForKey:@"title"]]) {
            
            _listArray = [dict objectForKey:@"array"];
            count+= _listArray.count;
            //获取到list的所有数据
            //            [_array addObjectsFromArray:_listArray];
        }
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (NSDictionary *dict in _dataArray) {
        if ([@"list" isEqualToString:[dict objectForKey:@"title"]]) {
            _listArray = [dict objectForKey:@"array"];
            [_array addObjectsFromArray:_listArray];
        }
    }
    //
    HPHomeInfo *info = [[HPHomeInfo alloc] init];
    if (_array.count > 0) {
        info = _array[indexPath.row];
        
        
    }
    NSString *text = info.intro;
    if (text.length >0) {
        CGSize constraint = CGSizeMake(JKScreenW - 30, 2000.0f);
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        CGSize textSize = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _heightCell = textSize.height;
        
    }
    
    //    NSLog(@"magi%f",_heightCell);
    return _heightCell + 210;
    
    
    
}
//设置头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    for (NSDictionary *dict in _dataArray) {
        if ([@"info" isEqualToString:[dict objectForKey:@"title"]]) {
            _infoArray = [dict objectForKey:@"array"];
        }
    }
    //
    HPHomeInfo *info = [[HPHomeInfo alloc] init];
    info = _infoArray[0];
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JKScreenW, 200)];
    UIImageView *coverView = [[UIImageView alloc] init];
    coverView.frame = CGRectMake(0, 0, JKScreenW, 120);
    [coverView  sd_setImageWithURL:[NSURL URLWithString:info.albumCover] placeholderImage:nil];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setFont:[UIFont systemFontOfSize:18]];
    titleLab.center = CGPointMake(JKScreenW / 2.0f, 30);
    [titleLab setText:info.albumTitle];
    
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 60, 35, 35)];
    [backImgV setImage:[UIImage imageNamed:@"yuan_03.png"]];
    UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(105, 65, 25, 25)];
    [iconImgV sd_setImageWithURL:[NSURL URLWithString:info.albumAvatarUrl] placeholderImage:nil];
    UILabel *userLab = [[UILabel alloc] initWithFrame:CGRectMake(140, 75, 100, 10)];
    [userLab setFont:[UIFont systemFontOfSize:14]];
    [userLab setTextColor:[UIColor whiteColor]];
    [userLab setText:info.albumUserName];
    
    UILabel *introLab = [[UILabel alloc] init];
    [introLab setFrame:CGRectMake(15, 115, JKScreenW - 30, 80)];
    [introLab setText:info.albumContent];
    [introLab setNumberOfLines:0];
    [introLab setFont:[UIFont systemFontOfSize:14]];
    
    
    [headerV addSubview:coverView];
    [headerV addSubview:titleLab];
    [headerV addSubview:backImgV];
    [headerV addSubview:iconImgV];
    [headerV addSubview:userLab];
    [headerV addSubview:introLab];
    return headerV;
    
}
//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 200; //section的高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    HPListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HPListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    _array = [NSMutableArray array];
    
    for (NSDictionary *dict in _dataArray)
    {
        if ([@"list" isEqualToString:[dict objectForKey:@"title"]]) {
            
            _listArray = [dict objectForKey:@"array"];
            //获取到list的所有数据
            [_array addObjectsFromArray:_listArray];
            //不能写这句话，这里涉及到深拷贝和浅拷贝，这里只拷贝了数据，没有拷贝地址
            //                [_listArray removeAllObjects];
        }
        
    }
    
    NSLog(@"_array = %@",_array);
    //
    HPHomeInfo *info = [[HPHomeInfo alloc] init];
    if (_array.count > 0) {
        info = _array[indexPath.row];
        
    }
    [cell.coverView sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
    [cell.titleLab setText:info.title];
    cell.tag = [info.recipeId integerValue];
    cell.userNameLab.text = [NSString stringWithFormat:@"by  %@",info.userName];
    [UIView beginAnimations:nil context:nil];
    if (cell.likeBtn.isSelected == YES)
    {
        if ([info.likeCount integerValue] >= 999) {
            [cell.showLab setText:@"999+"];
        }
        else
            [cell.showLab setText:[NSString stringWithFormat:@"%ld",([info.likeCount integerValue] + 1)]];
        
        
    }else
    {
        if ([info.likeCount integerValue] >= 999) {
            [cell.showLab setText:@"999+"];
        }else
            [cell.showLab setText:[NSString stringWithFormat:@"%ld",[info.likeCount integerValue]]];
    }
    [UIView commitAnimations];
    NSString *text = info.intro;
    if (text.length > 0) {
        CGSize contraint = CGSizeMake(JKScreenW - 30, 2000.f);
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        CGSize textSize = [attributedText boundingRectWithSize:contraint options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _heightCell = textSize.height;
        //        NSLog(@"magi%f",_heightCell);
    }
    
    [cell.introLab setFrame:CGRectMake(15, 200, JKScreenW - 30, _heightCell)];
    [cell.introLab setText:info.intro];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HPListCell *cell = (HPListCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    HPFoodMenuVC *foodMenuVC = [[HPFoodMenuVC alloc] init];
    foodMenuVC.recipeId = cell.tag;
    [self.navigationController pushViewController:foodMenuVC animated:NO];
    
}
@end

