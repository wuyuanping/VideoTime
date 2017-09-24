//
//  YPRefreshingTableView.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YPRefreshingTableView;
@protocol YPRefreshingTableViewDelegate <NSObject>

/**
 * 下拉刷新回调
 */
- (void)pullingTableViewDidStartRefreshing:(YPRefreshingTableView *)tableView;

/**
 * 上拉加载更多
 */
- (void)pullingTableViewDidStartLoadMoreData:(YPRefreshingTableView *)tableView page:(NSInteger)page;
@end


@interface YPRefreshingTableView : UITableView

@property (nonatomic, assign) id<YPRefreshingTableViewDelegate> pullingDelegate;

//结束刷新
- (void)endRefreshing;
//提示没有更多数据
- (void)noMoreData;
//重置page
- (void)resetPage;

//hide
//- (void)hideRefreshFooter;

//隐藏尾部
- (void)setRefreshFooterHidden:(BOOL)hide;

- (void)viewDidScroll;

@end
