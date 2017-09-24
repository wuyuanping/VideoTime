//
//  BaseNetworkHandler.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

 // 该类主要用来实现数据加密，解密操作 

#import <Foundation/Foundation.h>
#import "BaseResponseResult.h"


/**
 * 网络请求缓存
 * cacheData ： 缓存对象
 */
typedef void (^RequestCacheBlock)(id cacheData);

/**
 *  Handler处理成功时调用的Block
 */
typedef void (^RequestSuccessBlock)(BaseResponseResult *result);

/**
 *  Handler处理失败时调用的Block
 */
typedef void (^RequestFailedBlock)(NSError *error);


@interface BaseNetworkHandler : NSObject


/**
 *  获取请求URL
 *
 *  @param path
 *  @return 拼装好的URL
 */
//+ (NSString *)requestUrlWithPath:(NSString *)path;

/**
 * 生成sign
 * @param params 请求参数
 * @return 按协定方式加密生成的验证字符串
 */
+ (NSString *)generateSignString:(NSDictionary *)params;


/**
 *  请求数据的加密
 *
 *  @param 参数字典
 *  @return 加密之后的请求参数
 */
//+ (NSDictionary *)requestDataEncryptWithParameter:(NSDictionary *)parameDic needToken:(BOOL)needToken;

/**
 *  返回数据的解密
 *
 *  @param responseDic 返回数据
 *  @return 解密之后的返回数据
 */
//+ (NSDictionary *)responseDataDecrypt:(NSDictionary *)responseDic isUsePublicKey:(BOOL)usePublicKey;


@end
