//
//  NSString+YP.m
//  VideoTime
//
//  Created by 吴园平 on 24/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "NSString+YP.h"
#import <CommonCrypto/CommonDigest.h>  // MD5 加密

@implementation NSString (YP)

+ (BOOL)isEmpty:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    NSString *result = trim(string);
    if ([result length] == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (CC_LONG)(self.length), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}



@end
