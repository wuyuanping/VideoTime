//
//  UserInfo.m
//  VideoTime
//
//  Created by 吴园平 on 28/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *userInfo = nil;
@implementation UserInfo

+ (UserInfo *)getInstance
{
    if(userInfo == nil)
    {
        userInfo = [[UserInfo alloc] init];
        if (userInfo.mid.length == 0) {
            [[UserInfo getInstance] getMyUserInfo];
        }
    }
    return userInfo;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.mid = @"";
        self.sex = @"";
        self.nickName = @"";
        self.address = @"";
        self.name = @"";
        self.phoneNum = @"";
        self.headImgUrl = @"";
        self.country = @"";
        self.province = @"";
        self.city = @"";
        self.unionId = @"";
        self.sig = @"";
        self.language = @"";
        self.wxOpenId = @"";
        self.isAdmin = NO;
        self.isBan = NO;
        self.token = @"";
        self.timeStr = @"";
        self.fensiCount = @"";
        self.guanzhuCount = @"";
        self.marital_status = 0;
        self.homeTown = @"";
        self.job = @"";
        self.age = @"";
        self.phone_verify_status = NO;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.mid forKey:@"mid"];
    [encoder encodeObject:self.nickName forKey:@"nickName"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.phoneNum forKey:@"phoneNum"];
    [encoder encodeObject:self.headImgUrl forKey:@"headImgUrl"];
    [encoder encodeObject:self.country forKey:@"country"];
    [encoder encodeObject:self.province forKey:@"province"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.unionId forKey:@"unionId"];
    [encoder encodeObject:self.sig forKey:@"sig"];
    [encoder encodeObject:self.language forKey:@"language"];
    [encoder encodeObject:self.wxOpenId forKey:@"wxOpenId"];
    [encoder encodeObject:self.giftArray forKey:@"giftArray"];
    [encoder encodeBool:self.isAdmin forKey:@"isAdmin"];
    [encoder encodeBool:self.isBan forKey:@"isBan"];
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.timeStr forKey:@"timeStr"];
    [encoder encodeObject:self.fensiCount forKey:@"fensiCount"];
    [encoder encodeObject:self.guanzhuCount forKey:@"guanzhuCount"];
    [encoder encodeObject:self.qGroupId forKey:@"qGroupId"];
    [encoder encodeInteger:self.marital_status forKey:@"marital_status"];
    [encoder encodeObject:self.homeTown forKey:@"hometown"];
    [encoder encodeObject:self.job forKey:@"job"];
    [encoder encodeObject:self.age forKey:@"age"];
    [encoder encodeBool:self.phone_verify_status forKey:@"phone_verify_status"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        self.mid = [decoder decodeObjectForKey:@"mid"];
        self.sex = [decoder decodeObjectForKey:@"sex"];
        self.nickName = [decoder decodeObjectForKey:@"nickName"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.phoneNum = [decoder decodeObjectForKey:@"phoneNum"];
        self.headImgUrl = [decoder decodeObjectForKey:@"headImgUrl"];
        self.country = [decoder decodeObjectForKey:@"country"];
        self.province = [decoder decodeObjectForKey:@"province"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.unionId = [decoder decodeObjectForKey:@"unionId"];
        self.sig = [decoder decodeObjectForKey:@"sig"];
        self.language = [decoder decodeObjectForKey:@"language"];
        self.wxOpenId = [decoder decodeObjectForKey:@"wxOpenId"];
        self.giftArray = [decoder decodeObjectForKey:@"giftArray"];
        self.isAdmin = [decoder decodeBoolForKey:@"isAdmin"];
        self.isBan = [decoder decodeBoolForKey:@"isBan"];
        self.token = [decoder decodeObjectForKey:@"token"];
        self.timeStr = [decoder decodeObjectForKey:@"timeStr"];
        self.fensiCount = [decoder decodeObjectForKey:@"fensiCount"];
        self.guanzhuCount = [decoder decodeObjectForKey:@"guanzhuCount"];
        self.qGroupId = [decoder decodeObjectForKey:@"qGroupId"];
        self.marital_status = [decoder decodeIntegerForKey:@"marital_status"];
        self.homeTown = [decoder decodeObjectForKey:@"hometown"];
        self.job = [decoder decodeObjectForKey:@"job"];
        self.age = [decoder decodeObjectForKey:@"age"];
        self.phone_verify_status = [decoder decodeBoolForKey:@"phone_verify_status"];
    }
    return  self;
}

- (void)saveWithUserDic:(NSDictionary *)dic
{
    self.mid = [dic objectForKey:@"mid"];
    self.sex = [dic objectForKey:@"sex"];
    self.nickName = [dic objectForKey:@"nickname"];
    self.address = [dic objectForKey:@"address"];
    if ([[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        self.name = @"";
    }else{
        self.name = [dic objectForKey:@"name"];
    }
    if ([[dic objectForKey:@"phone"] isKindOfClass:[NSNull class]]) {
        self.phoneNum = @"";
    }else{
        self.phoneNum = [dic objectForKey:@"phone"];
    }
    if ([[dic objectForKey:@"city"] isKindOfClass:[NSNull class]]) {
        self.city = @"";
    }else{
        self.city = [dic objectForKey:@"city"];
    }
    self.headImgUrl = [dic objectForKey:@"headimgurl"];
    self.country = [dic objectForKey:@"country"];
    self.province = [dic objectForKey:@"province"];
    self.unionId = [dic objectForKey:@"unionid"];
    self.sig = [dic objectForKey:@"sig"];
    self.language = [dic objectForKey:@"language"];
    self.wxOpenId = [dic objectForKey:@"openid"];
    self.isAdmin = [[dic objectForKey:@"is_admin"] boolValue];
    self.isBan = [[dic objectForKey:@"is_forbid"] boolValue];
    self.fensiCount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fensi"]];
    self.guanzhuCount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"guanzhu"]];
    self.qGroupId = [dic objectForKey:@"q_group_id"];
    self.marital_status = [[dic objectForKey:@"marital_status"] integerValue];
    self.homeTown = [dic objectForKey:@"hometown"];
    self.job = [dic objectForKey:@"job"];
    self.age = [NSString stringWithFormat:@"%@",[dic objectForKey:@"age"]];
    self.phone_verify_status = [[dic objectForKey:@"phone_verify_status"] boolValue];
    [self saveMyUserInfo];
}

- (void)saveMyUserInfo
{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myEncodedObject forKey:@"userInfo"];
    [defaults synchronize];
}

