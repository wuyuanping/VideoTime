//
//  YPCustomAlertView.h
//  VideoTime
//
//  Created by 吴园平 on 24/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseView.h"

typedef void(^ButtonClickBlock)(NSInteger buttonIndex);

@interface YPCustomAlertView : BaseView

@property (nonatomic, assign) NSInteger cancelButtonIndex;
@property (nonatomic, assign) NSInteger confirmButtonIndex;

/**
 * 初始化alertView
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)msgString cacelButtonTitle:(NSString *)cancelTitle confirmButtonTitle:(NSString *)confirmTitle;

/**
 * 显示alertView
 */
- (void)showAlertViewWithBlock:(void (^)(NSInteger buttonIndex))block;

@end
