//
//  YPRefreshingViewController.m
//  VideoTime
//
//  Created by 吴园平 on 24/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPRefreshingViewController.h"
#import "YPRefreshHeader.h"
#import "YPRefreshFooter.h"

@interface YPRefreshingViewController ()

@end

@implementation YPRefreshingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //加入ContentScrollView
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.contrainerView];
    
    //    NSArray *idleImages = @[[UIImage imageNamed:@"refresh01"],
    //                            [UIImage imageNamed:@"refresh02"]];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    YPRefreshHeader *header = [YPRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginRefreshing)];
    self.contentScrollView.mj_header = header;
    
    YPRefreshFooter *footer = [YPRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginLoadMore)];
    self.contentScrollView.mj_footer = footer;
    
    //加入下拉刷新
    //[self.contentScrollView addHeaderWithTarget:self action:@selector(beginRefreshing)];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //自动布局
    [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [_contrainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(_contentScrollView.mas_width);
    }];
    //子类的底部视图的bottom = containerView bottom 否则无法设置scrollView ContentSize
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma makr - refreshing target
- (void)beginRefreshing
{
    //子类必须重写此类
}

- (void)beginLoadMore
{
    //子类必须重写此类
}

- (void)endRefreshing
{
    if (self.contentScrollView.mj_header) {
        [self.contentScrollView.mj_header endRefreshing];
        [self.contentScrollView.mj_footer endRefreshing];
    }
}

- (void)noMoreData
{
    [self.contentScrollView.mj_footer endRefreshingWithNoMoreData];
}

- (void)setRefreshFooterHidden:(BOOL)hide
{
    self.contentScrollView.mj_footer.hidden = hide;
    if (!hide) {
        YPRefreshFooter *footer = [YPRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginLoadMore)];
        self.contentScrollView.mj_footer = footer;
    }
}

#pragma mark - Getter/Setter
- (UIScrollView *)contentScrollView
{
    if (nil == _contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentScrollView.alwaysBounceVertical = YES;
        _contentScrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentScrollView;
}

- (UIView *)contrainerView
{
    if (nil == _contrainerView) {
        _contrainerView = [[UIView alloc] initWithFrame:CGRectZero];
        _contrainerView.backgroundColor = HEXCOLOR(0xf8f8f8);
    }
    return _contrainerView;
}

@end
