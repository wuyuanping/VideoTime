//
//  NSString+YP.h
//  VideoTime
//
//  Created by 吴园平 on 24/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define trim(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] // 去掉字符串前后空格

@interface NSString (YP)

/**
 * 判断字符串是否为空
 */
+ (BOOL)isEmpty:(NSString *)string;


/**
 *  返回md5加密后字符串
 */
- (NSString *)md5;

@end
