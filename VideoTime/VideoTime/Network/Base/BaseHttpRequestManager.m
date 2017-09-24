//
//  BaseHttpRequestManager.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseHttpRequestManager.h"
#import "YPSystemConfigHelper.h"
#import "YPUserManager.h"

#import <netinet/in.h>


@interface BaseHttpRequestManager()

@property (nonatomic, assign) AFNetworkReachabilityStatus currentNetworkingStatus;

@end

static NSInteger kInitNetworkingStatus = -2;

@implementation BaseHttpRequestManager

//单例
+ (instancetype)sharedManager
{
    static BaseHttpRequestManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfig setHTTPCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
        [sessionConfig setHTTPShouldSetCookies:NO];
        //设置BaseURL
        // 设置Host
        NSURL *baseURL = [[NSURL alloc] initWithString:[YPSystemConfigHelper hostName]];
        instance = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:sessionConfig];
    });
    return instance;
}

- (id)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (self) {
        _currentNetworkingStatus = kInitNetworkingStatus; // 状态初始化
        // 使用AFNetworking网络监测类
        [self reachability];
        //请求参数序列化类型
//         self.requestSerializer = [AFJSONRequestSerializer serializer];
        //响应结果序列化类型
//         self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/x-javascript",nil];
    }
    return self;
}

//基础网络请求
- (void)requestWithPath:(NSString *)url
                 method:(YPHttpRequestType)method
             parameters:(id)parameters
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if (![[YPSystemConfigHelper hostName] isEqualToString:self.baseURL.relativeString]) {
        if (![NSURL URLWithString:url].scheme) {
            url = [NSString stringWithFormat:@"%@%@", [YPSystemConfigHelper hostName], url];
        }
    }
    
    //判断网络状况（有链接：执行请求；无链接：控制台输出不执行信息 并 广播通知）
    if ([self isConnectionAvailable]) {
        switch (method) {
            case YPHttpRequestTypeGet:
            {
                [self GET:url parameters:parameters progress:nil success:success failure:failure];
            }
                break;
            case YPHttpRequestTypePost:
            {
                [self POST:url parameters:parameters progress:nil success:success failure:failure];
            }
                break;
            case YPHttpRequestTypeDelete:
            {
                [self DELETE:url parameters:parameters success:success failure:failure];
            }
                break;
            case YPHttpRequestTypePut:
            {
                [self PUT:url parameters:parameters success:success failure:false];
            }
                break;
            default:
                break;
        }
    } else {
        //网络错误咯, 返回错误信息
        NSDictionary *errorMsg = @{@"msg" : @"ㄒoㄒ~~网络连接不上！"};
        NSError *error = [[NSError alloc] initWithDomain:url code:555 userInfo:errorMsg];
        failure(nil, error);
        
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_NETWORK_ERROR object:nil];
        
        // 弹框显示无网络
//        [self showExceptionDialog];
    }
}



//Header带有token的网络请求(带Cookie的HTTP请求（GET、POST、DELETE、PUT）)
- (void)requestWithPathHaveToken:(NSString *)url
                          method:(YPHttpRequestType)method
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *token = [YPUserManager token];
    if (token && token.length > 0) {
        NSString *tokenBearer = [NSString stringWithFormat:@"Bearer %@",[YPUserManager token]];
        //  tokenBearer = @"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cL3RzdC5scHNwLmNvcmFseHQuY29tXC9hcGlcL2F1dGhcL21vYmlsZSIsImlhdCI6MTQ5ODEyNzc4MiwiZXhwIjoxNDk5MzM3MzgyLCJuYmYiOjE0OTgxMjc3ODIsImp0aSI6IkhSY2Y1NmU1aHFSUWJXZ3UifQ.zH96gpECP0iorgY0_E6tz4KY4brjuMqIUn7H5XC7eiM";
        [self.requestSerializer setValue:tokenBearer forHTTPHeaderField:@"Authorization"];
    }
    [self.requestSerializer setHTTPShouldHandleCookies:YES];
    //网络请求
    [self requestWithPath:url method:method parameters:parameters success:success failure:failure];
}

