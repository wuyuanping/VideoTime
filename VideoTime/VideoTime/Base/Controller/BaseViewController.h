//
//  BaseViewController.h
//  VideoTime
//
//  Created by 吴园平 on 24/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

// 默认自带导航栏，智能隐藏底部tabBar的控制器

#import <UIKit/UIKit.h>
#import "YPNavigationBarView.h"

@interface BaseViewController : UIViewController
//{
//    YPNavigationBarView *_navBar;
//}

@property (nonatomic,strong) YPNavigationBarView *navBar;
/**
 * 获取rootNavigationViewController
 */
- (UINavigationController *)rootNav;

@end
