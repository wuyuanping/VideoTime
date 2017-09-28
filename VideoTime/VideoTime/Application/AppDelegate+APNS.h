//
//  AppDelegate+APNS.h
//  VideoTime
//
//  Created by 吴园平 on 27/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

// 通知相关 写一个分类，结构清晰易管理。

#import "AppDelegate.h"

@interface AppDelegate (APNS)

/**
 * 初始化消息推送
 */
- (void)initPushNotificationConfiguration;

- (void)handleWithPush:(NSDictionary*)payloadDict application:(UIApplication *)application;

- (void)notificationAction;

@end
