//
//  WCLUserModel.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLUserModel.h"

@implementation WCLUserModel
/*
 
 
 */

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.appUuid forKey:@"appUuid"];
    [aCoder encodeInteger:self.balanceScore forKey:@"balanceScore"];
    [aCoder encodeObject:self.cardLevelId forKey:@"cardLevelId"];
    [aCoder encodeObject:self.entityCardId forKey:@"entityCardId"];
    [aCoder encodeObject:self.idCardNumber forKey:@"idCardNumber"];
    [aCoder encodeObject:self.isDelete forKey:@"isDelete"];
    [aCoder encodeObject:self.isQuit forKey:@"isQuit"];
    [aCoder encodeObject:self.isSubscribe forKey:@"isSubscribe"];
    [aCoder encodeObject:self.memberBirthday forKey:@"memberBirthday"];
    [aCoder encodeObject:self.memberCardNo forKey:@"memberCardNo"];
    [aCoder encodeObject:self.memberCity forKey:@"memberCity"];
    [aCoder encodeObject:self.memberCountry forKey:@"memberCountry"];
    [aCoder encodeObject:self.memberNickName forKey:@"memberNickName"];
    [aCoder encodeObject:self.memberPhone forKey:@"memberPhone"];
    [aCoder encodeObject:self.memberName forKey:@"memberName"];
    [aCoder encodeObject:self.memberHead forKey:@"memberHead"];
    [aCoder encodeObject:self.memberId forKey:@"memberId"];
    [aCoder encodeObject:self.memberProvince forKey:@"memberProvince"];
    [aCoder encodeObject:self.memberCardGradeDTO forKey:@"memberCardGradeDTO"];
    [aCoder encodeObject:self.memberPwd forKey:@"memberPwd"];
    [aCoder encodeObject:self.memberScore forKey:@"memberScore"];
    [aCoder encodeObject:self.memberSex forKey:@"memberSex"];
    [aCoder encodeObject:self.memberType forKey:@"memberType"];
    [aCoder encodeObject:self.modifyTime forKey:@"modifyTime"];
    [aCoder encodeObject:self.memberSource forKey:@"memberSource"];
    [aCoder encodeObject:self.organizeId forKey:@"organizeId"];
    [aCoder encodeObject:self.registerOrganizeId forKey:@"registerOrganizeId"];
    [aCoder encodeObject:self.registerTime forKey:@"registerTime"];
    [aCoder encodeObject:self.subscribeChangeTime forKey:@"subscribeChangeTime"];
    [aCoder encodeObject:self.subscribeTime forKey:@"subscribeTime"];
    [aCoder encodeObject:self.unionId forKey:@"unionId"];
    [aCoder encodeObject:self.unsubscribeChangeTime forKey:@"unsubscribeChangeTime"];
    [aCoder encodeObject:self.useScore forKey:@"useScore"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self==[super init]) {
        self.appUuid = [aDecoder decodeObjectForKey:@"appUuid"];
        self.balanceScore = [aDecoder decodeIntegerForKey:@"balanceScore"];
        self.cardLevelId = [aDecoder decodeObjectForKey:@"cardLevelId"];
       self.entityCardId = [aDecoder decodeObjectForKey:@"entityCardId"];
        self.memberPhone = [aDecoder decodeObjectForKey:@"memberPhone"];
        self.memberNickName=[aDecoder decodeObjectForKey:@"memberNickName"];
        self.idCardNumber = [aDecoder decodeObjectForKey:@"idCardNumber"];
        self.isDelete = [aDecoder decodeObjectForKey:@"isDelete"];
        self.isQuit = [aDecoder decodeObjectForKey:@"isQuit"];
        self.isSubscribe = [aDecoder decodeObjectForKey:@"isSubscribe"];
        self.memberBirthday = [aDecoder decodeObjectForKey:@"memberBirthday"];
        self.memberCardNo = [aDecoder decodeObjectForKey:@"self.memberCardNo"];
        self.memberCity = [aDecoder decodeObjectForKey:@"memberCity"];
        self.memberCountry = [aDecoder decodeObjectForKey:@"memberCountry"];
        self.memberHead = [aDecoder decodeObjectForKey:@"memberHead"];
        self.memberId = [aDecoder decodeObjectForKey:@"memberId"];
        self.memberName = [aDecoder decodeObjectForKey:@"memberName"];
        self.memberNickName = [aDecoder decodeObjectForKey:@"memberNickName"];
        self.memberPhone = [aDecoder decodeObjectForKey:@"memberPhone"];
        self.memberProvince=[aDecoder decodeObjectForKey:@"memberProvince"];
        self.memberPwd=[aDecoder decodeObjectForKey:@"memberPwd"];
        self.memberScore = [aDecoder decodeObjectForKey:@"memberScore"];
        self.memberCardGradeDTO = [aDecoder decodeObjectForKey:@"memberCardGradeDTO"];
        self.memberSex = [aDecoder decodeObjectForKey:@"memberSex"];
        self.memberType = [aDecoder decodeObjectForKey:@"memberType"];
        self.modifyTime= [aDecoder decodeObjectForKey:@"modifyTime"];;
        self.memberSource=[aDecoder decodeObjectForKey:@"memberSource"];;
        self.organizeId = [aDecoder decodeObjectForKey:@"organizeId"];
        self.registerOrganizeId = [aDecoder decodeObjectForKey:@"registerOrganizeId"];
        self.registerTime = [aDecoder decodeObjectForKey:@"registerTime"];
        self.subscribeChangeTime = [aDecoder decodeObjectForKey:@"subscribeChangeTime"];
        self.subscribeTime = [aDecoder decodeObjectForKey:@"subscribeTime"];
        self.unionId = [aDecoder decodeObjectForKey:@"unionId"];
        self.unsubscribeChangeTime = [aDecoder decodeObjectForKey:@"unsubscribeChangeTime"];
        self.useScore = [aDecoder decodeObjectForKey:@"useScore"];
    }
    return self;
    
}
+(BOOL)saveSingleModel:(id)model forKey:(NSString *)key{
    NSString *pathKey = key==nil?NSStringFromClass(self):key;
    return [NSKeyedArchiver archiveRootObject:model toFile:CoreArchiver_SingCACHE_PATH(pathKey)];
}
+(instancetype)readSingleModelForKey:(NSString *)key{
    NSString *pathKey = key==nil?NSStringFromClass(self):key;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:CoreArchiver_SingCACHE_PATH(pathKey)];
}
+(BOOL)saveListModel:(NSArray *)ListModel forKey:(NSString *)key{
    NSString *pathKey = key==nil?NSStringFromClass(self):key;
    return [NSKeyedArchiver archiveRootObject:ListModel toFile:CoreArchiver_ArrayCACHE_PATH(pathKey)];
}
+(NSArray *)readListModelForKey:(NSString *)key{
    NSString *pathKey = key==nil?NSStringFromClass(self):key;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:CoreArchiver_ArrayCACHE_PATH(pathKey)];
}
@end
