//
//  WCLUserModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLUserModel : NSObject
@property (nonatomic , copy) NSString              * user_type;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * aasm_state;
@property (nonatomic , copy) NSString              * audit_desc;
@property (nonatomic , copy) NSString              * wx_headimgurl;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * email;
@property (nonatomic , copy) NSString              * avatar_url;
@property (nonatomic , copy) NSString              * authentication_token;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * openid;
@property (nonatomic , copy) NSString              * userinfo_id;
+(BOOL)saveSingleModel:(id)model forKey:(NSString *)key;
+(instancetype)readSingleModelForKey:(NSString *)key;
+(BOOL)saveListModel:(NSArray *)ListModel forKey:(NSString *)key;
+(NSArray *)readListModelForKey:(NSString *)key;
@end
