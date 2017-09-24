//
//  ViewController.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "ViewController.h"
#import "YPCustomAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [UIView showTheApplauseInView:self.view image:IMAGE_NAMED(@"hahaha")];
    YPCustomAlertView *alert = [[YPCustomAlertView alloc] initWithTitle:@"offer" message:@"good job!" cacelButtonTitle:@"取消" confirmButtonTitle:@"确定"];
    [alert showAlertViewWithBlock:^(NSInteger buttonIndex) {
        NSLog(@"点击了%ld",(long)buttonIndex);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
