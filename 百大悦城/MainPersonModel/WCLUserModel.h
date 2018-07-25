//
//  WCLUserModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLUserModel : NSObject<NSCoding>
@property (nonatomic , copy) NSString              * appUuid;
@property (nonatomic , copy) NSString              * cardLevelId;
@property(nonatomic,assign)NSInteger balanceScore;
@property (nonatomic , copy) NSString              * entityCardId;
@property (nonatomic , copy) NSString              * idCardNumber;
@property (nonatomic , copy) NSString              * isDelete;
@property (nonatomic , copy) NSString              * isQuit;
@property (nonatomic , copy) NSString              * isSubscribe;
@property (nonatomic , copy) NSString              * memberBirthday;
@property (nonatomic , copy) NSString              * memberCardNo;
@property (nonatomic , copy) NSString              * memberCity;
@property (nonatomic , copy) NSString              * memberCountry;
@property(nonatomic,copy)NSDictionary*memberCardGradeDTO;
@property (nonatomic , copy) NSString              * memberHead;
@property (nonatomic , copy) NSString              * memberId;
@property (nonatomic , copy) NSString              * memberName;
@property (nonatomic , copy) NSString              * memberNickName;
@property (nonatomic , copy) NSString              * memberPhone;
@property (nonatomic , copy) NSString              * memberProvince;
@property (nonatomic , copy) NSString              * memberPwd;
@property (nonatomic , copy) NSString              * memberScore;
@property (nonatomic , copy) NSString              * memberSex;

@property (nonatomic , copy) NSString  * memberType;
@property (nonatomic , copy) NSString  * modifyTime;
@property (nonatomic , copy) NSString  * memberSource;
@property (nonatomic , copy) NSString  * organizeId;
@property (nonatomic , copy) NSString  * registerOrganizeId;
@property (nonatomic , copy) NSString  * registerTime;
@property (nonatomic , copy) NSString  * subscribeChangeTime;
@property (nonatomic , copy) NSString  * subscribeTime;
@property (nonatomic , copy) NSString  * unionId;
@property (nonatomic , copy) NSString  * unsubscribeChangeTime;
@property(nonatomic,strong)NSString*useScore;

+(BOOL)saveSingleModel:(id)model forKey:(NSString *)key;
+(instancetype)readSingleModelForKey:(NSString *)key;
+(BOOL)saveListModel:(NSArray *)ListModel forKey:(NSString *)key;
+(NSArray *)readListModelForKey:(NSString *)key;
@end
