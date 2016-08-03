//
//  HPNewsVC.m
//  orangeLife
//
//  Created by 张俊凯 on 16/7/30.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPNewsVC.h"

@interface HPNewsVC()<UITableViewDataSource,UITableViewDelegate>
/**
 *  新闻全国区域数组
 */
@property(nonatomic,strong)NSArray *areas;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation HPNewsVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = JKRandomColor;
    
    //1.添加表格
    [self setupTableView];
    
    //2.加载数据
    [self loadData];
    


    
    
}


//1.添加表格
-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.frame  = self.view.bounds;
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    tableView.height -= statusBarHeight + navBarHeight + titleViewHeight;
    
}

//2.加载数据
-(void)loadData
{
    [SVProgressHUD showWithStatus:@"数据加载中，请稍后"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"showapi_appid"] = APPID;
    params[@"showapi_sign"] = APPKEY;
    params[@"showapi_timestamp"] = [HPUtils getCurrentTime];
    
    //JKLog(@"请求发送的字典---%@",params);
    [[HPHttpManager shareManager] getReqWithBaseUrlStr:@"http://route.showapi.com/" surfixUrlStr:@"170-48" params:params success:^(NSDictionary *responseObject) {
        //JKLog(@"-----返回数据-----%@",responseObject);
        
        NSInteger code =  [responseObject[@"showapi_res_code"] integerValue];
        if (code == 0) {//返回成功，加载数据
            self.areas = responseObject[@"showapi_res_body"][@"cityList"];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{//返回失败的处理
          //NSString *errorMsg = responseObject[@"showapi_res_error"];
            [SVProgressHUD showErrorWithStatus:@"服务器异常，请稍后再试"];
        }

    
    } failure:^(NSError *error) {
        
        JKLog(@"----返回错误-----%@",error);
        
    }];
    
    
}


#pragma mark tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.areas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.areas[indexPath.row][@"areaName"];
    return cell;
}

#pragma mark tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击一个控制器，进去以后显示对应的新闻
   NSDictionary *areaDic =  self.areas[indexPath.row];
    HPNewsDetailVC * newsDetailVC = [[HPNewsDetailVC alloc] init];
    newsDetailVC.areaName = areaDic[@"areaName"];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}


@end
