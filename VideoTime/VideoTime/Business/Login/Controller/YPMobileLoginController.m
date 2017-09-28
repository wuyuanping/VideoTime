//
//  YPMobileLoginController.m
//  VideoTime
//
//  Created by 吴园平 on 28/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPMobileLoginController.h"
#import "YPUserDefaultHelper.h"
#import "YPUserModel.h"

@interface YPMobileLoginController ()

@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIView *mobileBG;
@property (weak, nonatomic) IBOutlet UIView *passwordBG;

@end

@implementation YPMobileLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    [self.view addGestureRecognizer:tap];
    
    self.mobileBG.layer.masksToBounds = YES;
    self.mobileBG.layer.cornerRadius = 8.0f;
    self.passwordBG.layer.masksToBounds = YES;
    self.passwordBG.layer.cornerRadius = 8.0f;
    self.navBar.hidden = YES; // 隐藏继承的自定义属性
}

- (void)keyboardHide
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


#pragma mark - Event Response
// 确定登录
- (IBAction)mobileLogin:(id)sender
{
    NSMutableDictionary *loginDic = [NSMutableDictionary dictionary];
    if (self.mobile.text.length == 11) {
        [loginDic setObject:self.mobile.text forKey:@"mobile"];
    }else{
        [YPHUDHelper showFailedWithStatus:@"请输入11位手机号码"];
        return;
    }
    if (self.password.text.length >= 6) {
        [loginDic setObject:self.password.text forKey:@"password"];
    }else{
        [YPHUDHelper showFailedWithStatus:@"请输入6位密码"];
        return;
    }
    
    BOOL isForcedLogin = [[YPUserDefaultHelper objectForDestKey:UD_IM_FORCED_lOGINED_KEY] boolValue];
    if (isForcedLogin) {
        [loginDic setObject:@"1" forKey:@"refresh_token"];
    }
    // 登录
    [self requestMobileLoginWithLoginData:loginDic];
}

// 取消
- (IBAction)cancelBtnClicked:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Request
- (void)requestMobileLoginWithLoginData:(NSDictionary *)loginDic
{
    [YPHUDHelper showLoaddingWithMessage:@"登录中..."];
    [YPAPI postWithPath:kUserLoginWithPhone params:loginDic success:^(BaseResponseResult *result) {
        [YPHUDHelper dismiss];
        YPUserDetailModel *userDetailModel = [YPUserDetailModel yy_modelWithDictionary:result.data];
        NSString *theToken = userDetailModel.token;
        NSMutableDictionary *userInfoDict = [NSMutableDictionary dictionaryWithDictionary:result.data];
        // 防止phone字段为空，导致蹦
        if ([[userInfoDict objectForKey:@"phone"] isEqual:[NSNull null]]) {
            [userInfoDict setValue:@"" forKey:@"phone"];
        }
        // 设置不需再次强制登录
        [YPUserDefaultHelper setObject:@(NO) forDestKey:UD_IM_FORCED_lOGINED_KEY];
        // 记录登录状态, 并保存cookie
        [YPUserManager userLoggedInWithToken:theToken infoDict:userInfoDict];
        // 通知登录成功
        [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOGINED_NOTIFICATION object:nil];
    } failure:^(NSError *error) {
        [YPHUDHelper dismiss];
        [YPHUDHelper showFailedWithStatus:@"登录失败，请稍后重试"];
    }];
}

@end
