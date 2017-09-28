//
//  AppDelegate.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+IM.h"
#import "AppDelegate+APNS.h"
#import "BaseNavigationController.h"

#import "YPLoginViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 初始化第三方SDK配置
    [self initThirdPartySDKConfigWithLaunchOptions:launchOptions];
    // 注册消息通知（通知中心添加观察者）
    [self reigsterNotifications];
    // 请求服务器返回系统配置数据
    [self requestSystemConfig];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    // 设置窗口的根控制器(现有窗口才行)
    [self setupRootViewController];
    // 检查是否从通知启动
    
    
    return YES;
}

/**
 * 初始化第三方SDK配置
 */
- (void)initThirdPartySDKConfigWithLaunchOptions:(NSDictionary *)launchOptions
{
    // 设置IM(即时通讯)
//    [self setupIMSDK];
    // 配置Bugly错误统计
    
    // 配置消息推送，已移至云通信自动登录完成之后
    [self initPushNotificationConfiguration];
    // 微信注册appid
    
    // 友盟分享
    
    //初始化诸葛SDK(用户行为数据分析)

}

- (void)reigsterNotifications
{
    // 注册用户登录成功消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserLogined:)
                                                 name:USER_LOGINED_NOTIFICATION object:nil];
    // 注册用户登出消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserLogout:) name:USER_LOGOUT_NOTIFICATION object:nil];
    
//    // 注册呼叫事件
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatCaller:) name:CHAT_INVITE_NOTIFICATION object:nil];
//    // 注册被呼叫事件
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatCalling:) name:CHAT_CALLING_NOTIFICATION object:nil];
//    
//    // 注册被呼叫通知事件
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appCalling:) name:APP_CALLING_NOTIFICATION object:nil];
//    
//    // 监听状态栏的frame变化，如接入热点时状态栏会增加20像素
//    [[ NSNotificationCenter defaultCenter ] addObserver : self selector : @selector (layoutControllerSubViews:) name : UIApplicationDidChangeStatusBarFrameNotification object : nil ];
}

- (void)requestSystemConfig
{
    [YPSystemConfigHelper requestSystemConfig];
}

/**
 * 设置Window的RootViewController
 */
- (void)setupRootViewController
{
    // 请求获取过审开关接口（block中保存是否审核通过结果）
    [YPSystemConfigHelper requestIsApprovedWithCompletion:^(BOOL isApproved) {
        
    }];
    // 是否登录，如果没有登录跳转到登录页面，否则直接进入主页面
    if (![YPUserManager isUserLoggedIn]) {
        // 显示登录页面
        [self setLoginViewController];
    } else {
        // 如果已经登录成功，使用保存的IM accid和token自动登录IM
        [self autoLoginIM];
        // 获取权限，如果没有则跳出授权页面获取权限
        if ([[NSUserDefaults standardUserDefaults] valueForKey:Authorization]) {
            NSInteger state = [[[NSUserDefaults standardUserDefaults] valueForKey:Authorization] integerValue];
            if (state == 7) {
//                [self setMainViewController];
            } else{
//                [self setLoadingRootView:YES];
            }
        } else {
//            [self setLoadingRootView:YES];
        }
//        [self rquestGetMyQRCode];
    }
}

/**
 * 设置登录页面为RootViewCtrl
 */
- (void)setLoginViewController
{
    YPLoginViewController *loginViewController = [[YPLoginViewController alloc] init];
    BaseNavigationController *loginNavigationController = [[BaseNavigationController alloc] initWithRootViewController:loginViewController];
    self.window.rootViewController = loginNavigationController;
}

#pragma mark - 用户登录、注销消息通知响
- (void)onUserLogined:(NSNotification *)notification
{
    // 登录成功消息通知
    __weak typeof(self) ws = self;
    [self manuallyLoginIMWithCompletion:^(NSError *error) {
        if (error == nil) {
            [ws setupRootViewController];
        } else {
            // 登录失败、请求服务器刷新token
            [YPHUDHelper showFailedWithStatus:@"IM登录失败"];
        }
    }];
    
//    [self requestUserInfo];
}

- (void)onUserLogout:(NSNotification *)notification
{
    // 删除token、IM accid和token
    [YPUserManager userLogOut];
    // 登出
    [self setLoginViewController];
}

    
    

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
