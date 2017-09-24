//
//  YPAPI.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetworkHandler.h"

@interface YPAPI : NSObject

/**
 * 发起GET网络请求
 *@params params    网络请求参数
 *@params success   请求成功回调(返回状态码为1000的请求回调，其他状态码将通过请求失败failure回调)
 *@params failure   请求失败回调(请求异常(状态码为非1000)、请求超时、请求错误(网络连接错误，访问主机错误))
 */
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;

/**
 * 发起POST网络请求
 *@params params    网络请求参数
 *@params success   请求成功回调(返回状态码为1000的请求回调，其他状态码将通过请求失败failure回调)
 *@params failure   请求失败回调(请求异常(状态码为非1000)、请求超时、请求错误(网络连接错误，访问主机错误))
 */
+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure ;

/**
 * 发起有缓存的GET网络请求，
 *@params params    网络请求参数
 *@params cache     网络数据缓存
 *@params success   请求成功回调(返回状态码为1000的请求回调，其他状态码将通过请求失败failure回调)
 *@params failure   请求失败回调(请求异常(状态码为非1000)、请求超时、请求错误(网络连接错误，访问主机错误))
 */
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params cache:(RequestCacheBlock)cache success:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;

/**
 * 发起有缓存的POST网络请求
 *@params params    网络请求参数
 *@params cache     网络数据缓存
 *@params success   请求成功回调(返回状态码为1000的请求回调，其他状态码将通过请求失败failure回调)
 *@params failure   请求失败回调(请求异常(状态码为非1000)、请求超时、请求错误(网络连接错误，访问主机错误))
 */
+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params cache:(RequestCacheBlock)cache success:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;



@end
