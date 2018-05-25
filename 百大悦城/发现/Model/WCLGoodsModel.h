//
//  WCLGoodsModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLGoodsModel : NSObject
@property(nonatomic,strong)NSString* activityDesc;
@property(nonatomic,strong)NSString* berthNo;
@property(nonatomic,assign)NSInteger buyLimitNum;
@property(nonatomic,strong)NSString* buyNum;
@property(nonatomic,assign)NSInteger clickNum;
@property(nonatomic,assign)NSInteger commodityId;
@property(nonatomic,strong)NSString* commodityIntro;
@property(nonatomic,strong)NSString* commodityName;
@property(nonatomic,assign)NSInteger commodityNum;
@property(nonatomic,strong)NSString* commodityState;
@property(nonatomic,strong)NSString*commodityType;
@property(nonatomic,strong)NSString* createTime;
@property(nonatomic,strong)NSString*createTimeBegin ;
@property(nonatomic,strong)NSString*createTimeEnd ;
@property(nonatomic,strong)NSString*creatorId;
@property(nonatomic,strong)NSString*endTime;
@property(nonatomic,strong)NSString*endTimeBegin;
@property(nonatomic,strong)NSString*endTimeEnd;
@property(nonatomic,strong)NSString*floorName;
@property(nonatomic,strong)NSString*getTimeLimit;
@property(nonatomic,assign)NSInteger groupNum;
@property(nonatomic,assign)NSInteger industryId;
@property(nonatomic,strong)NSString*industryName;
@property(nonatomic,strong)NSString*isDelete;
@property(nonatomic,strong)NSString*isJoin;
@property(nonatomic,strong)NSString*isMustGroup;
@property(nonatomic,strong)NSString*isRefund;
@property(nonatomic,strong)NSString*isZeroOffline;
@property(nonatomic,assign)NSInteger joinNum;
@property(nonatomic,strong)NSString*modifierId;
@property(nonatomic,strong)NSString*modifyTime;
@property(nonatomic,strong)NSString*modifyTimeBegin;
@property(nonatomic,strong)NSString*modifyTimeEnd;
@property(nonatomic,strong)NSString*nowDate;
@property(nonatomic,strong)NSString*nowPrice;
@property(nonatomic,strong)NSString*offlineTime;
@property(nonatomic,strong)NSString*offlineTimeBegin;
@property(nonatomic,strong)NSString*offlineTimeEnd;
@property(nonatomic,strong)NSString*oldPrice;
@property(nonatomic,strong)NSString*onlineTime;
@property(nonatomic,strong)NSString*onlineTimeBegin ;
@property(nonatomic,strong)NSString*onlineTimeEnd;
@property(nonatomic,assign)NSInteger organizeId;
@property(nonatomic,strong)NSString*picturePath;
@property(nonatomic,strong)NSString*refundTimeLimit;
@property(nonatomic,assign)NSInteger saleNum;
@property(nonatomic,assign)NSInteger shopId;
@property(nonatomic,strong)NSString*shopLogo;
@property(nonatomic,strong)NSString*shopName;
@property(nonatomic,strong)NSString*showSerial;
@property(nonatomic,strong)NSString*startTime;
@property(nonatomic,strong)NSString*startTimeBegin;
@property(nonatomic,strong)NSString*startTimeEnd;
@property(nonatomic,assign)NSInteger verifyNum;
@end
