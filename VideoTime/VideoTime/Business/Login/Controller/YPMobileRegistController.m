//
//  YPMobileRegistController.m
//  VideoTime
//
//  Created by 吴园平 on 27/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPMobileRegistController.h"
#import "YPUserDefaultHelper.h"
#import "YPUserModel.h"

#define APP_DOMINANT_COLOR      HEXCOLOR(0x00e2d6) ///< 青色主色调

@interface YPMobileRegistController ()

@property (weak, nonatomic) IBOutlet UIView *phoneBG;
@property (weak, nonatomic) IBOutlet UIView *checkBG;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *checkNum;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn; // 获取验证码按钮

@property (nonatomic, strong) NSTimer *codeTimer;
@property (nonatomic, assign) NSInteger codeStand; // 设置倒计时间

@end

@implementation YPMobileRegistController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    [self.view addGestureRecognizer:tap];
    
    _phoneBG.layer.masksToBounds = YES;
    _phoneBG.layer.cornerRadius = 8.0f;
    
    _checkBG.layer.masksToBounds = YES;
    _checkBG.layer.cornerRadius = 8.0f;
    
    _checkBtn.layer.masksToBounds = YES;
    _checkBtn.layer.cornerRadius = 8.0f;
    self.navBar.hidden = YES; // 隐藏继承的属性
}

- (void)keyboardHide
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

// 获取验证码
- (IBAction)getCheckNumber:(id)sender
{
    NSMutableDictionary *loginDic = [NSMutableDictionary dictionary];
    if (self.phoneNumber.text.length == 11) {
        [loginDic setObject:self.phoneNumber.text forKey:@"phone"];
    }else{
        [YPHUDHelper showFailedWithStatus:@"请输入11位手机号码"];
        return;
    }
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[YPSystemConfigHelper hostName],kUserLoginSendCode];
    
    __weak typeof(self) ws = self;
    [YPAPI getWithPath:urlString params:loginDic success:^(BaseResponseResult *result) {
        [YPHUDHelper showSuccessWithStatus:@"已发送验证码，请查收短信"];
        ws.codeStand = 60;
        ws.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        ws.checkBtn.enabled = NO;
        [ws.checkBtn setBackgroundColor:[UIColor lightGrayColor]];
    } failure:^(NSError *error) {
         [YPHUDHelper showFailedWithStatus:@"验证码获取失败，请稍后重试"];
    }];
}

- (void)timerRun
{
    self.codeStand --;
    if (self.codeStand == 0) {
        self.checkBtn.enabled = YES;
        [_checkBtn setBackgroundColor:APP_DOMINANT_COLOR];
        [self.checkBtn setTitle:@"验证码" forState:UIControlStateNormal];
        [self.codeTimer invalidate];
        self.codeTimer = nil;
    }else{
        NSString *buttonStr = [NSString stringWithFormat:@"%ld S",self.codeStand];
        [self.checkBtn setTitle:buttonStr forState:UIControlStateNormal];
    }
}

// 取消注册
- (IBAction)cancelTap:(id)sender
{
    [self.codeTimer invalidate];
    self.codeTimer = nil;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 确定 按钮
- (IBAction)mobileLogin:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *phone = self.phoneNumber.text;
    NSString *code = self.checkNum.text;
    // 验证手机号码是否有效
    if ((phone.length < 11) || (phone.length > 11)) {
        [YPHUDHelper showFailedWithStatus:@"请输入11位手机号码"];
        return;
    }
    // 验证6位验证码是否有效
    if (code.length < 6) {
        [YPHUDHelper showFailedWithStatus:@"请输入6位验证码"];
        return;
    }
    
    // 判断是否有设置block,如果有直接返回
    if (_confrimClickedBlock) {
        _confrimClickedBlock(phone, code);  // 专门为微信绑定了手机 直接微信通过绑定手机登录
        return;
    }
    
    // 手机号登录过则为该手机号和验证码登录，否则为绑定手机
    if (_isLogin) {
        [self requestPhoneLogin:phone code:code];
    } else {
        [self requestBindPhone:phone code:code];
    }
}

#pragma mark - Request
- (void)requestPhoneLogin:(NSString *)phoneNumber code:(NSString *)code
{
    BOOL isForcedLogin = [[YPUserDefaultHelper objectForDestKey:UD_IM_FORCED_lOGINED_KEY] boolValue];
    // 手机验证码登录（验证码当动态临时密码）
    NSDictionary *params = @{@"phone" : phoneNumber,
                             @"code" : code,
                             @"refresh_token" : @(isForcedLogin)};
    __typeof(self) weakSelf = self;
    [YPHUDHelper showLoaddingWithMessage:@"登录中..."];
    [YPAPI postWithPath:kUserLoginWithPhone params:params success:^(BaseResponseResult *result) {
        [YPHUDHelper dismiss];
        // 暂停倒计时
        [weakSelf.codeTimer invalidate];
        weakSelf.codeTimer = nil;
        
        YPUserDetailModel *userDetailModel = [YPUserDetailModel yy_modelWithDictionary:result.data];
        NSString *theToken = userDetailModel.token;
        NSMutableDictionary *userInfoDict = [NSMutableDictionary dictionaryWithDictionary:result.data];
        
        [userInfoDict setValue:phoneNumber forKey:@"phone"];
        // 记录登录状态, 并保存cookie
        [YPUserManager userLoggedInWithToken:theToken infoDict:userInfoDict];
        // 设置不需再次强制登录IM
        [YPUserDefaultHelper setObject:@(NO) forDestKey:UD_IM_FORCED_lOGINED_KEY];
        // 通知登录成功
        [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOGINED_NOTIFICATION object:nil];
    } failure:^(NSError *error) {
        [YPHUDHelper dismiss];
        [YPHUDHelper showError:error];
    }];
    
}

- (void)requestBindPhone:(NSString *)phone code:(NSString *)code
{
    // 绑定手机
    NSDictionary *params = @{@"phone" : phone,
                             @"code" : code};
    __typeof(self) weakSelf = self;
    [YPHUDHelper showLoaddingWithMessage:@"登录中..."];
    [YPAPI postWithPath:kUserMobileUpdate params:params success:^(BaseResponseResult *result) {
        [YPHUDHelper dismiss];
        // 暂停倒计时
        [weakSelf.codeTimer invalidate];
        weakSelf.codeTimer = nil;
        // 修改保存的用户手机号码
        NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] initWithDictionary:[YPUserManager userInfoDict]];
        [userInfoDict setObject:phone forKey:@"phone"];
        [YPUserManager setUserInfo:userInfoDict];
    } failure:^(NSError *error) {
        [YPHUDHelper dismiss];
        [YPHUDHelper showError:error];
    }];
}

- (void)dealloc
{
    if (self.codeTimer) {
        [self.codeTimer invalidate];
        self.codeTimer = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
