//
//  HPNewsVC.m
//  orangeLife
//
//  Created by 张俊凯 on 16/7/30.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPNewsVC.h"

@interface HPNewsVC()<UITableViewDataSource>

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
    tableView.dataSource = self;
    
}

//2.加载数据
-(void)loadData
{
    NSDate  * senddate=[NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [dateFormat stringFromDate:senddate];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"showapi_appid"] = APPID;
    params[@"showapi_sign"] = APPKEY;
    params[@"showapi_timestamp"] = dateString;
    
    JKLog(@"请求发送的字典---%@",params);
    [[HPHttpManager shareManager] postReqWithBaseUrlStr:@"http://route.showapi.com/" surfixUrlStr:@"170-48" params:params success:^(NSDictionary *responseObject) {
       
        JKLog(@"%@",responseObject);
    
    } failure:^(NSError *error) {
        
        JKLog(@"%@",error);
        
    }];
}


#pragma mark tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}



@end
