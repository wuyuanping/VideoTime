//
//  YPNavigationBarView.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

//  此类为公共的自定义NavigationBarView,界面采用自动布局，如果需要改变控件位置，
//  请在初始化自定义导航栏后复写控件布局

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YPNavigationBarStyle)
{
    YPNavigationBarStyleMainColor,   //主色调 background navigation bar
    YPNavigationBarStyleWhite       //white background navigation bar
};

#define kSTATUS_BAR_HEIGHT      20
#define kNAVIGATION_BAR_HEIGHT  64

@interface YPNavigationBarView : UIView

@property (nonatomic, readonly) YPNavigationBarStyle style;     ///< 导航栏风格，默认为白底
@property (nonatomic, copy)     NSString *title;                ///< 标题
@property (nonatomic, strong)   UILabel *titleLabel;            ///< 标题Label
@property (nonatomic, assign)   CGFloat barHeight;              ///< 导航栏高度
@property (nonatomic, strong)   UIButton *leftButton;           ///< 导航栏左侧按钮
@property (nonatomic, strong)   UIButton *rightButton;          ///< 导航栏右侧按钮

/**
 * 设置左侧按钮背景图片
 *@param bgImage 左侧按钮背景图片
 *@param state 按钮状态
 */
- (void)setLeftButtonBgImage:(UIImage *)bgImage forState:(UIControlState)state;

/**
 * 设置右侧按钮背景图片
 *@param bgImage 右侧按钮背景图片
 *@param state 按钮状态
 */
- (void)setRightButtonBgImage:(UIImage *)bgImage forState:(UIControlState)state;

/**
 * 设置状态栏高度
 *@param barHeight 高度
 */
- (void)setBarHeight:(CGFloat)barHeight;

/**
 * 设置底部线条颜色
 *@param color 线条颜色
 */
- (void)setBottomLineColor:(UIColor *)color;

/**
 * 设置底部线条是否隐藏，默认显示
 *@param hidden 是否隐藏
 */
- (void)setBottomLineHidden:(BOOL)hidden;

/**
 * 设置是否隐藏右侧按钮
 *@param hidden 如果是yes,此方法会删除右侧按钮,为NO会新建一个按钮
 */
- (void)setRightButtonHidden:(BOOL)hidden;

/**
 * 设置是否隐藏左侧按钮
 *@param hidden 如果是yes,此方法会删除左侧按钮,为NO会新建一个按钮
 */
- (void)setLeftButtonHidden:(BOOL)hidden;

/**
 * 设置style
 */
- (void)setStyle:(YPNavigationBarStyle)style;

/**
 * 显示状态栏消息
 */
- (void)showStatusMessage:(NSString *)message;

/**
 * 隐藏状态栏消息
 */
- (void)hideStatusMessage:(BOOL)hidden;

@end
