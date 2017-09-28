//
//  AccountConfig.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#ifndef AccountConfig_h
#define AccountConfig_h

//0:正式环境 1:测试
#define IS_TEST_MODE 0
//个推推送(云信IM同步配置) 0：正式证书推送 1:测试推送证书
#define GT_TEST_MODE 0
#define IS_ENABLE_PASS  1 //过审核判断开关是否有效

// 网易云信AppId
#define NIMAPPID        IS_TEST_MODE ? @"33f1c9a817f0ebb355ecd63c3492af63" : @"b4573db8f3d8a5a49768d4791048f01f"
// 网易云信推送证书
#define NIMCERNAME       @"VideoTimeAPS"
#define NIMCERDEVNAME    @"VideoTimeAPSDev"

// 诸葛io
#define ZHUGEIO_APPKEY   @"b5f39b40897c446795a3271f5e0eb541"
// 友盟appkey
#define UMENG_APPKEY     @"59474ed565b6d6538a000950"

/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
#define WX_APP_ID        @"wx5a23cda4c23cda55"
// AppSecret
#define WX_OPEN_KEY      @"b06d35ff2d6ba19e25786a43924eb2c5"

#define BUGLY_APP_ID     @"i1400030310"
#define WB_APP_ID @""

#define GtAppId     GT_TEST_MODE ? @"qjFCXQAjsF8Cebe76Cusj3"  : @"NZHDaWEBxd5XAmyPqoPzT8"
#define GtAppKey    GT_TEST_MODE ? @"gFRn7zVAby5HpJCGjva2K1" : @"vqhVAU8Bek9sRq8bEPsLq9"
#define GtAppSecret GT_TEST_MODE ? @"64oFjOrkb47ZkT8lUWF3M9" : @"fNR37vjoV46lWRuKqarCL8"

#define APPSTORE_APPID  @"1234505238"

#define IS_APP_BETA 0

#define WEBVIEW_VERSION IS_APP_BETA ? @"-beta" : @""// online key

#define kTestChatAttachment   1

static NSString *GaodeMapKey = @"fce5b7dcc29baf7126766923f9636cfb";

// 已经不使用QQ分享
//#define QQKey @"afadfasf"
// 不再使用腾讯云通讯，跳出这个巨坑
//#define TIMSDKAPPID         1400030310
//#define TIMAccountType      @"12664"



#endif /* AccountConfig_h */
