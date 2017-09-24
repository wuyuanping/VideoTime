//
//  YPRefreshingTableView.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPRefreshingTableView.h"
#import "YPRefreshHeader.h"
#import "YPRefreshFooter.h"

@interface YPRefreshingTableView ()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger page;

@end

@implementation YPRefreshingTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _page = 1;
        __weak typeof(self) weakself = self;
        self.mj_header = [YPRefreshHeader headerWithRefreshingBlock:^{
            weakself.page = 1;
            //下拉刷新
            if (weakself.pullingDelegate && [weakself.pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartRefreshing:)]) {
                [weakself.pullingDelegate pullingTableViewDidStartRefreshing:weakself];
            }
        }];
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        self.mj_footer = [YPRefreshFooter footerWithRefreshingBlock:^{
            weakself.page++;
            if (weakself.pullingDelegate && [weakself.pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartLoadMoreData:page:)]) {
                [weakself.pullingDelegate pullingTableViewDidStartLoadMoreData:weakself page:weakself.page];
            }
        }];
    }
    return self;
}

- (void)endRefreshing
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)noMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetPage
{
    self.page = 1;
}

//- (void)hideRefreshFooter
//{
//    self.mj_footer.hidden = YES;
//}

- (void)setRefreshFooterHidden:(BOOL)hide
{
    self.mj_footer.hidden = hide;
}

// todo ?
- (void)viewDidScroll
{
    if (self.contentOffset.y > self.contentSize.height - (SCREEN_H - 64 - 49) - 2000) {
        if ([self.mj_footer isRefreshing]) {
            return;
        }
        NSLog(@"loading next");
        [self.mj_footer beginRefreshing];
        self.page++;
        if (self.pullingDelegate && [self.pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartLoadMoreData:page:)]) {
            [self.pullingDelegate pullingTableViewDidStartLoadMoreData:self page:self.page];
        }
    }
}


@end
