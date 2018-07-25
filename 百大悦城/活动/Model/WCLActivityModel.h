//
//  WCLActivityModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLActivityModel : NSObject
@property(nonatomic,strong)NSString* acivityAddress;
@property(nonatomic,strong)NSString* acivityType;
@property(nonatomic,strong)NSString* activityEndtime;
@property(nonatomic,strong)NSString* activityIntroduce;
@property(nonatomic,strong)NSString* activityPicture;
@property(nonatomic,strong)NSString* activityStarttime;
@property(nonatomic,strong)NSString* activityTitle;
@property(nonatomic,strong)NSString* createTime;
@property(nonatomic,assign)NSInteger creatorId;
@property(nonatomic,strong)NSString* endTime;
@property(nonatomic,strong)NSString* endTimeStr;
@property(nonatomic,strong)NSString*signupTime;
@property(nonatomic,assign)NSString* enrollFee;//现金
@property(nonatomic,assign)NSString* enrollScore;//积分
@property(nonatomic,strong)NSString* extraIntroduce;
@property(nonatomic,strong)NSString*isAudit;
@property(nonatomic,strong)NSString* isDelete;
@property(nonatomic,assign)BOOL isSignup;
@property(nonatomic,assign)NSInteger joinNumber;
@property(nonatomic,assign)NSInteger marketingActivitySignupId;
@property(nonatomic,assign)NSInteger memberLevel;
@property(nonatomic,strong)NSString* memberSignupState;
@property(nonatomic,assign)NSInteger modifierId;
@property(nonatomic,strong)NSString* modifyTime;
@property(nonatomic,strong)NSString* offlineTime;
@property(nonatomic,strong)NSString*onlineTime;
@property(nonatomic,assign)NSInteger organizeId;
@property(nonatomic,strong)NSString*signStateText;
@property(nonatomic,strong)NSString*signinOffline;
@property(nonatomic,assign)NSInteger signupLimitNumber;
@property(nonatomic,assign)NSInteger signupNumber;
@property(nonatomic,strong)NSString* signupState;
@property(nonatomic,strong)NSString*startTime;
@property(nonatomic,strong)NSString*startTimeStr;
@property(nonatomic,strong)NSArray*tags;
@property(nonatomic,strong)NSString*telephone;
@property(nonatomic,strong)NSString*useCrowd;
@property(nonatomic,strong)NSString*verifyCode;
@end
