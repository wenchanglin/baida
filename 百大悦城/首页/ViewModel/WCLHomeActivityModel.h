//
//  WCLHomeActivityModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLHomeActivityModel : NSObject
@property(nonatomic,strong)NSString* accessType;
@property(nonatomic,strong)NSString* accessValue;
@property(nonatomic,strong)NSString* acivityType;
@property(nonatomic,strong)NSString* activityName;
@property(nonatomic,strong)NSString* activityPic;
@property(nonatomic,strong)NSString*balanceNum;
@property(nonatomic,strong)NSString*broughtNum;
@property(nonatomic,strong)NSString*couponDesc;
@property(nonatomic,strong)NSString*couponImage;
@property(nonatomic,strong)NSString*couponName;
@property(nonatomic,strong)NSString*couponTypeCy;
@property(nonatomic,strong)NSString*couponTypeKind;
@property(nonatomic,strong)NSString*couponValue;
@property(nonatomic,strong)NSString*dayBroughtNum;
@property(nonatomic,strong)NSString*endTime;
@property(nonatomic,strong)NSString*endTimeStr;
@property(nonatomic,strong)NSString*giftPicturePath;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString*limitNum;
@property(nonatomic,strong)NSString*limitPerDayNum;
@property(nonatomic,strong)NSString*memberBroughtNum;
@property(nonatomic,strong)NSString*memberSignupState;
@property(nonatomic,strong)NSString*needScore;
@property(nonatomic,assign)NSInteger objectId;
@property(nonatomic,strong)NSString*relateName;
@property(nonatomic,assign)NSInteger signup;
@property(nonatomic,strong)NSString*sort;
@property(nonatomic,strong)NSString*startTime;
@property(nonatomic,strong)NSString*startTimeStr;
@property(nonatomic,strong)NSString*state;
@property(nonatomic,strong)NSString*stock;
@property(nonatomic,strong)NSArray*tags;/*(
                                         {
                                         activityTagsId = "<null>";
                                         createTime = "<null>";
                                         creatorId = "<null>";
                                         id = "<null>";
                                         isDelete = "<null>";
                                         marketingActivitySignupId = "<null>";
                                         modifierId = "<null>";
                                         modifyTime = "<null>";
                                         organizeId = "<null>";
                                         tagName = "1\U5566\U5566\U5566\U5566\U5566";
                                         }
                                         );*/

@property(nonatomic,strong)NSString * useRange;
@property(nonatomic,strong)NSString *voteStartTime;
@end
