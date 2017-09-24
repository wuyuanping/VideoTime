//
//  YPUserDefaultHelper.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

// 用户偏好设置相关
#import <Foundation/Foundation.h>

@interface YPUserDefaultHelper : NSObject

// 添加
+ (void)setObject:(id)destObj forDestKey:(NSString *)destKey;

// 读取
+ (id)objectForDestKey:(NSString *)destkey;

// 删除
+ (void)removeObjectForDestKey:(NSString *)destkey;

@end
