//
//  HPNewsDetailVC.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/2.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPNewsDetailVC.h"
#import "HPNews.h"
#import "HPWebViewVC.h"
#import "HPNewsDetailCell.h"

NSString static * const reuseID = @"cell";

@interface HPNewsDetailVC ()
/**
 *  记录当前页
 */
@property(nonatomic,assign)NSInteger currentPage;
/**
 *  新闻数组
 */
@property(nonatomic,strong)NSArray *newsArray;
@end

@implementation HPNewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //JKLog(@"%@",self.areaName);
    
    //URL :http://route.showapi.com/170-47
    self.currentPage = 1;
    //1.加载数据
    [self loadData];
    
    //2.注册cell
    [self.tableView registerClass:[HPNewsDetailCell class] forCellReuseIdentifier:reuseID];

}

//1.加载数据
-(void)loadData
{
    
    [SVProgressHUD showWithStatus:@"数据加载中，请稍后"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"showapi_appid"] = APPID;
    params[@"showapi_sign"] = APPKEY;
    params[@"showapi_timestamp"] = [HPUtils getCurrentTime];
    params[@"areaName"] = self.areaName;
    params[@"page"] = [NSString stringWithFormat:@"%zd",self.currentPage];
    
    //JKLog(@"新闻控制器请求发送的字典---%@",params);
    [[HPHttpManager shareManager] getReqWithBaseUrlStr:@"http://route.showapi.com/" surfixUrlStr:@"170-47" params:params success:^(NSDictionary *responseObject) {
        //JKLog(@"-----新闻控制器返回数据-----%@",responseObject);
        //[responseObject writeToFile:@"/Users/kevin/Desktop/jkJson.plist" atomically:YES];
        NSInteger code =  [responseObject[@"showapi_res_code"] integerValue];
        
        if (code == 0) {//返回成功，加载数据
            [SVProgressHUD dismiss];
            self.newsArray = [HPNews mj_objectArrayWithKeyValuesArray:responseObject[@"showapi_res_body"][@"pagebean"][@"contentlist"]];
            JKLog(@"%@",responseObject[@"showapi_res_body"][@"pagebean"][@"contentlist"]);
            
            self.currentPage = [responseObject[@"showapi_res_body"][@"pagebean"][@"currentPage"] integerValue];
            [self.tableView reloadData];
            
            JKLog(@"-----%@,%zd",_newsArray,_currentPage);
            
            
        }else{//返回失败的处理
            //NSString *errorMsg = responseObject[@"showapi_res_error"];
            [SVProgressHUD showErrorWithStatus:@"服务器异常，请稍后再试"];
        }
        
        
        
    } failure:^(NSError *error) {
        
        JKLog(@"----返回错误-----%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络连接错误，请检查网络"];
        
    }];
    
    
}


#pragma mark tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HPNews *news =  self.newsArray[indexPath.row];
    HPNewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
   
    cell.textLabel.text = news.title;
    return cell;
}

#pragma mark tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat
{
    HPNews *news =  self.newsArray[indexPat.row];
    //JKLog(@"%@",news.link);
    //推出一个webView控制器
   HPWebViewVC *webVC = [[HPWebViewVC alloc] init];
    webVC.link = news.link;
    [self.navigationController pushViewController:webVC animated:YES];
}


@end
