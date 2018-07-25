//
//  WCLUserInfoModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLUserInfoModel : NSObject

@property (nonatomic, strong) NSString        *accountBalance;
@property (nonatomic, strong) NSString        *cardLevel;
@property (nonatomic, strong) NSString        *cardLevelDO;
@property (nonatomic, strong) NSString        *cardLevelPic;
@property (nonatomic, strong) NSString        *cardNumber;

@property (nonatomic, strong) NSString        *couponCount;
@property (nonatomic, strong) NSString        *currentLevel;
@property (nonatomic, strong) NSString        *entityCardId;
@property (nonatomic, strong) NSString        *memberName;
@property (nonatomic, strong) NSString        *gradeNo;
@property(nonatomic,strong)NSString *memberCity;
@property(nonatomic,strong)NSString * memberCountry;
@property (nonatomic, strong) NSString        *memberHead;
@property (nonatomic, strong) NSString        *memberId;
@property (nonatomic, strong) NSString        *memberPhone;
@property (nonatomic, strong) NSString        *payPassword;
@property (nonatomic, strong) NSString        *points;
@property(nonatomic,strong)NSString *memberNickname;
@property(nonatomic,strong)NSString*memberProvince;
@property (nonatomic, strong) NSString        *totalAccount;
@property (nonatomic, strong) NSString        *version;
@property(nonatomic,strong)NSDictionary *memberCardGradeDTO;
@property(nonatomic,strong)NSString * memberSex;
@property(nonatomic,strong)NSString*memberBirthday;
//@property (nonatomic, strong) NSString        *area_name;
//@property (nonatomic, strong) NSString        *street_address;
//@property (nonatomic, strong) NSString        *desc_address;
//
//@property (nonatomic, strong) NSString        *idpf;
//@property (nonatomic, strong) NSString        *idpb;
//@property (nonatomic, strong) NSString        *shouchi;
//@property (nonatomic, strong) NSString        *busp;
//@property (nonatomic, strong) NSString        *mentou;
//@property (nonatomic, strong) NSString        *shengchan;
//@property (nonatomic, strong) NSString        *liutong;
//
//@property (nonatomic, strong) NSString        *nickname;
//@property (nonatomic, strong) NSString        *sex;
//@property (nonatomic, strong) NSString        *birthday;
//@property (nonatomic, strong) NSString        *e_mail;
//@property (nonatomic, strong) NSString        *head_img;
//@property (nonatomic, strong) NSMutableArray  *location;
////@property (nonatomic, strong) userinfo_weixin *weixin;
//@property (nonatomic, strong) NSString        *credit;
//@property (nonatomic, strong) NSString        *credit_begin_date;
//@property (nonatomic, strong) NSString        *credit_end_date;
//@property (nonatomic, strong) NSString        *member_begin_date;
//@property (nonatomic, strong) NSString        *member_end_date;
//@property (nonatomic, strong) NSString        *created_at;
//
//@property (nonatomic, strong) NSNumber        *product_follows_count;
//@property (nonatomic, strong) NSNumber        *not_shipment_count;
//@property (nonatomic, strong) NSNumber        *not_payment_count;
//@property (nonatomic, strong) NSNumber        *not_commented_count;
//@property (nonatomic, strong) NSNumber        *comment_rate;
//@property (nonatomic, strong) NSNumber        *followers_count;
//@property (nonatomic, strong) NSNumber        *shop_follows_count;
//@property (nonatomic, strong) NSNumber        *follow_state;
//@property (nonatomic, strong) NSNumber        *not_approved_count;
//@property (nonatomic, strong) NSString        *follow_date;
//@property (nonatomic, strong) NSNumber        *follow_shop_money;
+(BOOL)saveSingleModel:(id)model forKey:(NSString *)key;
+(instancetype)readSingleModelForKey:(NSString *)key;
+(BOOL)saveListModel:(NSArray *)ListModel forKey:(NSString *)key;
+(NSArray *)readListModelForKey:(NSString *)key;
@end
