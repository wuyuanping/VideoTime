//
//  YPBannerPageView.m
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPBannerPageView.h"

#define APP_DOMINANT_COLOR      HEXCOLOR(0x00e2d6) ///< 青色主色调

@interface YPBannerPageView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *bannerCollectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSTimeInterval roundRobinTimeDelay;    //轮循时延
@property (nonatomic, strong) NSTimer *timer;                        //轮循定时器

@end

@implementation YPBannerPageView

- (instancetype)initWithFrame:(CGRect)frame configureCellBlock:(CellConfigureBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        _block = block;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bannerCollectionView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.bannerHeight == 0) {
        self.bannerHeight = kBannerHeight;
    }
    
    [_bannerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(self.bannerHeight));
    }];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.height-20);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    _pageControl.numberOfPages = self.items.count;
    [super layoutSubviews];
    [self layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect
{
    //移动到第2个cell
    [_bannerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YPCollectionViewCell class]) forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    if (row == 0) {
        id item  = [_items objectAtIndex:(_items.count-1)];
        _block(cell, item);
    } else if (row == _items.count+1) {
        id item  = [_items objectAtIndex:0];
        _block(cell, item);
    } else {
        id item  = [_items objectAtIndex:(row-1)];
        _block(cell, item);
    }
    return cell;
}

#pragma mark - UICollectionDelelgate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //
    YPCollectionViewCell *cell = (YPCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_selectedCellBlock) {
        _selectedCellBlock(cell, indexPath);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bannerHeight == 0) {
        self.bannerHeight = kBannerHeight;
    }
    CGSize itemSize = CGSizeMake(SCREEN_W, self.bannerHeight);
    return itemSize;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //暂停定时器
    [self stopTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGPoint offset = _scrollView.contentOffset;
    CGFloat offSetX = offset.x;
    float page = ABS(offSetX/_scrollView.width);
    if (_currentIndex > page) {
        page = ceil(page);
    } else {
        page = floorf(page);
    }
    if (_currentIndex != page) {
        _currentIndex = page;
        dispatch_async(dispatch_get_main_queue(), ^{
            _pageControl.currentPage = page-1;
        });
    }
    
    //无限循环....
    float targetX = _scrollView.contentOffset.x;
    NSInteger numCount = self.items.count;
    float ITEM_WIDTH = _scrollView.frame.size.width;
    if (numCount >= 2) {
        if (targetX < ITEM_WIDTH/2) {
            [_scrollView setContentOffset:CGPointMake(targetX+ITEM_WIDTH *numCount, 0)];
        } else if (targetX >ITEM_WIDTH/2+ITEM_WIDTH *numCount) {
            [_scrollView setContentOffset:CGPointMake(targetX-ITEM_WIDTH *numCount, 0)];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //重新启动
    [self startTimer];
}

#pragma mark - private method
- (void)startTimer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_roundRobinTimeDelay target:self selector:@selector(roundRobinBanner:) userInfo:nil repeats:YES];
    }
}

// 轮循banner
- (void)roundRobinBanner:(NSTimer *)timer
{
    //轮循
    NSInteger num = [_bannerCollectionView numberOfItemsInSection:0];
    NSInteger nextItem = (_currentIndex + 1) % num;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:nextItem inSection:0];
    [_bannerCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)stopTimer
{
    if (_timer) {
        //如果定时器在运行
        if ([self.timer isValid]) {
            //停止定时器
            [self.timer invalidate];
            //这行代码很关键
            _timer = nil;
        }
    }
}

// 刷新数据显示
- (void)reloadData
{
    [self.bannerCollectionView reloadData];
}


#pragma mark - Getter/Setter
- (void)setItems:(NSArray *)items
{
    _items = items;
    _pageControl.numberOfPages = items.count;
    //少于等于一个banner时，collectionView不能滑动，并且不启动轮循timer
    if (_items.count <= 1) {
        _bannerCollectionView.scrollEnabled = NO;
        _bannerCollectionView.userInteractionEnabled = YES;
        _pageControl.hidden = YES;
    } else {
        _bannerCollectionView.userInteractionEnabled = YES;
        [self startTimer];
        _pageControl.hidden = NO;
    }
}

- (UICollectionView *)bannerCollectionView
{
    if (nil == _bannerCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.itemSize = CGSizeMake(SCREEN_W, self.bannerHeight);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _bannerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                   collectionViewLayout:flowLayout];
        _bannerCollectionView.dataSource = self;
        _bannerCollectionView.delegate = self;
        
        [_bannerCollectionView registerClass:[YPCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([YPCollectionViewCell class])];
        _bannerCollectionView.pagingEnabled = YES;
        _bannerCollectionView.showsHorizontalScrollIndicator = NO;
        _bannerCollectionView.backgroundColor = [UIColor whiteColor];
        _roundRobinTimeDelay = 4.0f;
        _bannerCollectionView.userInteractionEnabled = NO;
    }
    return _bannerCollectionView;
}

- (UIPageControl *)pageControl
{
    if (nil == _pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = APP_DOMINANT_COLOR;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

@end

//------------------------ YPCollectionViewCell ---------------------------------//

@implementation YPBannerCollectionViewCell

// 重写父类方法只显示图片
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.imageView.clipsToBounds = YES;
    }
    return self;
}

// 设置显示的轮播图
//- (void)setModel:(BannerModel *)model {
//    [super setModel:(BaseModel *)model];

//    NSURL *url = [NSURL URLWithString:model.icon];
//    __weak YPBannerCollectionViewCell *ws = self;
//    [self.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placehoder_noborder_300"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        ws.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    }];
//}

- (void)layoutSubviews
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [super layoutSubviews];
    [self layoutIfNeeded];
}

@end
