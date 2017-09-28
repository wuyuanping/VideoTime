//
//  YPLoginViewController.m
//  VideoTime
//
//  Created by 吴园平 on 27/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPLoginViewController.h"
#import "UserProtocolViewController.h"
#import "YPMobileRegistController.h"
#import "YPMobileLoginController.h"

#import "YPUserDefaultHelper.h"
#import "YPUserModel.h"

#define WX_ACCESS_TOKEN      @"access_token"
#define WX_OPEN_ID           @"openid"
#define WX_REFRESH_TOKEN     @"refresh_token"
#define WX_UNION_ID          @"unionid"
#define WX_BASE_URL          @"https://api.weixin.qq.com/sns"

@interface YPLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIButton *mobileBtn;
@property (nonatomic, strong) UIButton *eulaButton; //协议按钮

@end

@implementation YPLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [YPSystemConfigHelper requestIsApprovedWithCompletion:^(BOOL isApproved) {
        
    }];
    // 检测是否安装了微信
    if (![WXApi isWXAppInstalled]) {
        _wxBtn.hidden = YES;
    }
    [self.view addSubview:self.eulaButton];
    
    NSString *eulaString = @"登录即代表你同意聊天时间用户协议";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:eulaString];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(eulaString.length-8, 8)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, eulaString.length)];
    [self.eulaButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    [self.eulaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-15);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(SCREEN_W));
    }];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO]; // 隐藏导航栏
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - Event Response
//微信登录点击事件
- (IBAction)weiXinLoginTap:(id)sender
{
    // 获取微信授权
    [self wechatLogin];
}

#pragma mark - 获取微信授权
- (void)wechatLogin
{
    if ([WXApi isWXAppInstalled]) {
        //构造SendAuthReq结构体
        SendAuthReq* req =[[SendAuthReq alloc ] init];
        req.scope = @"snsapi_userinfo" ;
        req.state = @"聊天时间" ;
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
    }
}

