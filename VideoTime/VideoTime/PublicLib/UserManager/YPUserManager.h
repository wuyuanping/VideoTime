//
//  YPUserManager.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPUserDataModel.h"

@interface YPUserManager : NSObject

/**
 * 获取登录状态
 *@return YES 已经登录APP, NO 没有登录
 */
+ (BOOL)isUserLoggedIn;

/**
 * 退出登录
 */
+ (void)userLogOut;

/**
 * 记录登录状态, 并保存Token
 **/
+ (void)userLoggedInWithToken:(NSString *)tokenString
                     infoDict:(NSDictionary *)infoDict;

/**
 * 设置用户信息
 */
+ (void)setUserInfo:(NSDictionary *)infoDict;

/**
 * 获取用户信息
 */
+ (NSDictionary *)userInfoDict;

/**
 * 获取token
 **/
+ (NSString *)token;

/**
 * 云信Accid
 */
+ (NSString *)NIMAccid;

/**
 * 云信token
 */
+ (NSString *)NIMToken;


+ (YPUserDataModel *)currentUserData;

/**
 * 是否第一次启动
 */
+ (BOOL)isFirstLaunch;

@end
