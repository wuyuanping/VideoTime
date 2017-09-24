//
//  BaseTabBarController.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@property (nonatomic, strong) UIView *separateLine;   //tabBar顶部的分割线（颜色是动态变化的）
@property (nonatomic, strong) UIImageView *tabBarView;//自定义的tabbar底板
@property (nonatomic, strong) UIImageView *badgeView; //显示有未读新消息的提示
@property (nonatomic, strong) UIView *blackView;      //黑幕

@property (nonatomic, strong) NSMutableArray *tabBarItems;//tabbar上的items
@property (nonatomic,assign) NSInteger sessionUnreadCount;
@property (nonatomic,assign) NSInteger systemUnreadCount;
@property (nonatomic,assign) NSInteger customSystemUnreadCount;

@end

@implementation BaseTabBarController

#pragma mark - LifeCycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        //隐藏tabbar，自定义tabbar
        self.tabBar.hidden = YES;
        self.tabBar.translucent = YES;
        [self.tabBar removeFromSuperview];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    _tabBarItems = [[NSMutableArray alloc] initWithCapacity:5];
    
    //    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    //    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    //    self.sessionUnreadCount  = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    //    self.systemUnreadCount   = [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
}

- (id)initWithTabBarItemsWithNormalImages:(NSArray *)normalImages
                           selectedImages:(NSArray *)selectedImages
                                   titles:(NSArray *)titles
                           backgroudImage:(UIImage *)bgImage
{
    self = [self init];
    if (self) {
        self.tabBar.hidden = YES;
        
        //自定义tabbar视图
        _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_H - kTabbar_Height, SCREEN_W, kTabbar_Height)];
        _tabBarView.userInteractionEnabled = YES;
        
        //添加毛玻璃模糊效果
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, _tabBarView.width, _tabBarView.height)];
        toolbar.translucent = YES;
        toolbar.clipsToBounds = YES;
        [_tabBarView addSubview:toolbar];
        _tabBarView.backgroundColor = [UIColor clearColor];
        
        //设置背景
        if(bgImage) {
            _tabBarView.image = bgImage;
            _tabBarView.backgroundColor = [UIColor clearColor];
        } else {
            _tabBarView.backgroundColor = [UIColor whiteColor];
        }
        [self.view addSubview:_tabBarView];
        
        for (int i = 0; i < normalImages.count; i++) {
            //初始化按键，默认选中第一个
            YPTabbarItemButton *item = [YPTabbarItemButton buttonWithType:UIButtonTypeCustom];
            item.frame = CGRectMake(i*(SCREEN_W/normalImages.count), 0, SCREEN_W/normalImages.count, kTabbar_Height);
            
            UIImage *normalImage = [UIImage imageNamed:normalImages[i]];
            UIImage *selectedImage = [UIImage imageNamed:selectedImages[i]];
            
            // 使用URL设置图片
//            NSURL *normalImageUrl = [NSURL URLWithString:normalImages[i]];
//            NSURL *selectedImageUrl = [NSURL URLWithString:selectedImages[i]];
//            [item sd_setImageWithURL:normalImageUrl forState:UIControlStateNormal];
//            [item sd_setImageWithURL:normalImageUrl forState:UIControlStateHighlighted];
//            [item sd_setImageWithURL:selectedImageUrl forState:UIControlStateSelected];
            
            [item setImage:normalImage forState:UIControlStateNormal];
            [item setImage:normalImage forState:UIControlStateHighlighted];
            [item setImage:selectedImage forState:UIControlStateSelected];
            
            item.backgroundColor = [UIColor clearColor];
            [item setTitle:titles[i] forState:UIControlStateNormal];
            [item setTitleColor:HEXCOLOR(0xc9caca) forState:UIControlStateNormal];
            [item setTitleColor:HEXCOLOR(0xc9caca) forState:UIControlStateHighlighted];
            [item setTitleColor:HEXCOLOR(0xff6633) forState:UIControlStateSelected];
            item.titleLabel.font = [UIFont systemFontOfSize:10.0f];
            
            CGSize iconSize = CGSizeMake(30, 30);
            
            CGFloat imageLeftAndRight = (item.width-iconSize.width)/2.0;
            item.imageEdgeInsets = UIEdgeInsetsMake(5, imageLeftAndRight, 15, imageLeftAndRight);
            item.titleEdgeInsets = UIEdgeInsetsMake(5 + iconSize.height, -15, 5, 15);
            
            // 如果图片大小超过30，那么就重现设置edgeInsets,显示中间的大图标
            if (item.imageView.image.size.height > 30) {
                item.imageEdgeInsets = UIEdgeInsetsMake(5, (item.width-(kTabbar_Height-10))/2.0, 5, (item.width-(kTabbar_Height-10))/2.0);
            }
            
            [item addTarget:self action:@selector(changeSelectedVC:) forControlEvents:UIControlEventTouchUpInside];
            [_tabBarView addSubview:item];
            [_tabBarItems addObject:item];
        }
        
        //初始化分割线
        _separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 0.5)];
        _separateLine.backgroundColor = HEXCOLOR(0xe2e2e2);
        [_tabBarView addSubview:_separateLine];
        
        //黑幕
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, kTabbar_Height)];
        _blackView.backgroundColor = RGBAColor(0, 0, 0, 0.7);
        [_tabBarView addSubview:_blackView];
        _blackView.hidden = YES;
    }
    return self;
}

#pragma mark - ChangeViewCtrl
//通过点击tabbarItem改变selectedIndex
-(void)changeSelectedVC:(YPTabbarItemButton *)item
{
    self.selectedIndex = [_tabBarItems indexOfObject:item];
}

