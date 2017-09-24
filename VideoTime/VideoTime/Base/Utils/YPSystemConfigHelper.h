//
//  YPSystemConfigHelper.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kServerHostName = @"HLBL_HOSTNAME";

#define IPV6_TEST_URL   @"http://ipv6.tst.lpsp.coralxt.com"///< 用于上线审核IPV6用，美国服务器
#define TEST_URL        @"http://tst.lpsp.coralxt.com"     ///< 测试服务器  tst.ltsj.coralxt.com
#define HOST_URL        @"http://ltsj.xkaopu.com"          ///< 正式服务器
#define SOCKET_DEFAULT_HOST_URL @"ltsj.xkaopu.com"         ///< socket host default
#define SOCKET_DEFAULT_PORT     @"9502"                    ///< socket port default


@interface YPSystemConfigHelper : NSObject

/**
 * 是否过审
 */
+ (BOOL)isApproved;

/**
 * 请求是否过审
 */
+ (void)requestIsApprovedWithCompletion:(void (^)(BOOL isApproved))completion;

/**
 * 获取hostName
 *
 */
+ (NSString *)hostName;

/**
 * 获取socket host name
 */
+ (NSString *)socketHostName;

/**
 * 获取socket port
 */
+ (NSString *)socketPort;

/**
 * 设置Host
 */
+ (void)setHostName:(NSString *)hostname;

/**
 * 获取系统配置
 */
+ (void)requestSystemConfig;

/**
 * 是否可以手机登录
 */
+ (BOOL)isCanMobileLogin;


@end
