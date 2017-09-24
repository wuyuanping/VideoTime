//
//  YPCommon.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#ifndef YPCommon_h
#define YPCommon_h

#pragma mark - 设备尺寸相关
#define kScreenBounds [UIScreen mainScreen].bounds
#define SCREEN_W      kScreenBounds.size.width
#define SCREEN_H      kScreenBounds.size.height

#pragma mark - 颜色相关
#define RCBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HEXCOLOR(rgbValue) HEXACOLOR(rgbValue,1)
#define HEXACOLOR(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]

#pragma mark - 系统版本相关
#define SYSTEM_VERSION     [[[UIDevice currentDevice] systemVersion] doubleValue]
#define iOS10              ([[[UIDevice currentDevice] systemVersion] doubleValue]-10.0>=0)
#define iOS9               ([[[UIDevice currentDevice] systemVersion] doubleValue]-9.0>=0)
#define iOS8               ([[[UIDevice currentDevice] systemVersion] doubleValue]-8.0>=0)
#define iOS7               ([[[UIDevice currentDevice] systemVersion] doubleValue]-7.0>=0)

#pragma mark - iPhone设备相关
#define IPHONE4S            (SCREEN_H <= 480)
#define IPHONE5_OR_EARLIER  (SCREEN_W<= 320)
#define IPHONE5_OR_LATER    (SCREEN_W > 320)
#define IPHONE6_OR_EARLIER  (SCREEN_W < 375)
#define IPHONE6_OR_LATER    (SCREEN_W >= 375)


#pragma mark - APP应用相关
#define iOSAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define iOSBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define iOSAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#define AppDelegateDefine ((AppDelegate *)[UIApplication sharedApplication].delegate)


#pragma mark - 系统默认高度相关
#define kNavigationBarHeight        64.0
#define kTabBarHeight               49.0
#define STATUS_BAR_HEIGHT			20
#define KEYBOARD_HEIGHT				216

#pragma mark - 常用代码
#define YPWeakSelf __weak typeof(self) weakSelf = self;
#define YPStrongSelf __strong typeof(self) strongSelf = weakSelf;
#define SYSTEM_FONT(__fontsize__)   [UIFont systemFontOfSize:__fontsize__]
#define IMAGE_NAMED(__imageName__)  [UIImage imageNamed:__imageName__]
#define NIB_NAMED(__nibName__)      [UINib nibWithNibName:__nibName__ bundle:nil]
#define trim(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] // 去掉字符串前后空格

#endif /* YPCommon_h */
