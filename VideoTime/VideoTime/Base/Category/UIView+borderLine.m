//
//  UIView+borderLine.m
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "UIView+borderLine.h"

static NSInteger const kLinesViewTag = 2017;

@implementation UIView (borderLine)

- (void)showBorderLineAtDirection:(BorderLineDirection)direction
{
    [self showBorderLineAtDirection:direction withColor:HEXCOLOR(0xefefef)];
}

- (void)showBorderLineAtDirection:(BorderLineDirection)direction withColor:(UIColor *)color
{
    [self showBorderLineAtDirection:direction withColor:color lineWidth:1];
}

- (void)showBorderLineAtDirection:(BorderLineDirection)direction
                        withColor:(UIColor *)color
                        lineWidth:(CGFloat)width
{
    if (direction & BorderLineDirectionTop) {
        //显示Top线条
        NSInteger tag = kLinesViewTag + BorderLineDirectionTop;
        UIView *lineView = [self viewWithTag:tag];
        if (nil == lineView) {
            lineView = [[UIView alloc] initWithFrame:CGRectZero];
            lineView.backgroundColor = color;
            lineView.tag = kLinesViewTag + BorderLineDirectionTop;
            
            [self addSubview:lineView];
            
            [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.leading.equalTo(@0);
                make.trailing.equalTo(@0);
                make.height.equalTo(@(width));
            }];
        } else {
            lineView.hidden = NO;
        }
    }
    
    if (direction & BorderLineDirectionBottom) {
        //显示Bottom线条
        NSInteger tag = kLinesViewTag + BorderLineDirectionBottom;
        UIView *lineView = [self viewWithTag:tag];
        if (nil == lineView) {
            lineView = [[UIView alloc] initWithFrame:CGRectZero];
            lineView.tag = kLinesViewTag + BorderLineDirectionBottom;
            
            lineView.backgroundColor = color;
            
            [self addSubview:lineView];
            
            [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(@0);
                make.leading.equalTo(@0);
                make.trailing.equalTo(@0);
                make.height.equalTo(@(width));
            }];
        } else {
            lineView.hidden = NO;
        }
    }
    
    if (direction & BorderLineDirectionLeft) {
        //显示Left线条
        NSInteger tag = kLinesViewTag + BorderLineDirectionLeft;
        UIView *lineView = [self viewWithTag:tag];
        if (nil == lineView) {
            lineView = [[UIView alloc] initWithFrame:CGRectZero];
            lineView.tag = kLinesViewTag + BorderLineDirectionLeft;
            lineView.backgroundColor = color;
            [self addSubview:lineView];
            
            [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.leading.equalTo(@0);
                make.width.equalTo(@(width));
            }];
        } else {
            lineView.hidden = NO;
        }
    }
    
    if (direction & BorderLineDirectionRight) {
        //显示Right线条
        NSInteger tag = kLinesViewTag + BorderLineDirectionRight;
        UIView *lineView = [self viewWithTag:tag];
        if (nil == lineView) {
            lineView = [[UIView alloc] initWithFrame:CGRectZero];
            lineView.backgroundColor = color;
            lineView.tag = kLinesViewTag + BorderLineDirectionRight;
            
            [self addSubview:lineView];
            
            [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.trailing.equalTo(@0);
                make.width.equalTo(@(width));
            }];
        } else {
            lineView.hidden = NO;
        }
    }
}

- (void)hideBorderLineAtDirection:(BorderLineDirection)direction
{
    if (direction & BorderLineDirectionRight) {
        NSInteger tag = kLinesViewTag + BorderLineDirectionRight;
        UIView *lineView = [self viewWithTag:tag];
        lineView.hidden = YES;
    }
    
    if (direction & BorderLineDirectionTop) {
        NSInteger tag = kLinesViewTag + BorderLineDirectionTop;
        UIView *lineView = [self viewWithTag:tag];
        lineView.hidden = YES;
    }
    
    if (direction & BorderLineDirectionBottom) {
        NSInteger tag = kLinesViewTag + BorderLineDirectionBottom;
        UIView *lineView = [self viewWithTag:tag];
        lineView.hidden = YES;
    }
    
    if (direction & BorderLineDirectionLeft) {
        NSInteger tag = kLinesViewTag + BorderLineDirectionLeft;
        UIView *lineView = [self viewWithTag:tag];
        lineView.hidden = YES;
    }
}

@end
