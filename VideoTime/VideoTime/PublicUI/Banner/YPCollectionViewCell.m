//
//  YPCollectionViewCell.m
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPCollectionViewCell.h"

@implementation YPCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//- (void)layoutSubviews {
//    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.contentView);
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
//
//    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.contentView);
//    }];
//
//    [super layoutSubviews];
//    [self layoutIfNeeded];
//}

#pragma mark - Getter/Setter

- (void)setModel:(BaseModel *)model
{
    _model = model;
}

- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

@end
