//
//  YPSystemConfigHelper.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPSystemConfigHelper.h"
#import "YPUserDefaultHelper.h"


@implementation YPSystemConfigHelper

+ (BOOL)isApproved
{
    NSString *version =  [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *passKeyForVersion = [NSString stringWithFormat:@"%@%@", PASS_USER_DEFAULT_KEY, version];
    BOOL isPass = [[YPUserDefaultHelper objectForDestKey:passKeyForVersion] boolValue];
    return isPass;
}

+ (void)requestIsApprovedWithCompletion:(void (^)(BOOL))completion
{
    BOOL isApproved = [self isApproved];
    //如果已经过审核直接
    if (isApproved) {
        if (completion) {
            completion(isApproved);
        }
        return;
    }
    
    // NSString *urlString = [NSString stringWithFormat:@"%@%@", [YPSystemConfigHelper hostName], kExaminePass];
    NSString *version =  [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *params = @{@"version" : version};
    [YPAPI getWithPath:kExaminePass params:params success:^(BaseResponseResult *result) {
        
    } failure:^(NSError *error) {
        if (error.code == 0) {
            BOOL isApproved = NO;
            if ([[error.userInfo objectForKey:@"switch"] integerValue] != 1) {
                isApproved = YES;
            } else {
                isApproved = NO;
                isApproved = !IS_ENABLE_PASS;
            }
            
            if (isApproved) {
                //修改hostname
                [self setHostName:HOST_URL];
            }
            // 保存是否过审开关状态
            // V1.2.4 修复不同版本使用同一个是否过审开关，导致升级安装的APP不会出现手机登录按钮问题
            NSString *passKeyForVersion = [NSString stringWithFormat:@"%@%@", PASS_USER_DEFAULT_KEY, version];
            [YPUserDefaultHelper setObject:@(isApproved) forDestKey:passKeyForVersion];
            if (completion) {
                completion(isApproved);
            }
        } else {
            // 请求失败认为没有过审核
            NSString *passKeyForVersion = [NSString stringWithFormat:@"%@%@", PASS_USER_DEFAULT_KEY, version];
            [YPUserDefaultHelper setObject:@(NO) forDestKey:passKeyForVersion];
            
            if (completion) {
                completion(NO);
            }
        }
    }];
}

+ (NSString *)hostName
{
    NSString *hostName = [YPUserDefaultHelper objectForDestKey:kServerHostName];
    if (!hostName) {
        hostName = [NSString stringWithFormat:@"%@", IPV6_TEST_URL];
    }
    //测试接口开关
    if (IS_TEST_MODE) {
        hostName = TEST_URL;
    }
    return hostName;
}


+ (NSString *)socketHostName
{
    // socket host
    NSDictionary *dataDict = [YPUserDefaultHelper objectForDestKey:UD_SYSTEM_CONFIG];
    if (!dataDict) {
        return SOCKET_DEFAULT_HOST_URL;
    }
    
    NSDictionary *socketInfoDict = [dataDict objectForKey:@"socket"][0];
    NSString *hostName = [socketInfoDict objectForKey:@"host"];
    return hostName;
}

+ (NSString *)socketPort
{
    // socket端口
    NSDictionary *dataDict = [YPUserDefaultHelper objectForDestKey:UD_SYSTEM_CONFIG];
    if (!dataDict) {
        return SOCKET_DEFAULT_PORT;
    }
    NSDictionary *socketInfoDict = [dataDict objectForKey:@"socket"][0];
    NSString *port = [socketInfoDict objectForKey:@"port"];
    return port;
}

+ (void)setHostName:(NSString *)hostname
{
    if (hostname && ![hostname isEqualToString:@""]) {
        NSString *hostNameString = [NSString stringWithFormat:@"%@", hostname];
        [YPUserDefaultHelper setObject:hostNameString forDestKey:kServerHostName];
    }
}

+ (void)requestSystemConfig
{
    // 请求系统配置
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[YPSystemConfigHelper hostName], kSystemConfig];
    [YPAPI getWithPath:urlString params:nil success:^(BaseResponseResult *result) {
        NSDictionary *data = result.data;
        [YPUserDefaultHelper setObject:data forDestKey:UD_SYSTEM_CONFIG];
    } failure:^(NSError *error) {
        
    }];
}

+ (BOOL)isCanMobileLogin
{
    // 是否可以手机登录
    NSDictionary *dataDict = [YPUserDefaultHelper objectForDestKey:UD_SYSTEM_CONFIG];
    if (!dataDict) {
        return NO;
    }
    BOOL isCanMobileLogin = [[dataDict objectForKey:@"is_moblie_login"] boolValue];
    return isCanMobileLogin;
}

@end
