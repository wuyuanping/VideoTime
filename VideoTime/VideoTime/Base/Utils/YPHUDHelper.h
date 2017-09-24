//
//  YPHUDHelper.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

static const CGFloat TimeOut = 20.0;
static const CGFloat HUD_DELAY_TIME = 2.0;

typedef NS_ENUM(NSUInteger, HUDMessageType) {
    HUDMessageTypeInfo,
    HUDMessageTypeSuccess,
    HUDMessageTypeFailed,
    HUDMessageTypeWarning
};

@interface YPHUDHelper : NSObject

//loadding菊花
+ (void)showLoadding;

+ (void)showLoaddingWithMessage:(NSString *)msg;

+ (void)showLoaddingInView:(UIView *)view;

+ (void)showLoaddingInView:(UIView *)view withMessage:(NSString *)msg;

+ (void)showLoaddingInView:(UIView *)view withMessage:(NSString *)msg timeOut:(int)time;

+ (void)showLoaddingInView:(UIView *)view withMessage:(NSString *)msg completion:(void (^)())completion;

// Tip提示信息
+ (void)showTipMessage:(NSString *)msg;

+ (void)showTipMessage:(NSString *)msg delay:(CGFloat)seconds;

+ (void)showTipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;

// 显示状态信息
+ (void)showInfoWithStatus:(NSString*)status;

+ (void)showSuccessWithStatus:(NSString*)status;

+ (void)showFailedWithStatus:(NSString*)status;

+(void)showWarningWithStatus:(NSString *)status;

+(void)showError:(NSError *)error;


// 加载进度条
+ (void)showProgress:(NSProgress *)progress;
+ (MBProgressHUD *)showProgressInView:(UIView *)view;
+ (void)showProgress:(NSProgress *)progress status:(NSString*)status;

// 隐藏
+ (void)dismiss;




@end
