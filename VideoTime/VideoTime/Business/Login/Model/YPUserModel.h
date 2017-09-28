//
//  YPUserModel.h
//  VideoTime
//
//  Created by 吴园平 on 27/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPUserDetailModel : NSObject <NSCoding,NSCopying>

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *avatar;
//@property (nonatomic, strong) NSString *rongyun_token;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *phone;

@end


@interface YPUserModel : NSObject<NSCopying,NSCoding>

@property (nonatomic, strong) YPUserDetailModel *data;

@end
