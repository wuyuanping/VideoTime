//
//  YPCollectionViewCell.h
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface YPCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) BaseModel *model;

@end
