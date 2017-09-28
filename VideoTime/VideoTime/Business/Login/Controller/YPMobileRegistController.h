//
//  YPMobileRegistController.h
//  VideoTime
//
//  Created by 吴园平 on 27/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseViewController.h"

@protocol YPPhoneRegistDelegate <NSObject>

- (void)registSuccessWithUserData:(NSDictionary *)userData;

@end

@interface YPMobileRegistController : BaseViewController

@property (nonatomic, weak) id<YPPhoneRegistDelegate> delegate;
@property (nonatomic, copy) void (^confrimClickedBlock)(NSString *mobile, NSString *code);
@property (nonatomic, assign) BOOL isLogin;

@end
