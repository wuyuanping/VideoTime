//
//  YPUserDataModel.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

//  本类用来 简化保存持久化数据的操作, 基于 NSUserDefaults

#import <Foundation/Foundation.h>

// 用户保存 Token的key
#define UserSetTookenKey            @"setTookenKey"     // 用户登录后的COOKIE
#define UserInfoDictKey             @"UserInfoDictKey"  // 用户信息

#define kFirstLaunchKey             @"firstLaunch"

#define UserInfoDictAvatarKey       @"avatar"
#define UserInfoDictEmailKey        @"email"
#define UserInfoDictIDKey           @"user_id"
#define UserInfoDictNameKey         @"name"

// 保存上次选择的类别
#define SelectedCategoryKey         @"SelectedCategoryKey"
// 保存类别数据
#define CategoryListKey             @"CategoryListKey"


@interface YPUserDataModel : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, copy) NSString *nim_token;
@property (nonatomic, copy) NSString *WXAccessToken;

// 添加
+ (void)setObject:(id)destObj forDestKey:(NSString *)destKey;

// 读取
+ (id)objectForDestKey:(NSString *)destkey;

// 删除
+ (void)removeObjectForDestKey:(NSString *)destkey;

@end
