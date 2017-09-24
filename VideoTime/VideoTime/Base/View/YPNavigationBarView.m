//
//  YPNavigationBarView.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPNavigationBarView.h"

#define APP_DOMINANT_COLOR      HEXCOLOR(0x00e2d6) ///< 青色主色调
@interface YPNavigationBarView()<NSCopying>

@property (nonatomic, strong) UIView *statusBarView;        ///< 状态栏View
@property (nonatomic, strong) UIView *bottomLineView;       ///< 底部线条
@property (nonatomic, strong) UILabel *statusMessageLabel;  ///< 状态栏消息Label

@end

@implementation YPNavigationBarView

- (id)copyWithZone:(NSZone *)zone
{
    YPNavigationBarView *navBar = [[YPNavigationBarView allocWithZone:zone] init];
    return navBar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame style:YPNavigationBarStyleMainColor];
}

- (instancetype)initWithFrame:(CGRect)frame style:(YPNavigationBarStyle)style
{
    // 如果高度小于状态栏高度，那么初始化为默认高度
    if (frame.size.height <= 20) {
        frame = CGRectMake(frame.origin.x, frame.origin.y,
                           SCREEN_W, kNAVIGATION_BAR_HEIGHT);
    }
    _barHeight = frame.size.height;
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        [self setupLayouts];
        self.style = style;
    }
    return self;
}

#pragma mark - 创建子view

- (void)setupSubviews
{
    [self addSubview:self.statusBarView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.bottomLineView];
}

- (void)setupLayouts
{
    [_statusBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(@(kSTATUS_BAR_HEIGHT));
        make.width.equalTo(@(self.frame.size.width));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statusBarView.mas_bottom);
        make.centerX.equalTo(self);
        make.width.equalTo(@(SCREEN_W-80));
        make.height.equalTo(@(_barHeight-kSTATUS_BAR_HEIGHT));
    }];
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@5);
        make.centerY.equalTo(_titleLabel);
        make.width.height.equalTo(@44);
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@(-10));
        make.centerY.equalTo(_titleLabel);
        make.width.height.equalTo(@44);
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

#pragma mark - SetStyle
- (void)setStyle:(YPNavigationBarStyle)style
{
    _style = style;
    if (YPNavigationBarStyleMainColor == style) {
        //do nothing,Becase The view init MainColor
        //设置状态栏风格为白色文字
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _statusBarView.backgroundColor = APP_DOMINANT_COLOR;
        _bottomLineView.backgroundColor = APP_DOMINANT_COLOR;
        self.backgroundColor = APP_DOMINANT_COLOR;
        _titleLabel.textColor = [UIColor whiteColor];
        
        [self  setLeftButtonBgImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [self  setLeftButtonBgImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
        [self setBottomLineHidden:YES];
    } else {
        //white style
        self.backgroundColor = [UIColor whiteColor];
        _statusBarView.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = HEXCOLOR(0x898989);
        _bottomLineView.backgroundColor = HEXCOLOR(0xEAEAEA);
        
        [self  setLeftButtonBgImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [self  setLeftButtonBgImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
        //设置状态栏风格为黑色文字
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [self setBottomLineHidden:NO];
    }
}

#pragma mark - public method

// 设置标题
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

// 设置右侧按钮图片
- (void)setLeftButtonBgImage:(UIImage *)bgImage forState:(UIControlState)state
{
    [_leftButton setImage:bgImage forState:state];
}

// 设置左侧按钮图片
- (void)setRightButtonBgImage:(UIImage *)bgImage forState:(UIControlState)state
{
    [_rightButton setImage:bgImage forState:state];
}

// 设置底部线条颜色
- (void)setBottomLineColor:(UIColor *)color
{
    _bottomLineView.backgroundColor = color;
}

// 设置底部线条隐藏
- (void)setBottomLineHidden:(BOOL)hidden
{
    _bottomLineView.hidden = hidden;
}

//隐藏右侧按钮
- (void)setRightButtonHidden:(BOOL)hidden
{
    if (hidden) {
        _leftButton.hidden = hidden;
        _rightButton = nil;
    } else {
        [self addSubview:self.rightButton];
        _rightButton.hidden = hidden;
    }
}

//隐藏左侧按钮
- (void)setLeftButtonHidden:(BOOL)hidden
{
    if (hidden) {
        _leftButton.hidden = hidden;
        _leftButton = nil;
    } else {
        [self addSubview:self.leftButton];
        _leftButton.hidden = hidden;
    }
}

//状态栏消息
//显示消息
- (void)showStatusMessage:(NSString *)message
{
    if (nil == _statusMessageLabel) {
        _statusMessageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusMessageLabel.font = [UIFont systemFontOfSize:11.0f];
        //根据状态栏颜色设置文本颜色
        UIColor *textColor = _style == YPNavigationBarStyleMainColor ? [UIColor whiteColor] : APP_DOMINANT_COLOR;
        _statusMessageLabel.textColor = textColor;
        [_statusBarView addSubview:_statusMessageLabel];
    }
    _statusMessageLabel.text = message;
    //自动布局
    [_statusMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_statusBarView);
    }];
    //显示状态栏
    [self hideStatusMessage:NO];
}

- (void)hideStatusMessage:(BOOL)hidden
{
    if (hidden) {
        //无状态栏消息就显示状态栏
        [[UIApplication sharedApplication] setStatusBarHidden:!hidden withAnimation:YES];
    } else {
        //显示状态栏消息即隐藏状态栏
        [[UIApplication sharedApplication] setStatusBarHidden:!hidden withAnimation:YES];
    }
    _statusMessageLabel.hidden = hidden;
}


#pragma mark - Getter/Setter
- (UIView *)statusBarView
{
    if (nil == _statusBarView) {
        //状态栏
        _statusBarView = [[UIView alloc] initWithFrame:CGRectZero];
        _statusBarView.backgroundColor = APP_DOMINANT_COLOR;
    }
    return _statusBarView;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        //标题
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

- (UIButton *)leftButton
{
    if (nil == _leftButton) {
        //左侧按钮
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectZero;
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (nil == _rightButton) {
        //右侧按钮
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectZero;
        [_rightButton setTitleColor:[UIColor whiteColor]
                           forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightButton;
}

- (UIView *)bottomLineView
{
    if (nil == _bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLineView.backgroundColor = HEXCOLOR(0xEAEAEA);
    }
    return _bottomLineView;
}


@end
