//
//  NetworkHelper.h
//  VideoTime
//
//  Created by 吴园平 on 28/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 *  成功回调
 */
typedef void (^requestSucc)(NSInteger code,NSString *msg, id data);
/**
 *  失败回调
 */
typedef void (^requestFail)(NSString *error);

@interface NetworkHelper : NSObject

/**
 * 获取单例
 */
+ (NetworkHelper *) sharedInstance;

#pragma mark - 微信接口请求

/**
 * 根据微信授权返回的code，请求token和openid
 *  @param succ   成功回调
 *  @param fail   失败回调
 */
- (void)getWeChatTokenAndOpenIdWithCode:(NSString *)code succ:(requestSucc)succ fail:(requestFail)fail;


/**
 * 刷新微信的token
 *  @param succ   成功回调
 *  @param fail   失败回调
 */
- (void)refreshWeChatToken:(requestSucc)succ fail:(requestFail)fail;

/**
 * 获取微信个人信息
 *  @param succ   成功回调
 *  @param fail   失败回调
 */
- (void)getWeChatUserInfo:(requestSucc)succ fail:(requestFail)fail;

@end
