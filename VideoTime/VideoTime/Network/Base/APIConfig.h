//
//  APIConfig.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h

/************** Sign KEY *****************/
//用于生成sign验证字符串的KEY，请勿修改
#define SING_KEY    @""

/*************** SERVER HOST ***************/

//测试服务器地址
//#define SERVER_HOST_URL            @"http://192.168.3.233"
//正式服务器地址
//#define SERVER_HOST_URL            @"http://app.pba.cn"

/*************** SERVER API ***************/

//---------- Application -----------------//
static NSString *const kGiftListUrl             = @"/api/gift/list";

static NSString *const kSendGiftUrl             = @"/api/gift/send";

//在线人数
static NSString *const kOnlinecount             = @"/api/v2/home/onlinecount";
static NSString *const kHongbao                 = @"/api/v2/home/hongbao";

//经纪人
static NSString *const kBrokerUrl               = @"/api/v2/user/info";
//大、小助理
static NSString *const kAssistantUrl            = @"/api/user/fan";

//获取钻石数量 已弃用
static NSString *const kDiamondCountUrl         = @"/api/user/count";
// 获取用户信息
static NSString *const kUserInfoUrl             = @"/api/user/info";

//添加到黑名单
static NSString *const kUserAddBlackListUrl     = @"/api/blacklist/add";

//记住TA
static NSString *const kRememberTaUrl           = @"/api/fan/remember";
static NSString *const kFriendList              = @"/api/fan/query";

//苹果审核通过
static NSString *const kExaminePass             = @"/api/sys/conf"; //0通过 1未通过

// 用户登录
static NSString *const kUserLogin               = @"/api/auth/wechat";
// 微信账户是否注册
static NSString *const kWXIsRegister            = @"/api/auth/checkBindPhone";
// 手机验证码登录
static NSString *const kUserLoginWithMobile     = @"/api/auth/mobile";
// 发送验证码
static NSString *const kUserLoginSendCode       = @"/api/v2/auth/sendcode";
// 手机密码登录
static NSString *const kUserLoginWithPhone      = @"/api/auth/phone";

static NSString *const kUserWechatUpdate        = @"/api/user/bindwechat";
static NSString *const kUserMobileUpdate        = @"/api/user/bindmobile"; // 绑定新手机

//订单
static NSString *const kOrderCreate             = @"/api/order/create";
static NSString *const kProductVerify           = @"/api/third/apple/verify";
static NSString *const kOrderList               = @"/api/appointment/jobs";
// 拒接
static NSString *const kOrderReject             = @"/api/appointment/reject";
// 订单状态
static NSString *const kOrderStatus             = @"/api/appointment/status";
// 申请退款
static NSString *const kOrderRefund             = @"/api/appointment/refund";

//投诉
static NSString *const kComplain                = @"/api/complain/add";
//举报
static NSString *const kDynamicComplain         = @"/api/article/complain";
//黑名单
static NSString *const kBlackList               = @"/api/blacklist/list";
static NSString *const kBlackListAdd            = @"/api/blacklist/add";

//通讯云
static NSString *const kCloudInfo               = @"/api/user/timsig";
static NSString *const kSubmitOrder             = @"/api/appointment/create";

//等待页
static NSString *const kWaitUsers               = @"/api/online/users";

// 支付
// 支付宝预售订单
static NSString *const kAlipayPresellOrder      = @"/api/third/alipay/purchase_app";
// 微信支付预售订单
static NSString *const kWXPayPresellOrder       = @"/api/third/wechat/prepare_app";
// 钻石支付
static NSString *const kDiamondPurchaseOrder    = @"/api/appointment/purchase";
// 订单详情
static NSString *const kOrderDetail             = @"/api/appointment/detail";
// 确认订单
static NSString *const kOrderConfirm            = @"/api/appointment/comfirm";
// 完成订单
static NSString *const kOrderFinished           = @"/api/appointment/end";
// 订单评论
static NSString *const kOrderScore              = @"/api/appointment/score";
// 历史订单
static NSString *const kOrderHistoryList        = @"/api/appointment/order";

//红包
static NSString *const kGetHongBao              = @"/api/hongbao/get";
static NSString *const kHongBaoUnlock           = @"/api/hongbao/unlock";

//提现
static NSString *const kExchangeQuery           = @"/api/exchange/query";
static NSString *const kExchangeRMB             = @"/api/exchange/rmb";
static NSString *const kExchangeSend            = @"/api/exchange/send";

//VIP
static NSString *const kVipList                 = @"/api/vip/list";
// 绑定cid(推送服务)
static NSString *const kBindCid                 = @"/api/third/getui/bind";
//用户二维码
static NSString *const kUserCode                = @"/api/qrcode/create";

