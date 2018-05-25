//
//  WCLHomeCouPonModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLHomeCouPonModel : NSObject
@property(nonatomic,strong)NSString* accessType;
@property(nonatomic,assign)NSInteger accessValue;
@property(nonatomic,strong)NSString*acivityType;
@property(nonatomic,strong)NSString*activityName;
@property(nonatomic,strong)NSString*activityPic;
@property(nonatomic,assign)NSInteger balanceNum;
@property(nonatomic,assign)NSInteger broughtNum;
@property(nonatomic,strong)NSString* couponDesc;
@property(nonatomic,strong)NSString* couponImage;
@property(nonatomic,strong)NSString*couponName;
@property(nonatomic,assign)NSInteger couponTypeCy;
@property(nonatomic,strong)NSString*couponTypeKin;
@property(nonatomic,assign)NSInteger couponValue;
@property(nonatomic,assign)NSInteger dayBroughtNum;
@property(nonatomic,strong)NSString*endTime;
@property(nonatomic,strong)NSString*endTimeStr;
@property(nonatomic,strong)NSString*giftPicturePath;
@property(nonatomic,strong)NSString*ID;
@property(nonatomic,assign)NSInteger limitNum;
@property(nonatomic,strong)NSString*limitPerDayNum;
@property(nonatomic,assign)NSInteger memberBroughtNum;
@property(nonatomic,strong)NSString*memberSignupState;
@property(nonatomic,assign)NSInteger needScore;
@property(nonatomic,assign)NSInteger objectId;
@property(nonatomic,strong)NSString*relateName;
@property(nonatomic,assign)NSInteger signup;
@property(nonatomic,strong)NSString*sort;
@property(nonatomic,strong)NSString*startTime;
@property(nonatomic,strong)NSString*startTimeStr;
@property(nonatomic,strong)NSString*state;
@property(nonatomic,strong)NSString* stock;
@property(nonatomic,strong)NSString*tags;
@property(nonatomic,assign)NSInteger useRange;
@property(nonatomic,strong)NSString*voteStartTime;
@end
