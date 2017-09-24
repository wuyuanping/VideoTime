//
//  BaseResponseResult.h
//  VideoTime
//
//  Created by 吴园平 on 23/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YPResponseCode) {
    YPResponseCodeSuccess = 1000,   // 网络请求成功，具体看公司服务器返回数值！！
    
};

@interface BaseResponseResult : NSObject

@property (nonatomic, assign) NSInteger code; // 状态码
@property (nonatomic, strong) id data;   
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSDictionary *response;


@end