//标签
static NSString *const kTag                     = @"/api/online/tag";
// 搜索用户
static NSString *const kSearchUser              = @"/api/search/user";
// 评论列表
static NSString *const kCommentList             = @"/api/online/score";
static NSString *const kNewCommentList          = @"/api/user/scores";
// 用户未在会话列表
static NSString *const kNoInMessageList         = @"/api/message/customelem";
// 会员中心数据
static NSString *const kUserCenter              = @"/api/user/center";
// 关于我们列表
static NSString *const kAboutList               = @"/api/menu/usercenter";
// 帮助中心列表
static NSString *const kHelpList                = @"/app_wv/index.html#/help/1";
// 黑名单列表
static NSString *const kUserBlackList           = @"/api/blacklist/list";
// 资料设置
static NSString *const kUserUpdate              = @"/api/user/update";
// 检测是否有版本更新
static NSString *const kVersionUpgrade          = @"/api/version/check";
// 左侧菜单栏额外菜单选项
static NSString *const kLeftSiderMenu           = @"/api/menu/sidebar";

// 大神
static NSString *const kDaShen                  = @"/apply/dashen";
//关注
static NSString *const kFanRemember             = @"/api/fan/remember";
//取消关注
static NSString *const kFanCancelRemember       = @"/api/fan/unfollow";
// 我的关注
static NSString *const kFollowList              = @"/api/fan/idols";
// 我的推广人员(粉丝)
static NSString *const kFansList                = @"/api/user/fan";
// 移出黑名单
static NSString *const kRemoveForBlackList      = @"/api/blacklist/del";

// 商城
static NSString *const kShop                    = @"/api/shop";
// 经纪人web页面
static NSString *const kAssistantWebPageURL     = @"/account/assistant";

//匹配用户类型
static NSString *const kGetUserType             = @"/api/online/matchSexual";

//视频添加好友
static NSString *const kFriendAdd               = @"/api/v2/friend/add";
// 确认
static NSString *const kFriendConfirm           = @"/api/v2/friend/confirm";
// 拒绝
static NSString *const kFriendReject            = @"/api/v2/friend/reject";

//提示信息接口
static NSString *const kMatchTips               = @"/api/online/hint";

//指定匹配减钻石
static NSString *const kMatchChatType           = @"/api/v2/pay/matchchattype";

//UserDefault
static NSString *const GiftListArray            = @"GiftListArray";
static NSString *const GiftListTime             = @"GiftListTime";
static NSString *const UserLoginInfo            = @"UserLoginInfo";
static NSString *const EULA                     = @"EULA";
static NSString *const MatchTag                 = @"MatchTag";
static NSString *const MatchTagTime             = @"MatchTagTime";
static NSString *const TipsList                 = @"TipsList";
static NSString *const TipsListTime             = @"TipsListTime";
static NSString *const SelectTag                = @"selectTag";
static NSString *const UserCodeURL              = @"userCode";
static NSString *const Authorization            = @"authorization";

//--------------------- 广场 -------------------------//
// 获取首页推荐数据
static NSString *const kSquareRecommendIndex    = @"/api/v2/home/recommend";
// 获取遇见的人
static NSString *const kSquareMeetedUsers       = @"/api/v2/home/history";
// 获取广场用户标签列表
static NSString *const kSquareUserTags          = @"/api/v2/home/guru";
// 获取标签下面的用户
static NSString *const kTopicListForTag         = @"/api/v2/home/taguser";
// 发送当前的位置信息到服务器
static NSString *const kUpdateGEO               = @"/api/v2/home/geo";
// 获取附近的人
static NSString *const kNearbyUser              = @"/api/v2/home/nearby";
// 陌生人支付20钻石可聊天
static NSString *const kStrangerPay             = @"/api/v2/stranger/pay";

//--------------------- 动态 -------------------------//
// 所有动态
static NSString *const kDynamicAllList          = @"/api/article/all";
// 附近动态
static NSString *const kDynamicNearList         = @"/api/article/near";
// 关注的人最近动态
static NSString *const kDynamicFollowList       = @"/api/article/follows";
// 点赞动态
static NSString *const kPraiseDynamic           = @"/api/article/like";
// 评论列表
static NSString *const kDynamicCommentList      = @"/api/articlecomment/get";
// 动态详情
static NSString *const kDynamicDetail           = @"/api/article/detail";
// 发表评论
static NSString *const kDynamicPostComment      = @"/api/articlecomment/add";
// 点赞动态
static NSString *const kLikeDynamic             = @"/api/article/like";
// 动态添加
static NSString *const kArticleCreate           = @"/api/article/create";
// 主播动态
static NSString *const kDynamicPersonal         = @"/api/user/article";
// 动态点赞用户
static NSString *const kDynamicPraiseUserList   = @"/api/article/likes";
// 删除动态
static NSString *const kDynamicDelete           = @"/api/article/delete";

//---------------------- 我的 -------------------------//
// 帐号绑定状态
static NSString *const kUserBindStatus          = @"api/user/isbind";

//--------------------- 大神 -------------------------//
// 所有动态
static NSString *const kDashenSubmit            = @"/api/user/dashen";
// 申请大神状态
static NSString *const kdaShenStatus            = @"/api/user/daShenStatus";

//--------------------- 芝麻认证 -------------------------//
//是否有芝麻认证
static NSString *const kZhimaCheck              = @"/api/third/zmxy/check";
//芝麻认证验证接口
static NSString *const kZhimaAuth               = @"/api/third/zmxy/auth";
// 系统配置
static NSString *const kSystemConfig            = @"/api/sys/sysconfig";



#endif /* APIConfig_h */
