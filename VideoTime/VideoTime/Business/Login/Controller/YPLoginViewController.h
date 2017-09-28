//
//  YPLoginViewController.h
//  VideoTime
//
//  Created by 吴园平 on 27/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPLoginViewControllerDelegate <NSObject>

- (void)loginViewCtrl:(UIViewController *)viewCtrl loginedWithDataDict:(NSDictionary *)dataDict;

@end

@interface YPLoginViewController : UIViewController

@property (nonatomic, weak) id<YPLoginViewControllerDelegate> delegate;

@end
