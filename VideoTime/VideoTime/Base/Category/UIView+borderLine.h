//
//  UIView+borderLine.h
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_OPTIONS(NSUInteger,BorderLineDirection){
    BorderLineDirectionTop    = 1 << 0,
    BorderLineDirectionBottom = 1 << 1,
    BorderLineDirectionLeft   = 1 << 2,
    BorderLineDirectionRight  = 1 << 3,
    BorderLineDirectionAll    = 15
};

@interface UIView (borderLine)

/**
 * 绘制边线
 *@param direction 需要绘制的方向
 */
- (void)showBorderLineAtDirection:(BorderLineDirection)direction;

/**
 * 绘制边线
 *@param direction 需要绘制的方向
 *@param color 线条颜色
 */
- (void)showBorderLineAtDirection:(BorderLineDirection)direction withColor:(UIColor *)color;

/**
 *隐藏指定方向的线条
 */
- (void)hideBorderLineAtDirection:(BorderLineDirection)direction;


@end
