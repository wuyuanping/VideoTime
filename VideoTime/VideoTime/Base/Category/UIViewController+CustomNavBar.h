//
//  UIViewController+CustomNavBar.h
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPNavigationBarView.h"

@interface UIViewController (CustomNavBar)

@property (nonatomic, strong) YPNavigationBarView *navBar;  ///< 自定义导航栏

- (void)setupNavBar;

@end
