//
//  YPBannerPageView.h
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPCollectionViewCell.h"

#define  kBannerHeight  SCREEN_W/(750/225.0) // 轮播图高度，具体按实际更改！

typedef void(^CellConfigureBlock)(id cell,id item);
typedef void(^BannerCollectionCellSelectedBlock)(id cell, NSIndexPath *indexPath);

@interface YPBannerPageView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) CGFloat bannerHeight; /**< Banner高度 */
@property (nonatomic, copy) CellConfigureBlock block;
@property (nonatomic, copy) BannerCollectionCellSelectedBlock selectedCellBlock;

- (instancetype)initWithFrame:(CGRect)frame configureCellBlock:(CellConfigureBlock)block;

/**
 * 刷新数据显示
 */
- (void)reloadData;

@end

//BannerPageCell
@interface YPBannerCollectionViewCell : YPCollectionViewCell

@end
