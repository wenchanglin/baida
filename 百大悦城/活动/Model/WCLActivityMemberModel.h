//
//  WCLActivityMemberModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLActivityMemberModel : NSObject
@property(nonatomic,assign)NSInteger balanceScore;
@property(nonatomic,strong)NSString* birthday;
@property(nonatomic,strong)NSString* cardLevelId;
@property(nonatomic,strong)NSString* entityCardId;
@property(nonatomic,strong)NSString*isDelete;
@property(nonatomic,strong)NSString* idCardNumber;
@property(nonatomic,strong)NSString*isQuit;
@property(nonatomic,strong)NSString*listMemberExtraInfo;
@property(nonatomic,strong)NSString*memberBirthday;
@property(nonatomic,strong)NSString*memberBirthdayBegin;
@property(nonatomic,strong)NSString*memberBirthdayEnd;
@property(nonatomic,strong)NSString*memberCardNo;
@property(nonatomic,strong)NSString*memberCarnumber;
@property(nonatomic,strong)NSString*memberCity;
@property(nonatomic,strong)NSString*memberCountry;
@property(nonatomic,strong)NSString*memberHead;
@property(nonatomic,assign)NSInteger memberId;
@property(nonatomic,strong)NSString*memberName;
@property(nonatomic,strong)NSString*memberNickName;
@property(nonatomic,strong)NSString*memberPhone;
@property(nonatomic,strong)NSString*memberProvince;
@property(nonatomic,strong)NSString*memberSex;
@property(nonatomic,strong)NSString*memberType;
@property(nonatomic,strong)NSString*modifyTime;
@property(nonatomic,strong)NSString*modifyTimeBegin;
@property(nonatomic,strong)NSString*modifyTimeEnd;
@property(nonatomic,strong)NSString*openId;
@property(nonatomic,strong)NSString*organizeId;
@property(nonatomic,strong)NSString*registerTime;
@property(nonatomic,strong)NSString*registerTimeBegin;
@property(nonatomic,strong)NSString*registerTimeEnd;
@property(nonatomic,strong)NSString*subscribeTime;
@property(nonatomic,strong)NSString*subscribeTimeBegin;
@property(nonatomic,strong)NSString*subscribeTimeEnd;
@property(nonatomic,assign)NSInteger useScore;
@property(nonatomic,assign)NSInteger memberScore;
@property(nonatomic,strong)NSString *memberSource;

@end
