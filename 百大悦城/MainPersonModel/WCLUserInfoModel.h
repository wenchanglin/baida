//
//  WCLUserInfoModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLUserInfoModel : NSObject
@property (nonatomic, strong) NSString        *ID;
@property (nonatomic, strong) NSString        *shopid;
@property (nonatomic, strong) NSString        *name;
@property (nonatomic, strong) NSString        *mobile;
@property (nonatomic, strong) NSString        *shopname;
@property (nonatomic, strong) NSString        *logo_url;
@property (nonatomic, strong) NSString        *sum_credit;
@property (nonatomic, strong) NSString        *user_type;
@property (nonatomic, strong) NSString        *company_type_id;
@property (nonatomic, strong) NSString        *audit_reason;
@property (nonatomic, strong) NSString        *company_type_title;
@property (nonatomic, strong) NSString        *aasm_state;
@property (nonatomic, strong) NSString        *district;
@property (nonatomic, strong) NSString        *city;
@property (nonatomic, strong) NSString        *city_name;
@property (nonatomic, strong) NSString        *county_name;
@property (nonatomic, strong) NSString        *province_name;
@property (nonatomic, strong) NSString        *area_name;
@property (nonatomic, strong) NSString        *street_address;
@property (nonatomic, strong) NSString        *desc_address;

@property (nonatomic, strong) NSString        *idpf;
@property (nonatomic, strong) NSString        *idpb;
@property (nonatomic, strong) NSString        *shouchi;
@property (nonatomic, strong) NSString        *busp;
@property (nonatomic, strong) NSString        *mentou;
@property (nonatomic, strong) NSString        *shengchan;
@property (nonatomic, strong) NSString        *liutong;

@property (nonatomic, strong) NSString        *nickname;
@property (nonatomic, strong) NSString        *sex;
@property (nonatomic, strong) NSString        *birthday;
@property (nonatomic, strong) NSString        *e_mail;
@property (nonatomic, strong) NSString        *head_img;
@property (nonatomic, strong) NSMutableArray  *location;
//@property (nonatomic, strong) userinfo_weixin *weixin;
@property (nonatomic, strong) NSString        *credit;
@property (nonatomic, strong) NSString        *credit_begin_date;
@property (nonatomic, strong) NSString        *credit_end_date;
@property (nonatomic, strong) NSString        *member_begin_date;
@property (nonatomic, strong) NSString        *member_end_date;
@property (nonatomic, strong) NSString        *created_at;

@property (nonatomic, strong) NSNumber        *product_follows_count;
@property (nonatomic, strong) NSNumber        *not_shipment_count;
@property (nonatomic, strong) NSNumber        *not_payment_count;
@property (nonatomic, strong) NSNumber        *not_commented_count;
@property (nonatomic, strong) NSNumber        *comment_rate;
@property (nonatomic, strong) NSNumber        *followers_count;
@property (nonatomic, strong) NSNumber        *shop_follows_count;
@property (nonatomic, strong) NSNumber        *follow_state;
@property (nonatomic, strong) NSNumber        *not_approved_count;
@property (nonatomic, strong) NSString        *follow_date;
@property (nonatomic, strong) NSNumber        *follow_shop_money;
+(BOOL)saveSingleModel:(id)model forKey:(NSString *)key;
+(instancetype)readSingleModelForKey:(NSString *)key;
+(BOOL)saveListModel:(NSArray *)ListModel forKey:(NSString *)key;
+(NSArray *)readListModelForKey:(NSString *)key;
@end
