//
//  YPUserDataModel.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPUserDataModel.h"

@implementation YPUserDataModel

+ (void)setObject:(id)destObj forDestKey:(NSString *)destKey
{
    [[NSUserDefaults standardUserDefaults] setObject:destObj forKey:destKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForDestKey:(NSString *)destkey
{
    id object = nil;
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    object = [[NSUserDefaults standardUserDefaults] objectForKey:destkey];
    return object;
}

+ (void)removeObjectForDestKey:(NSString *)destkey
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:destkey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
