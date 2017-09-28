//
//  YPMobileLoginController.h
//  VideoTime
//
//  Created by 吴园平 on 28/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseViewController.h"

@protocol YPPhoneLoginDelegate <NSObject>

- (void)registSuccessWithUserData:(NSDictionary*)userData;

@end

@interface YPMobileLoginController : BaseViewController

@property (nonatomic, weak) id<YPPhoneLoginDelegate> delegate;

@end
