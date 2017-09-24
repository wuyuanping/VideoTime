//
//  BaseResponseResult.m
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseResponseResult.h"

@implementation BaseResponseResult

- (NSString *)description
{
    NSString *des = [NSString stringWithFormat:@"code : %ld\n %@", self.code, [self.data description]];
    return des;
}

@end
