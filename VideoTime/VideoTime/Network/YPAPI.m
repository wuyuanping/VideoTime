//
//  YPAPI.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPAPI.h"
#import "BaseHttpRequestManager.h"
#import "BaseURLCache.h"
#import "BaseResponseResult.h"

@implementation YPAPI

+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(RequestSuccessBlock)success
            failure:(RequestFailedBlock)failure
{
    
    [[BaseHttpRequestManager sharedManager] requestWithPathHaveToken:path method:YPHttpRequestTypeGet parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSInteger statusCode = [[responseObject objectForKey:@"code"] integerValue];
        if (statusCode == YPResponseCodeSuccess) {
            // 请求成功
            if (success) {
                BaseResponseResult *result = [BaseResponseResult yy_modelWithDictionary:responseObject];
                result.response = responseObject;
                success(result);
            }
        } else {
            // 请求错误
            if (failure) {
                NSError *error = [[NSError alloc] initWithDomain:path code:statusCode userInfo:responseObject];
                failure(error);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 请求失败
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(RequestSuccessBlock)success
             failure:(RequestFailedBlock)failure
{
    [[BaseHttpRequestManager sharedManager] requestWithPathHaveToken:path method:YPHttpRequestTypePost parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSInteger statusCode = [[responseObject objectForKey:@"code"] integerValue];
        if (statusCode == YPResponseCodeSuccess) {
            // 请求成功
            if (success) {
                BaseResponseResult *result = [BaseResponseResult yy_modelWithDictionary:responseObject];
                result.response = responseObject;
                success(result);
            }
        } else {
            // 请求错误
            if (failure) {
                NSError *error = [[NSError alloc] initWithDomain:path code:statusCode userInfo:responseObject];
                failure(error);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 请求失败
        if (failure) {
            failure(error);
        }
    }];
}

 // 发起有缓存的GET网络请求，
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
              cache:(RequestCacheBlock)cache
            success:(RequestSuccessBlock)success
            failure:(RequestFailedBlock)failure
{
    
    //启动APP，只获取一次
    //    static dispatch_once_t predicate;
    //    dispatch_once(&predicate, ^{
    //获取缓存
    NSData *cacheData = [[BaseURLCache sharedURLCache] cachedDataForKey:path];
    if (cacheData) {
        NSDictionary *cacheResposeObj = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        cache(cacheResposeObj);
    }
    //    });
    
    [self getWithPath:path params:params success:^(BaseResponseResult *result) {
        //缓存数据
        NSData *data = [NSJSONSerialization dataWithJSONObject:result.data options:NSJSONWritingPrettyPrinted error:nil];
        [[BaseURLCache sharedURLCache] setCacheData:data forKey:path];
        success(result);
    } failure:^(NSError *error) {
        //  NSError *error = [[NSError alloc] initWithDomain:[SERVER_HOST_URL stringByAppendingString:API_HOMEPAGE] code:statusCode userInfo:responseObject];
        failure(error);
    }];
}

// 发起有缓存的POST网络请求
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
               cache:(RequestCacheBlock)cache
             success:(RequestSuccessBlock)success
             failure:(RequestFailedBlock)failure
{
    //启动APP，只获取一次
    //    static dispatch_once_t predicate;
    //    dispatch_once(&predicate, ^{
    //获取缓存
    NSData *cacheData = [[BaseURLCache sharedURLCache] cachedDataForKey:path];
    if (cacheData) {
        NSDictionary *cacheResposeObj = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        cache(cacheResposeObj);
    }
    //    });
    
    [self postWithPath:path params:params success:^(BaseResponseResult *result) {
        //缓存数据
        NSData *data = [NSJSONSerialization dataWithJSONObject:result.data options:NSJSONWritingPrettyPrinted error:nil];
        [[BaseURLCache sharedURLCache] setCacheData:data forKey:path];
        success(result);
    } failure:^(NSError *error) {
        // NSError *error = [[NSError alloc] initWithDomain:[SERVER_HOST_URL stringByAppendingString:API_HOMEPAGE] code:statusCode userInfo:responseObject];
        failure(error);
    }];
}


/*
//升序排序
+(NSArray*)stringWithDict:(NSDictionary*)dict{
    NSArray*keys = [dict allKeys];
    
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *sortedArray = [keys sortedArrayUsingComparator:sort];
    NSLog(@"字符串数组排序结果%@",sortedArray);
    
    //    NSMutableDictionary *sortedDic = [[NSMutableDictionary alloc]init];
    //    for (NSString *categoryId in sortedArray) {
    //        NSLog(@"%@ : %@", categoryId,[dict objectForKey:categoryId]);
    //        [sortedDic setObject:[dict objectForKey:categoryId] forKey:categoryId];
    //    }
    //
    //    NSLog(@"sortedDic-------%@",sortedDic);
    return sortedArray;
}
*/
#pragma mark - 各API方法
//+ (void)getGiftList
//{
//    NSString *urlString = [NSString stringWithFormat:@"%@%@",[LPSystemConfigHelper hostName],kGiftListUrl];
//
//    [[LPNetworkManager sharedInstance] getWithUrl:urlString data:nil cacheInfo:nil success:^(LPHttpResult *responseObject) {
//        if ([[responseObject.dataDic objectForKey:@"code"] integerValue] == 1000) {
//            LPGiftModel *giftModel = [LPGiftModel yy_modelWithDictionary:responseObject.dataDic];
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:giftModel.data];
//            [[NSUserDefaults standardUserDefaults] setObject:data forKey:GiftListArray];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }else{
//            //获取礼物失败
//        }
//    } failure:^(LPHttpResult *responseObject) {
//        
//    }];
//}


@end
