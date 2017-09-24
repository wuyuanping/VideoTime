//
//  BaseURLCache.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseURLCache.h"

static NSString * const kDiskCachePrefix = @"com.HttpRequest.DiskCache";

@implementation BaseURLCache

+ (instancetype)sharedURLCache
{
    static BaseURLCache *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//缓存数据
- (void)setCacheData:(NSData *)data forKey:(NSString *)urlString
{
    //开启异步线程缓存数据到沙盒
    NSURL *filepathURL  = [self cacheFilePathForKey:urlString];
    dispatch_queue_t _asyncQueue = dispatch_queue_create([[NSString stringWithFormat:@"%@ Asynchronous Queue", kDiskCachePrefix] UTF8String], DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(_asyncQueue, ^{
        [self createCacheDirectoryWithPath:filepathURL];
        [[NSFileManager defaultManager] createFileAtPath:[filepathURL path] contents:data attributes:nil];
    });
}

//获取缓存数据
- (NSData *)cachedDataForKey:(NSString *)urlString
{
    //检查key
    if (urlString == nil) {
        return nil;
    }
    NSURL *filepathURL = [self cacheFilePathForKey:urlString];
    NSData *fileData =  [[NSFileManager defaultManager] contentsAtPath:[filepathURL path]];
    return fileData;
}

//删除URL下数据
- (void)removeCachedResponseForRequestURL:(NSString *)urlString
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *filepathURL = [self cacheFilePathForKey:urlString];
        if (![[NSFileManager defaultManager] fileExistsAtPath:[filepathURL path]])
            return;
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:[filepathURL path] error:&error];
        if (error) {
            NSLog(@"%@ (%d) ERROR: %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [error localizedDescription]);
            return;
        }
    });
}

//删除所有数据(异步)
- (void)removeAllCachedResponses
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *filepathURL = [self cacheFilePathForKey:@""];
        NSString *directory = [[filepathURL absoluteString] stringByDeletingLastPathComponent];
        NSURL *directoryURL = [NSURL URLWithString:directory];
        if (![[NSFileManager defaultManager] fileExistsAtPath:[directoryURL path]])
            return;
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:[directoryURL path] error:&error];
        if (error) {
            NSLog(@"%@ (%d) ERROR: %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [error localizedDescription]);
            return;
        }
    });
}

#pragma mark - get file path
// 获取缓存路径
- (NSURL *)cacheFilePathForKey:(NSString *)keyString
{
    NSString *cacheRootPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *escapedString = [keyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *pathComponent = [[NSString alloc] initWithFormat:@"%@/%@", kDiskCachePrefix, escapedString];
    NSURL *cacheURL = [NSURL fileURLWithPathComponents:@[cacheRootPath, pathComponent]];
    return cacheURL;
}

// 是否创建缓存目录
- (BOOL)createCacheDirectoryWithPath:(NSURL *)url
{
    NSString *directory = [[url absoluteString] stringByDeletingLastPathComponent];
    NSURL *directoryURL = [NSURL URLWithString:directory];
    if ([[NSFileManager defaultManager] fileExistsAtPath:directory])
        return NO;
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtURL:directoryURL
                                            withIntermediateDirectories:YES
                                                             attributes:nil
                                                                  error:&error];
    return success;
}

@end
