//
//  YPCommonTool.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YPCommonTool : NSObject

+ (CGSize)findWidthForText:(NSString *)text havingHeight:(CGFloat)heightValue andFont:(UIFont *)font;

+ (NSString *)getReadableStringForTime:(long)sec;

+ (NSURLRequest *)urlToURLRequest:(NSString *)string;

+ (void)webViewSetCookie;

/**
 * 是否为视频链接
 *@params link 链接
 */
+ (BOOL)isVideoLink:(NSString *)link;

/**
 * accid to uuid
 */
+ (NSString *)accidToUUID:(NSString *)accid;

/**
 * uuid to acceid
 */
+ (NSString *)uuidToAccid:(NSString *)uuid;

@end
