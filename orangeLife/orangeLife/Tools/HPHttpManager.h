//
//  HPHttpManager.h
//  orangeLife
//
//  Created by 张俊凯 on 16/8/1.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

// 网络访问的回调block预定义
typedef void(^HttpRequestSuccessBlock)(NSDictionary * responseObject);
typedef void(^HttpRequestFailureBlock)(NSError *error);

@interface HPHttpManager : NSObject

/**
 *  AF网络管理
 */
@property(nonatomic,strong)AFHTTPSessionManager *manager;

+ (HPHttpManager *)shareManager;

- (void)requestWithMethod:(NSString *)method
               baseUrlStr:(NSString *)baseUrlStr
             surfixUrlStr:(NSString *)surfixUrlStr
                   params:(NSDictionary *)params
                  success:(HttpRequestSuccessBlock)success
                  failure:(HttpRequestFailureBlock)failure;

/**
 *  POST请求
 *
 *  @param baseUrlStr 基准url
 *  @param urlStr     后缀urlstr
 *  @param params     参数
 *  @param success    成功回调block
 *  @param failure    失败回调block
 */
- (void)postReqWithBaseUrlStr:(NSString *)baseUrlStr
                 surfixUrlStr:(NSString *)surfixUrlStr
                       params:(NSDictionary *)params
                      success:(HttpRequestSuccessBlock)success
                      failure:(HttpRequestFailureBlock)failure;
/**
 *  GET请求
 *
 *  @param baseUrlStr 基准url
 *  @param urlStr     后缀urlstr
 *  @param params     参数
 *  @param success    成功回调block
 *  @param failure    失败回调block
 */
- (void)getReqWithBaseUrlStr:(NSString *)baseUrlStr
                 surfixUrlStr:(NSString *)surfixUrlStr
                       params:(NSDictionary *)params
                      success:(HttpRequestSuccessBlock)success
                      failure:(HttpRequestFailureBlock)failure;


@end

