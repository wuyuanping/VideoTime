//
//  BaseURLCache.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

// 网络请求数据缓存，类似于系统提供的NSURLCache类

#import <Foundation/Foundation.h>

@interface BaseURLCache : NSObject

/**
 * 获取缓存单例对象
 */
+ (instancetype)sharedURLCache;

/**
 * 缓存数据到沙盒
 */
- (void)setCacheData:(NSData *)data forKey:(NSString *)urlString;

/**
 * 获取缓存
 *
 */
- (NSData *)cachedDataForKey:(NSString *)urlString;

/**
 * 删除cache
 */
- (void)removeCachedResponseForRequestURL:(NSString *)urlString;

/**
 * 删除所有的cache
 */
- (void)removeAllCachedResponses;


@end
