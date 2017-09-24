//
//  YPCustomAlertView.m
//  VideoTime
//
//  Created by 吴园平 on 24/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPCustomAlertView.h"

#define APP_DOMINANT_COLOR      HEXCOLOR(0x00e2d6) ///< 青色主色调

@interface YPCustomAlertView ()
{
    ButtonClickBlock _block;
    CGFloat textHeight;
}

@property (nonatomic, strong) UIView *bgView;               /**< 背景 */
@property (nonatomic, strong) UIView *containerView;        /**< 容器 */
@property (nonatomic, strong) UIImageView *iconImageView;   /**< 图标 */
@property (nonatomic, strong) UILabel *titleLabel;          /**< 标题 */
@property (nonatomic, strong) UITextView *contentTextView;  /**< 内容 */
@property (nonatomic, strong) UIView *lineView1;            /**< line */
@property (nonatomic, strong) UIButton *cancelButton;       /**< 取消按钮 */
@property (nonatomic, strong) UIButton *confirmButton;      /**< 确认按钮 */
@property (nonatomic, strong) UIView *lineView2;             /**< line */

@end

@implementation YPCustomAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)msgString
             cacelButtonTitle:(NSString *)cancelTitle
           confirmButtonTitle:(NSString *)confirmTitle
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    if (self) {
        //init subviews
        [self addSubview:self.bgView];
        [self addSubview:self.containerView];
        [self addSubview:self.iconImageView];
        [self.containerView addSubview:self.titleLabel];
        [self.containerView addSubview:self.contentTextView];
        [self.containerView addSubview:self.lineView1];
        [self.containerView addSubview:self.cancelButton];
        [self.containerView addSubview:self.confirmButton];
        [self.containerView addSubview:self.lineView2];
        
        //set data
        self.titleLabel.text = title;
        [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        [self.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
        
        self.cancelButtonIndex = 0;
        self.confirmButtonIndex = 1;
        
        //textview 改变字体的行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;// 字体的行间距
        NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                      NSParagraphStyleAttributeName : paragraphStyle,
                                      NSForegroundColorAttributeName : [UIColor darkTextColor]};
        
        self.contentTextView.attributedText = [[NSAttributedString alloc] initWithString:msgString attributes:attributes];
        
        //add tap gesture
        UITapGestureRecognizer *tapBgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
        [self.bgView addGestureRecognizer:tapBgGesture];
        
        //计算文字高度
        CGSize size = CGSizeMake(290-40, 0);
        CGSize retSize = [msgString boundingRectWithSize:size
                                                 options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                              attributes:attributes
                                                 context:nil].size;
        textHeight = retSize.height;
    }
    return self;
}

- (void)layoutSubviews
{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@290);
        //        make.height.equalTo(@240);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(10);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.containerView.mas_top).offset(15);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@28);
        make.centerX.equalTo(self.containerView.mas_centerX);
        
    }];
    
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.equalTo(@(textHeight+40));
        make.bottom.equalTo(_cancelButton.mas_top);
    }];
    
    [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_contentTextView.mas_bottom);
        make.height.equalTo(@0.5);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.leading.equalTo(@0);
        make.height.equalTo(@44);
        make.width.equalTo(@145);
    }];
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.trailing.equalTo(@0);
        make.height.equalTo(@44);
        make.width.equalTo(@145);
    }];
    
    [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cancelButton.mas_top);
        make.bottom.equalTo(@0);
        make.width.equalTo(@0.5);
        make.trailing.equalTo(_cancelButton.mas_trailing);
    }];
    
    [super layoutSubviews];
    [self layoutIfNeeded];
}

#pragma mark - method
- (void)showAlertViewWithBlock:(void (^)(NSInteger buttonIndex))block
{
    //show to top window
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *topWindow = [[windows sortedArrayUsingComparator:^NSComparisonResult(UIWindow *win1, UIWindow *win2) {
        return win1.windowLevel - win2.windowLevel;
    }] lastObject];
    UIView *topView = [[topWindow subviews] lastObject];
    [topView addSubview:self];
    if (block) {
        _block = block;
    }
}

- (void)tapBgView:(UITapGestureRecognizer *)sender
{
    [self removeFromSuperview];
}


#pragma mark - Event Response

- (void)actionButtonClickedEvent:(UIButton *)sender
{
    if (_confirmButton == sender) {
        //确定
        if (_block) {
            _block(1);
            //TODO
            
        }
    } else {
        //取消
        if (_block) {
            _block(0);
            // TODO
        }
    }
    [self removeFromSuperview];
}

#pragma mark - Getter/Setter
- (UIView *)bgView
{
    if (nil == _bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.4;
    }
    return _bgView;
}

- (UIImageView *)iconImageView
{
    if (nil == _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageView.image = [UIImage imageNamed:@"upgrade"];
    }
    return _iconImageView;
}

- (UIView *)containerView
{
    if (nil == _containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 10.0f;
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _titleLabel.textColor = APP_DOMINANT_COLOR;
    }
    return _titleLabel;
}

- (UITextView *)contentTextView
{
    if (nil == _contentTextView) {
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _contentTextView.editable = NO;
        _contentTextView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
        _contentTextView.showsVerticalScrollIndicator = NO;
    }
    return _contentTextView;
}

- (UIView *)lineView1
{
    if (nil == _lineView1) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView1.backgroundColor = HEXCOLOR(0xe2e2e2);
    }
    return _lineView1;
}

- (UIButton *)cancelButton
{
    if (nil == _cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [_cancelButton addTarget:self action:@selector(actionButtonClickedEvent:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIView *)lineView2
{
    if (nil == _lineView2) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView2.backgroundColor = HEXCOLOR(0xe2e2e2);
    }
    return _lineView2;
}

- (UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_confirmButton setTitleColor:APP_DOMINANT_COLOR forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [_confirmButton addTarget:self action:@selector(actionButtonClickedEvent:)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
