//
//  WCLUserInfoModel.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLUserInfoModel.h"

@implementation WCLUserInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
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