#pragma mark - private method
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
//    if (![YPSystemConfigHelper isApproved]&&selectedIndex == 2) {
//        MARFaceBeautyController *faceBeautyVC = [[MARFaceBeautyController alloc] init];
//        [self presentViewController:faceBeautyVC animated:YES completion:nil];
//        return;
//    }
    //是否实现跳转
    if (self.TabBardelegate && ![self.TabBardelegate BaseTabBarController:selectedIndex]) return;
    
    //上次选中的item，移除选中效果
    NSUInteger lastIndex = (self.selectedIndex < [_tabBarItems count] && self.selectedIndex != NSIntegerMin-1) ? self.selectedIndex : 0;
    YPTabbarItemButton *lastItem = [_tabBarItems objectAtIndex:lastIndex];
    lastItem.selected = NO;
    
    //设置当前的selectedIndex
    [super setSelectedIndex:selectedIndex];
    
    self.tabBar.hidden = YES;
    //选中当前的item，切换为选中状态
    if (selectedIndex < [_tabBarItems count]) {
        UIButton *button = [_tabBarItems objectAtIndex:self.selectedIndex];
        button.selected = YES;
    }
}

#pragma mark - show or hide Tabbar
- (void)showTabBarControllerOrHide:(BOOL)show
{
    [self showTabBarControllerOrHide:show WithDuraton:0.2];
}

-(void)showTabBarControllerOrHide:(BOOL)show WithDuraton:(float)duration
{
    if(show) {
        [UIView animateWithDuration:duration animations:^{
            CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
            if (statusBarRect.size.height == 40){
                _tabBarView.top = SCREEN_H - kTabbar_Height - 20;
            }
            else{
                _tabBarView.top = SCREEN_H - kTabbar_Height;
            }
        } completion:nil];
    } else {
        [UIView animateWithDuration:duration animations:^{
            _tabBarView.top = SCREEN_H;
        } completion:nil];
    }
}

#pragma mark - Show badge number View
- (void)showBadgeViewWithNumber:(NSInteger)number atIndex:(NSInteger)index
{
    YPTabbarItemButton *item = [_tabBarItems objectAtIndex:index];
    //如果消息为0，免谈
    if (number <= 0) {
        item.badgeNumberLabel.hidden = YES;
        return;
    }
    if (nil == item.badgeNumberLabel) {
        UILabel *badgeNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(item.width/2+5, item.top+5, 14, 14)];
        badgeNumberLabel.textColor = [UIColor whiteColor];
        badgeNumberLabel.font = [UIFont systemFontOfSize:10.0f];
        badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
        badgeNumberLabel.layer.cornerRadius = 7;
        badgeNumberLabel.layer.masksToBounds = YES;
        badgeNumberLabel.backgroundColor = HEXCOLOR(0xff6633);
        [item addSubview:badgeNumberLabel];
        item.badgeNumberLabel = badgeNumberLabel;
    }
    
    NSString *numberString = [NSString stringWithFormat:@"%ld", (long)number];
    if (number > 99) {
        numberString = @"99+";
    }
    item.badgeNumberLabel.text = numberString;
    
    if (number >= 10) {
        CGSize size = [item.badgeNumberLabel sizeThatFits:CGSizeZero];
        item.badgeNumberLabel.width = size.width + 5;
    } else if (number == -1) {
        //小点
        item.badgeNumberLabel.size = CGSizeMake(6, 6);
        item.badgeNumberLabel.layer.cornerRadius = 3.0f;
        item.badgeNumberLabel.text = @"";
    }
    
    //    全部都使用小点表示
    //    item.badgeNumberLabel.size = CGSizeMake(7, 7);
    //    item.badgeNumberLabel.layer.cornerRadius = 3.5f;
    //    item.badgeNumberLabel.text = @"";
    //----------------------------------//
    
    item.badgeNumberLabel.hidden = NO;
}

- (void)hideBadgeView:(int)index
{
    YPTabbarItemButton *item = [_tabBarItems objectAtIndex:index];
    item.badgeNumberLabel.hidden = YES;
}

#pragma mark - show or hide blackView
-(void)showBlackView:(BOOL)show
{
    self.blackView.hidden = show;
}

#pragma mark - changViewFrame
- (void)changeViewY:(int)y
{
    _tabBarView.frame = CGRectMake(_tabBarView.frame.origin.x, y, _tabBarView.frame.size.width, _tabBarView.frame.size.height);
}

#pragma mark - NIMConversationManagerDelegate
//- (void)didAddRecentSession:(NIMRecentSession *)recentSession
//           totalUnreadCount:(NSInteger)totalUnreadCount
//{
//    self.sessionUnreadCount = totalUnreadCount;
//    [self refreshSessionBadge];
//}
//
//- (void)didUpdateRecentSession:(NIMRecentSession *)recentSession
//              totalUnreadCount:(NSInteger)totalUnreadCount
//{
//    self.sessionUnreadCount = totalUnreadCount;
//    [self refreshSessionBadge];
//}
//
//
//- (void)didRemoveRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount
//{
//    self.sessionUnreadCount = totalUnreadCount;
//    [self refreshSessionBadge];
//}
//
//- (void)messagesDeletedInSession:(NIMSession *)session
//{
//    self.sessionUnreadCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
//    [self refreshSessionBadge];
//}

//- (void)allMessagesDeleted
//{
//    self.sessionUnreadCount = 0;
//    [self refreshSessionBadge];
//}

//- (void)refreshSessionBadge
//{
//    NSInteger badgeNumber = self.sessionUnreadCount;
//    [self showBadgeViewWithNumber:badgeNumber atIndex:3];
//}

@end

@implementation YPTabbarItemButton

@end

