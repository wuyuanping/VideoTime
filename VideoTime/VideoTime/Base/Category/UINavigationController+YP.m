//
//  UINavigationController+YP.m
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "UINavigationController+YP.h"

@implementation UINavigationController (YP)

+ (UINavigationController *)rootNavigationController
{
    // 窗口的根控制器是导航控制器 或者 窗口的根控制器是tabBarVC情况下，tabBarVC选中的控制器
    UITabBarController *tabC = (UITabBarController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    if ([tabC isKindOfClass:[UITabBarController class]]) {
        UINavigationController *navigationController = (UINavigationController *)tabC.selectedViewController;
        return navigationController;
    } else {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        return (UINavigationController *)delegate.window.rootViewController;
    }
}

@end
