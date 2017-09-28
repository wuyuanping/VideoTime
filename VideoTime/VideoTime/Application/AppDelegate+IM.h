//
//  AppDelegate+IM.h
//  VideoTime
//
//  Created by 吴园平 on 27/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

// IM相关写一个分类，结构更清晰，易管理

#import "AppDelegate.h"
//#import <NIMSDK/NIMSDK.h>
#import "NIMKit.h"

@interface AppDelegate (IM)

/**
 * 设置云信IM SDK
 */
- (void)setupIMSDK;

/**
 * 手动登录IM(用户登录平台时)
 */
- (void)manuallyLoginIMWithCompletion:(void(^)(NSError *error))completion;

/**
 * 自动登录(用户登录后，默认每次进入APP都需要自动登录IM)
 */
- (void)autoLoginIM;

@end
