//
//  WCLUserInfoModel.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLUserInfoModel.h"

@implementation WCLUserInfoModel

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accountBalance forKey:@"accountBalance"];
    [aCoder encodeObject:self.cardLevel forKey:@"cardLevel"];
    [aCoder encodeObject:self.cardLevelDO forKey:@"cardLevelDO"];
    [aCoder encodeObject:self.cardLevelPic forKey:@"cardLevelPic"];
    [aCoder encodeObject:self.entityCardId forKey:@"entityCardId"];
    [aCoder encodeObject:self.memberCardGradeDTO forKey:@"memberCardGradeDTO"];
    [aCoder encodeObject:self.cardNumber forKey:@"cardNumber"];
    [aCoder encodeObject:self.couponCount forKey:@"couponCount"];
    [aCoder encodeObject:self.gradeNo forKey:@"gradeNo"];
    [aCoder encodeObject:self.points forKey:@"points"];
    [aCoder encodeObject:self.totalAccount forKey:@"totalAccount"];
    [aCoder encodeObject:self.memberCity forKey:@"memberCity"];
    [aCoder encodeObject:self.version forKey:@"version"];
    [aCoder encodeObject:self.payPassword forKey:@"payPassword"];
    [aCoder encodeObject:self.memberPhone forKey:@"memberPhone"];
    [aCoder encodeObject:self.memberName forKey:@"memberName"];
    [aCoder encodeObject:self.memberHead forKey:@"memberHead"];
    [aCoder encodeObject:self.memberCountry forKey:@"memberCountry"];
    [aCoder encodeObject:self.memberId forKey:@"memberId"];
    [aCoder encodeObject:self.currentLevel forKey:@"currentLevel"];
    [aCoder encodeObject:self.memberNickname forKey:@"memberNickname"];
    [aCoder encodeObject:self.memberProvince forKey:@"memberProvince"];
    [aCoder encodeObject:self.memberBirthday forKey:@"memberBirthday"];
//    [aCoder encodeObject:self.memberScore forKey:@"memberScore"];
    [aCoder encodeObject:self.memberSex forKey:@"memberSex"];
//    [aCoder encodeObject:self.memberType forKey:@"memberType"];
//    [aCoder encodeObject:self.modifyTime forKey:@"modifyTime"];
//    [aCoder encodeObject:self.memberSource forKey:@"memberSource"];
//    [aCoder encodeObject:self.organizeId forKey:@"organizeId"];
//    [aCoder encodeObject:self.registerOrganizeId forKey:@"registerOrganizeId"];
//    [aCoder encodeObject:self.registerTime forKey:@"registerTime"];
//    [aCoder encodeObject:self.subscribeChangeTime forKey:@"subscribeChangeTime"];
//    [aCoder encodeObject:self.subscribeTime forKey:@"subscribeTime"];
//    [aCoder encodeObject:self.unionId forKey:@"unionId"];
//    [aCoder encodeObject:self.unsubscribeChangeTime forKey:@"unsubscribeChangeTime"];
//    [aCoder encodeObject:self.useScore forKey:@"useScore"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self==[super init]) {
        self.accountBalance = [aDecoder decodeObjectForKey:@"accountBalance"];
        self.cardLevel = [aDecoder decodeObjectForKey:@"cardLevel"];
        self.cardLevelDO = [aDecoder decodeObjectForKey:@"cardLevelDO"];
        self.cardLevelPic=[aDecoder decodeObjectForKey:@"cardLevelPic"];
        self.entityCardId = [aDecoder decodeObjectForKey:@"entityCardId"];
        self.memberCardGradeDTO= [aDecoder decodeObjectForKey:@"memberCardGradeDTO"];
        self.memberPhone = [aDecoder decodeObjectForKey:@"memberPhone"];
        self.cardNumber = [aDecoder decodeObjectForKey:@"cardNumber"];
        self.gradeNo = [aDecoder decodeObjectForKey:@"gradeNo"];
        self.couponCount = [aDecoder decodeObjectForKey:@"couponCount"];
        self.points = [aDecoder decodeObjectForKey:@"points"];
        self.memberCity = [aDecoder decodeObjectForKey:@"memberCity"];
        self.totalAccount = [aDecoder decodeObjectForKey:@"totalAccount"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
        self.memberHead = [aDecoder decodeObjectForKey:@"memberHead"];
        self.memberId = [aDecoder decodeObjectForKey:@"memberId"];
        self.memberName = [aDecoder decodeObjectForKey:@"memberName"];
        self.memberCountry = [aDecoder decodeObjectForKey:@"memberCountry"];
        self.payPassword = [aDecoder decodeObjectForKey:@"payPassword"];
        self.currentLevel=[aDecoder decodeObjectForKey:@"currentLevel"];
        self.memberNickname = [aDecoder decodeObjectForKey:@"memberNickname"];
        self.memberProvince = [aDecoder decodeObjectForKey:@"memberProvince"];
        self.memberBirthday=[aDecoder decodeObjectForKey:@"memberBirthday"];
//        self.memberScore = [aDecoder decodeObjectForKey:@"memberScore"];
        self.memberSex = [aDecoder decodeObjectForKey:@"memberSex"];
//        self.memberType = [aDecoder decodeObjectForKey:@"memberType"];
//        self.modifyTime= [aDecoder decodeObjectForKey:@"modifyTime"];;
//        self.memberSource=[aDecoder decodeObjectForKey:@"memberSource"];;
//        self.organizeId = [aDecoder decodeObjectForKey:@"organizeId"];
//        self.registerOrganizeId = [aDecoder decodeObjectForKey:@"registerOrganizeId"];
//        self.registerTime = [aDecoder decodeObjectForKey:@"registerTime"];
//        self.subscribeChangeTime = [aDecoder decodeObjectForKey:@"subscribeChangeTime"];
//        self.subscribeTime = [aDecoder decodeObjectForKey:@"subscribeTime"];
//        self.unionId = [aDecoder decodeObjectForKey:@"unionId"];
//        self.unsubscribeChangeTime = [aDecoder decodeObjectForKey:@"unsubscribeChangeTime"];
//        self.useScore = [aDecoder decodeObjectForKey:@"useScore"];
    }
    return self;
    
}
-(NSString *)description
{
    NSMutableDictionary * dictionry = [NSMutableDictionary dictionary];
    uint count;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        objc_property_t preperty = propertys[i];
        NSString *name = @(property_getName(preperty));
        id value = [self valueForKey:name]?:@"nil";//默认值为nil
        [dictionry setObject:value forKey:name];
    }
    free(propertys);
    return [NSString stringWithFormat:@"<%@: %p>-- %@",[self class],self,dictionry];
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