//手机登录点击事件
- (IBAction)mobileLoginTap:(id)sender
{
        
    if ([YPSystemConfigHelper isApproved]) {
        //手机号先注册
        YPMobileRegistController *mobileVC = [[YPMobileRegistController alloc] init];
        mobileVC.isLogin = YES;
        //设置模式展示风格
        [mobileVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        //必要配置
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        [self presentViewController:mobileVC animated:YES completion:nil];
    } else {
        //手机直接登录
        YPMobileLoginController *mobileVC = [[YPMobileLoginController alloc] init];
        //设置模式展示风格
        [mobileVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        //必要配置
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        [self presentViewController:mobileVC animated:YES completion:nil];
    }
}

// 点击阅读服务条款
- (IBAction)serviceTap:(id)sender
{
    UserProtocolViewController *vc = [[UserProtocolViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

#pragma mark - Getter/Setter
- (UIButton *)eulaButton
{
    if (nil == _eulaButton) {
        _eulaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _eulaButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_eulaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_eulaButton addTarget:self action:@selector(serviceTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eulaButton;
}


#pragma mark - WXApiManagerDelegate
//微信登录回调
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response
{
    if (response.errCode == -2) {
        //用户取消微信登录
        //DebugLog(@"用户取消登录");
    } else if (response.errCode == -4){
        //用户拒绝微信登录
        //DebugLog(@"用户拒绝登录");
    } else if (response.errCode == 0){
        //登录获取信息
        //[[HUDHelper sharedInstance] syncLoading:@"正在登录"];
        SendAuthResp *authReq;
        if ([response isKindOfClass:[SendAuthResp class]]) {
            authReq = (SendAuthResp *)response;
            //根据返回的code，获取微信token和openid
            [self requestWXTokenAndOpenIdWithCode:authReq.code];
        }
    }
}

- (void)requestWXTokenAndOpenIdWithCode:(NSString *)code
{
    __weak typeof(self) ws = self;
    [YPHUDHelper showLoadding];
    [[NetworkHelper sharedInstance] getWeChatTokenAndOpenIdWithCode:code succ:^(NSInteger code,NSString *msg, id data) {
        NSData *responseData = data;
        NSDictionary *accessDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSString *accessToken = [accessDict objectForKey:WX_ACCESS_TOKEN];
        NSString *openID = [accessDict objectForKey:WX_OPEN_ID];
        
        //[ws getUserSigWithToken:accessToken withOpenID:openID mobile:nil code:nil];
        // TODO: ADD REGISTER FILET
        [YPHUDHelper dismiss];
        // 判断该微信用户是否注册，执行相应操作
        [ws getWeChatIsRegisterWithAccessToken:accessToken openId:openID];
    } fail:^(NSString *error) {
        [YPHUDHelper dismiss];
        [YPHUDHelper showFailedWithStatus:@"授权失败，请稍后重试"];
    }];
}

// 判断该微信用户是否注册，执行相应操作
- (void)getWeChatIsRegisterWithAccessToken:(NSString *)accessToken openId:(NSString *)openId
{
    NSDictionary *params = @{@"openid" : openId};
    __weak typeof(self) ws = self;
    [YPHUDHelper showLoadding];
    [YPAPI getWithPath:kWXIsRegister params:params success:^(BaseResponseResult *result) {
        [YPHUDHelper dismiss];
        NSDictionary *dataDict = result.data;
        BOOL isRegisted = [[dataDict objectForKey:@"is_bind_phone"] boolValue];
        if (isRegisted) {
            // 已注册(直接用户登录，并且获取本平台的token和用户信息)
            [self getUserSigWithToken:accessToken withOpenID:openId mobile:nil code:nil];
        } else {
            // 未注册 (未绑定手机，则跳转到绑定手机页面)
            YPMobileRegistController *mobileVC = [[YPMobileRegistController alloc] init];
            mobileVC.isLogin = NO;
            //设置模式展示风格
            [mobileVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
            //必要配置
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            self.providesPresentationContextTransitionStyle = YES;
            self.definesPresentationContext = YES;
            
            [self presentViewController:mobileVC animated:YES completion:nil];
            // 调用block属性的setter，即设置属性，当参数有值传进来就执行block内部 ！！！
            [mobileVC setConfrimClickedBlock:^(NSString *mobile, NSString* code) {
                // 用户登录
                [ws getUserSigWithToken:accessToken withOpenID:openId mobile:mobile code:code];
            }];
        }
    } failure:^(NSError *error) {
        [YPHUDHelper dismiss];
        [YPHUDHelper showError:error];
    }];
}

// 用户登录，并且获取本平台的token和用户信息
- (void)getUserSigWithToken:(NSString *)accessToken
                 withOpenID:(NSString *)openID
                     mobile:(NSString *)mobile
                       code:(NSString *)code
{
    NSMutableDictionary *loginDic = [NSMutableDictionary dictionary];
    if (accessToken) {
        [loginDic setObject:accessToken forKey:@"access_token"];
    }
    if (openID) {
        [loginDic setObject:openID forKey:@"openid"];
    }
    if (mobile) {
        [loginDic setObject:mobile forKey:@"phone"];
    }
    if (code) {
        [loginDic setObject:code forKey:@"code"];
    }
    
    BOOL isForcedLogin = [[YPUserDefaultHelper objectForDestKey:UD_IM_FORCED_lOGINED_KEY] boolValue];
    if (isForcedLogin) {
        [loginDic setObject:@"1" forKey:@"refresh_token"];
    }
    
    [YPHUDHelper showLoaddingWithMessage:@"登录中..."];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[YPSystemConfigHelper hostName], kUserLogin];
    [YPAPI getWithPath:urlString params:loginDic success:^(BaseResponseResult *response) {
        [YPHUDHelper dismiss];
        
        YPUserDataModel *userDetailModel = [YPUserDataModel yy_modelWithDictionary:response.data];
        NSString *theToken = userDetailModel.token;
        
        NSMutableDictionary *userInfoDict = [NSMutableDictionary dictionaryWithDictionary:response.data];
        // 防止phone字段为空，导致蹦
        if ([[userInfoDict objectForKey:@"phone"] isEqual:[NSNull null]]) {
            [userInfoDict setValue:@"" forKey:@"phone"];
        }
        [userInfoDict setValue:accessToken forKey:@"WXAccessToken"];
        // 记录登录状态, 并保存cookie
        [YPUserManager userLoggedInWithToken:theToken infoDict:userInfoDict];
        // 设置不需再次强制登录
        [YPUserDefaultHelper setObject:@(NO) forDestKey:UD_IM_FORCED_lOGINED_KEY];
        
        // 判断是否有绑定手机
        if (userDetailModel.phone && (userDetailModel.phone.length > 0)) {
            // 有绑定手机，通知登录成功
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOGINED_NOTIFICATION object:nil];
        } else {
            // 未绑定手机，跳转到绑定手机页面
            [self showBindPhoneViewController];
        }
    } failure:^(NSError *error) {
        [YPHUDHelper dismiss];
        [YPHUDHelper showError:error];
    //[YPHUDHelper showFailedWithStatus:@"登录失败，请稍后重试"];
    }];
}

#pragma mark - private
- (void)showBindPhoneViewController
{
    // 显示绑定手机页面
    YPMobileRegistController *mobileVC = [[YPMobileRegistController alloc] init];
    mobileVC.isLogin = NO;
    //设置模式展示风格
    [mobileVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    //必要配置
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [self presentViewController:mobileVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
