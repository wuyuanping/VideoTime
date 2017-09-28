//
//  UserProtocolViewController.m
//  VideoTime
//
//  Created by 吴园平 on 28/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "UserProtocolViewController.h"

@interface UserProtocolViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation UserProtocolViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"聊天时间用户协议";
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"已阅读" style:UIBarButtonItemStylePlain target:self action:@selector(onClickDone)];
    
    // 加载协议内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UserProtocol" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url] ;
    [_webView loadRequest:request];
}

- (void)onClickDone
{
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"HasReadUserProtocol"];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
