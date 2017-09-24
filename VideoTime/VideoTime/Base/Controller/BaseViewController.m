//
//  BaseViewController.m
//  VideoTime
//
//  Created by 吴园平 on 24/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    //设置隐藏默认导航栏
    self.navigationController.navigationBarHidden = YES;
    //设置当push View Controller时，隐藏底部tabbar
    self.hidesBottomBarWhenPushed = YES;
    // 设置忽略导航栏高度，View的坐标从(0,0)为原点(默认为(64.0))
    [self setExtendedLayout];
    [self.view addSubview:self.navBar];
    [self setupNavigationBarLayout];
}

- (void)setExtendedLayout
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    //忽略导航高度，从最顶部开始算
    self.navigationController.navigationBar.translucent = YES;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupNavigationBarLayout
{
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.equalTo(@(kNAVIGATION_BAR_HEIGHT));
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 这里也放一份是为了防止其他人创建的ViewCtrl打开系统NavigationBar 设置隐藏默认导航栏
    self.navigationController.navigationBarHidden = YES;
    // 设置Navbar
    if (nil == _navBar) {
        
    }
    
    if (self.title) {
        self.navBar.title = self.title;
    }
    if(self.navigationController.viewControllers.count > 1) {
        [[self getTabBarViewCtrl] showTabBarControllerOrHide:NO];
    }
    NSLog(@"😍😍😍WillAppear:%@", NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_navBar) {
        [_navBar.leftButton addTarget:self action:@selector(navBarBackItemButtonClickedEvent:)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.navigationController.viewControllers.count > 1) {
        [[self getTabBarViewCtrl] showTabBarControllerOrHide:NO];
    } else {
        [[self getTabBarViewCtrl] showTabBarControllerOrHide:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //友盟页面统计
//    [MobClick endLogPageView:NSStringFromClass([self class])];
    NSLog(@"😂😂😂WillDisappear:%@", NSStringFromClass([self class]));
}

#pragma mark - Helper
- (BaseTabBarController *)getTabBarViewCtrl
{
    return (BaseTabBarController *)self.tabBarController;
}

#pragma mark - Get root View Ctrl
- (UINavigationController *)rootNav
{
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *keyWindow = nil;
    if (iOS9) {
        keyWindow = [[application delegate] window];
    } else {
        keyWindow = [application keyWindow];
    }
    
    UINavigationController *nav = nil;
    // 获取当前活动的navigationcontroller
    if ([keyWindow.rootViewController isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)keyWindow.rootViewController;
    } else if ([keyWindow.rootViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectVc = [((UITabBarController *)keyWindow.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]]) {
            nav = (UINavigationController *)selectVc;
        }
    }
    return nav;
}

#pragma mark - Event Response

- (void)navBarBackItemButtonClickedEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter/Setter
- (YPNavigationBarView *)navBar
{
    if (nil == _navBar) {
        _navBar = [[YPNavigationBarView alloc] initWithFrame:CGRectZero];
    }
    return _navBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
