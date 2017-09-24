//
//  UIViewController+CustomNavBar.m
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "UIViewController+CustomNavBar.h"
//#import "BaseTabBarController.h"

static const void *NavBar = &NavBar;

@implementation UIViewController (CustomNavBar)

@dynamic navBar;  // 表示手动实现属性的setter和getter，则系统不会替我们实现,不加也无所谓？

- (void)setupNavBar
{
    self.navigationController.navigationBarHidden = YES;
    if (!self.navBar) {
        self.navBar = [[YPNavigationBarView alloc] initWithFrame:CGRectZero];
        self.navBar.title = self.title;
        [self.navBar.leftButton addTarget:self action:@selector(navBarBackItemButtonClickedEvent:)
                         forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.navBar];
    }
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.equalTo(@(kNAVIGATION_BAR_HEIGHT));
    }];
}

#pragma mark - Event Response

- (void)navBarBackItemButtonClickedEvent:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter/Setter

- (YPNavigationBarView *)navBar
{
    
    return objc_getAssociatedObject(self, NavBar);
}

- (void)setNavBar:(YPNavigationBarView *)navBar
{
    objc_setAssociatedObject(self, NavBar, navBar, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
