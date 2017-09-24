//
//  BaseNetworkHandler.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseNetworkHandler.h"
#import "APIConfig.h"

@implementation BaseNetworkHandler

//+ (NSString *)requestUrlWithPath:(NSString *)path
//{
//    return [SERVER_HOST_URL stringByAppendingString:path];
//}

// 生成sign
+ (NSString *)generateSignString:(NSDictionary *)params
{
    //KEY升序排序
    NSArray *keys = params.allKeys;
    //排序
    NSArray *descendSortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *string1 = obj1;
        NSString *string2 = obj2;
        
        NSComparisonResult result = [string1 compare:string2 options:NSCaseInsensitiveSearch];
        return result == NSOrderedDescending; // 升序
    }];
    
    NSArray *values = [params objectsForKeys:descendSortedArray notFoundMarker:@""];
    NSMutableString *spliceValuesString = [[NSMutableString alloc] initWithCapacity:values.count];
    for (NSString *str in values) {
        [spliceValuesString appendFormat:@"%@&",str];
    }
    
    //加KEY
    NSString *string = [NSString stringWithFormat:@"%@%@", spliceValuesString, SING_KEY];
    //加密
    // NSString *signString = [PBASecurityUtil SHA256WithString:string];
    
    return string;
}

//+ (NSDictionary *)requestDataEncryptWithParameter:(NSDictionary *)parameDic needToken:(BOOL)needToken {
//    //将参数转化为json对象
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameDic options:NSJSONWritingPrettyPrinted error:&error];
//    //    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    //RSA非对称加密
//    NSData *encryptData = [XTSecurityUtil encryptRSAWithData:jsonData];
//    NSString *encryptJsonString = [XTSecurityUtil encodeBase64Data:encryptData];
//
//    //创建新的请求参数
//    NSDictionary *encryptParameterDic = nil;
//    //如果需要token
//    if (needToken) {
//        //TODO:
//        NSString *tokenString = @"token";
//        encryptParameterDic = @{@"req":encryptJsonString, @"token":tokenString};
//    } else {
//        encryptParameterDic = @{@"req" : encryptJsonString,};
//    }
//
//    return encryptParameterDic;
//}
//
//+ (NSDictionary *)responseDataDecrypt:(NSDictionary *)responseDic isUsePublicKey:(BOOL)usePublicKey {
//    //取出数据部分
//    //    [responseDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//    //        NSData *data = [obj dataUsingEncoding:NSUTF8StringEncoding];
//    //        //解密
//    //        obj = [XTSecurityUtil decryptAESData:data];
//    //    }];
//
//    //将json转化为dic
//    //    NSData *data = [encryptJsonString dataUsingEncoding:NSUTF8StringEncoding];
//    //    NSDictionary *dic = [data objectFromJSONData];
//
//    return responseDic;
//}


@end
