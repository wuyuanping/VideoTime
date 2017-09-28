//
//  UserInfo.h
//  VideoTime
//
//  Created by 吴园平 on 28/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic,retain) NSString *mid;
@property (nonatomic,retain) NSString *sex;
@property (nonatomic,retain) NSString *nickName;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *headImgUrl;
@property (nonatomic,retain) NSString *country;
@property (nonatomic,retain) NSString *city;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *wxOpenId;
@property (nonatomic,retain) NSString *province;
@property (nonatomic,retain) NSString *sig;
@property (nonatomic,retain) NSString *unionId;
@property (nonatomic,retain) NSString *language;
@property (nonatomic,retain) NSString *phoneNum;
@property (nonatomic,retain) NSString *fensiCount;
@property (nonatomic,retain) NSString *guanzhuCount;
@property (nonatomic,retain) NSString *qGroupId;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,retain) NSString *age;
@property (nonatomic,assign) NSInteger marital_status;
@property (nonatomic,retain) NSString *homeTown;
@property (nonatomic,retain) NSString *job;
@property (nonatomic,assign) BOOL phone_verify_status;
@property (nonatomic,assign) BOOL watchLive;

@property (nonatomic,retain) NSMutableArray *giftArray;


@property (nonatomic,assign) BOOL isAdmin;
@property (nonatomic,assign) BOOL isBan;


@property (nonatomic,retain) NSString *token;
@property (nonatomic,retain) NSString *timeStr;

+ (UserInfo *)getInstance;
- (void)saveMyUserInfo;
- (UserInfo *)getMyUserInfo;
- (void)exitAndClearUserInfo;
- (void)saveWithUserDic:(NSDictionary *)dic;

@end
