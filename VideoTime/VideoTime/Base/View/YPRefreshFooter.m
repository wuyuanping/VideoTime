//
//  YPRefreshFooter.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPRefreshFooter.h"

@implementation YPRefreshFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultRefreshHeaderStyle];
    }

    return self;
}

- (void)setDefaultRefreshHeaderStyle
{
    // 设置文字
    [self setTitle:@"上拉加载更多数据" forState:MJRefreshStateIdle];
    [self setTitle:@"正在加载中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"没有更多数据了哦" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:13.0];
    // 设置颜色
    self.stateLabel.textColor = [UIColor grayColor];
    // 自动根据有无数据来显示和隐藏（有数据就显示，没有数据隐藏。默认是NO
    self.automaticallyHidden = YES;
}


@end
