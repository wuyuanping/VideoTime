//
//  BaseHttpRequestManager.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AFNetworking.h"

//HTTP REQUEST METHOD TYPE
typedef NS_ENUM(NSUInteger,YPHttpRequestType)
{
    YPHttpRequestTypeGet,
    YPHttpRequestTypePost,
    YPHttpRequestTypeDelete,
    YPHttpRequestTypePut
};

@interface BaseHttpRequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

/**
 *  HTTP请求（GET、POST、DELETE、PUT）
 *
 *  @param path       请求URL Path
 *  @param method     RESTFul请求类型
 *  @param parameters 请求参数
 *  @param success    请求成功处理块
 *  @param failure    请求失败处理块
 */
- (void)requestWithPath:(NSString *)path
                 method:(YPHttpRequestType)method
             parameters:(id)parameters
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  带Cookie的HTTP请求（GET、POST、DELETE、PUT）
 *
 *  @param path       请求URL Path
 *  @param method     RESTFul请求类型
 *  @param parameters 请求参数
 *  @param success    请求成功处理块
 *  @param failure    请求失败处理块
 */
- (void)requestWithPathHaveToken:(NSString *)path
                          method:(YPHttpRequestType)method
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

/**
 *  带sign验证信息的HTTP请求（GET、POST、DELETE、PUT）
 *
 *  @param path       请求URL Path
 *  @param method     RESTFul请求类型
 *  @param parameters 请求参数
 *  @param success    请求成功处理块
 *  @param failure    请求失败处理块
 */
- (void)requestWithSignAndPath:(NSString *)path
                        method:(YPHttpRequestType)method
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

//判断当前网络状态
- (BOOL)isConnectionAvailable;


@end
