//
//  HPHttpManager.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/1.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPHttpManager.h"

@implementation HPHttpManager

#pragma mark - 单例

static HPHttpManager *_instance;

+ (HPHttpManager *)shareManager {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

/**
 *  网络请求的方法（支持post、get等请求方式），请求超时时间为20s
 *
 *  @param method     请求方式（post、get等）
 *  @param baseUrlStr 基准路径
 *  @param urlStr     请求路径
 *  @param params     参数
 *  @param success    成功回调block
 *  @param failure    失败回调block
 */
- (void)requestWithMethod:(NSString *)method
               baseUrlStr:(NSString *)baseUrlStr
             surfixUrlStr:(NSString *)surfixUrlStr
                   params:(NSDictionary *)params
                  success:(HttpRequestSuccessBlock)success
                  failure:(HttpRequestFailureBlock)failure {
    
    self.manager = [AFHTTPSessionManager manager];
    
    self.manager.requestSerializer.timeoutInterval = JKTimeoutInterval;
    self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",baseUrlStr,surfixUrlStr];
    
    if ([method isEqualToString:@"POST"]) {//POST请求
        [self.manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
            
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) {
                failure(error);
            }
            
        }];
    }else if ([method isEqualToString:@"GET"]){//GET请求
        [self.manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) {
                failure(error);
            }
            
        }];
    }
    
    
}




#pragma mark post请求

- (void)postReqWithBaseUrlStr:(NSString *)baseUrlStr
                 surfixUrlStr:(NSString *)surfixUrlStr
                       params:(NSDictionary *)params
                      success:(HttpRequestSuccessBlock)success
                      failure:(HttpRequestFailureBlock)failure{
    
    [self requestWithMethod:@"POST" baseUrlStr:baseUrlStr surfixUrlStr:surfixUrlStr params:params success:success failure:failure];
}

#pragma mark get请求
-(void)getReqWithBaseUrlStr:(NSString *)baseUrlStr surfixUrlStr:(NSString *)surfixUrlStr params:(NSDictionary *)params success:(HttpRequestSuccessBlock)success failure:(HttpRequestFailureBlock)failure
{
    [self requestWithMethod:@"GET" baseUrlStr:baseUrlStr surfixUrlStr:surfixUrlStr params:params success:success failure:failure];
}


@end

