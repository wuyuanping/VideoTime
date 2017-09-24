//
//  YPUserManager.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPUserManager.h"

@implementation YPUserManager

// 获取登录状态
+ (BOOL)isUserLoggedIn
{
    // 根据cookie来判断
    NSString *token = [self token];
    BOOL isLogin = ([token length] > 0) && ([self currentUserData].phone.length > 0);
    return isLogin;
}

// 退出登录
+ (void)userLogOut
{
    [YPUserDataModel setObject:nil forDestKey:UserSetTookenKey];
    [YPUserDataModel setObject:nil forDestKey:UserInfoDictKey];
    
    // 删除cookies
    //    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:SERVER_HOST_URL]];
    //    for (NSHTTPCookie* cookie in cookies)
    //    {
    //        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    //    }
}

// 记录登录状态, 并保存cookie
+ (void)userLoggedInWithToken:(NSString *)tokenString infoDict:(NSDictionary *)infoDict
{
    if (!tokenString || ![infoDict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    // 用户cookie
    [YPUserDataModel setObject:tokenString forDestKey:UserSetTookenKey];
    
    //用户信息
    [YPUserDataModel setObject:infoDict forDestKey:UserInfoDictKey];
}

+ (void)setUserInfo:(NSDictionary *)infoDict
{
    //用户信息
    [YPUserDataModel setObject:infoDict forDestKey:UserInfoDictKey];
}

// 获取cookie
+ (NSString *)token
{
    NSString *tokenString = [YPUserDataModel objectForDestKey:UserSetTookenKey];
    return tokenString;
}

+ (NSString *)NIMAccid
{
    NSString *accid = [YPCommonTool uuidToAccid:self.currentUserData.uuid];
    return accid;
}

+ (NSString *)NIMToken
{
    return self.currentUserData.nim_token;
}

// 获取用户信息
+ (NSDictionary *)userInfoDict
{
    NSDictionary *infoDict = [YPUserDataModel objectForDestKey:UserInfoDictKey];
    
    if (![infoDict isKindOfClass:[NSDictionary class]])
    {
        infoDict = nil;
    }
    return infoDict;
}

+ (YPUserDataModel *)currentUserData
{
    YPUserDataModel *currentUser = [YPUserDataModel yy_modelWithDictionary:[self userInfoDict]];
    return currentUser;
}

+ (BOOL)isFirstLaunch
{
    if (![[YPUserDataModel objectForDestKey:kFirstLaunchKey] boolValue]) {
        [YPUserDataModel setObject:[NSNumber numberWithBool:YES] forDestKey:kFirstLaunchKey];
        return YES;
    } else{
        return NO;
    }
}


@end