- (UserInfo *)getMyUserInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:@"userInfo"];
    UserInfo *obj = (UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
    self.mid = obj.mid;
    self.sex = obj.sex;
    self.nickName = obj.nickName;
    self.address = obj.address;
    self.name = obj.name;
    self.phoneNum = obj.phoneNum;
    self.headImgUrl = obj.headImgUrl;
    self.country = obj.country;
    self.province = obj.province;
    self.city = obj.city;
    self.unionId = obj.unionId;
    self.sig = obj.sig;
    self.language = obj.language;
    self.wxOpenId = obj.wxOpenId;
    self.giftArray = obj.giftArray;
    self.isAdmin = obj.isAdmin;
    self.isBan = obj.isBan;
    self.token = obj.token;
    self.timeStr = obj.timeStr;
    self.fensiCount = obj.fensiCount;
    self.guanzhuCount = obj.guanzhuCount;
    self.qGroupId = obj.qGroupId;
    self.isAdmin = obj.isAdmin;
    self.isBan = obj.isBan;
    self.marital_status = obj.marital_status;
    self.homeTown = obj.homeTown;
    self.job = obj.job;
    self.age = obj.age;
    self.phone_verify_status = obj.phone_verify_status;
    return self;
}

- (void)exitAndClearUserInfo
{
    self.mid = @"";
    self.sex = @"";
    self.nickName = @"";
    self.address = @"";
    self.name = @"";
    self.phoneNum = @"";
    self.headImgUrl = @"";
    self.country = @"";
    self.province = @"";
    self.city = @"";
    self.unionId = @"";
    self.sig = @"";
    self.language = @"";
    self.wxOpenId = @"";
    self.isAdmin = NO;
    self.isBan = NO;
    self.token = @"";
    self.timeStr = @"";
    self.fensiCount = @"";
    self.guanzhuCount = @"";
    self.qGroupId = @"";
    self.marital_status = 0;
    self.homeTown = @"";
    self.job = @"";
    self.age = @"";
    self.phone_verify_status = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"userInfo"];
    [[UserInfo getInstance] saveMyUserInfo];
    
}

@end