//Header带有Sign验证头的网络请求
- (void)requestWithSignAndPath:(NSString *)url
                        method:(YPHttpRequestType)method
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if (!parameters) {
        //如果为空，创建一个NSMutableDictionary
        parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    //生成sign
    NSString *sign = [BaseNetworkHandler generateSignString:parameters];
    
    //在Header中加入sign
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setHTTPShouldSetCookies:NO];
    
    //如果需要cookie，那么传入
    //    NSMutableDictionary *headerDict = [NSMutableDictionary dictionary];
    //    if (useCookie) {
    //        headerDict = [NSMutableDictionary dictionaryWithDictionary:[self getUserSSONeedLogin:YES]];
    //        [self.requestSerializer setValue:[headerDict objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    //    }
    
    [self.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    //网络请求
    [self requestWithPath:url method:method parameters:parameters success:success failure:failure];
}

//网络监测
- (void)reachability
{
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    /* AFNetworking的Block内使用self须改为weakSelf, 避免循环强引用, 无法释放 */
    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         switch (status)
         {
             case AFNetworkReachabilityStatusUnknown:
                 // 未知网络 回调处理
             {   //没网络状态切到有网络状态提醒
                 if (_currentNetworkingStatus == AFNetworkReachabilityStatusNotReachable) {
                     [weakSelf.operationQueue cancelAllOperations];
                     [YPHUDHelper showSuccessWithStatus:@"网络回来啦！刷新界面重新获取数据"];
                 }
                 _currentNetworkingStatus = status;
             }
                 break;
             case AFNetworkReachabilityStatusNotReachable:
             {
                 // 无网络 回调处理
                 [weakSelf.operationQueue cancelAllOperations];
                 [YPHUDHelper showFailedWithStatus:@"网络连接出问题了,快检查一下哦！" ];
                 _currentNetworkingStatus = status;
             }
                 break;
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 // 2G/3G/4G 回调处理
             {
                 //没网络状态切到有网络状态提醒
                 if (_currentNetworkingStatus == AFNetworkReachabilityStatusNotReachable) {
                     [weakSelf.operationQueue cancelAllOperations];
                     [YPHUDHelper showSuccessWithStatus:@"网络回来啦！刷新界面重新获取数据"];
                 }
                 _currentNetworkingStatus = status;
             }
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 // WIFI网络 回调处理
             {
                 //没网络状态切到有网络状态提醒
                 if (_currentNetworkingStatus == AFNetworkReachabilityStatusNotReachable) {
                     [weakSelf.operationQueue cancelAllOperations];
                     [YPHUDHelper showSuccessWithStatus:@"网络回来啦！刷新界面重新获取数据"];
                 }
                 _currentNetworkingStatus = status;
             }
                 break;
             default:
                 break;
         }
     }];
}

//看看网络是不是给力
- (BOOL)isConnectionAvailable
{
    // Create zero addy
    struct sockaddr_in zeroAddress;  // #import <netinet/in.h>
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

//弹出网络错误提示框
//- (void)showExceptionDialog
//{
//    [[[UIAlertView alloc] initWithTitle:@"提示"
//                                message:@"网络异常，请检查网络连接"
//                               delegate:self
//                      cancelButtonTitle:@"好的"
//                      otherButtonTitles:nil, nil] show];
//}


#pragma mark - Helper

///**
// * 获取用户sso
// *@param needLogin：是否需要登录
// */
//- (NSDictionary *)getUserSSONeedLogin:(BOOL)needLogin {
//    //判断是否登录，如果没有登录，就跳转到登录界面
//    NSString *sso = [PBAUserManager getUserCookieStringIfNeedLogin:needLogin];
//
//    //如果为nil,设置为@“”，防止崩溃
//    sso = nil == sso ? @"": sso;
//
//    NSDictionary *properties = [[NSMutableDictionary alloc] init];
//    [properties setValue:sso forKey:NSHTTPCookieValue];
//    [properties setValue:@"sso" forKey:NSHTTPCookieName];
//    [properties setValue:SERVER_HOST_URL forKey:NSHTTPCookieDomain];
//    [properties setValue:@"/asi-http-request/sso" forKey:NSHTTPCookiePath];
//    NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
//
//    return [NSHTTPCookie requestHeaderFieldsWithCookies:@[cookie]];
//}



@end
