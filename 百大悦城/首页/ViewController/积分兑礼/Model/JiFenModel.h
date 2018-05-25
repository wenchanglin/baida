//
//  JiFenModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JiFenModel : NSObject
@property(nonatomic,strong)NSString * accessValue;
@property(nonatomic,strong)NSString *balanceGetNum;
@property(nonatomic,assign)NSInteger balanceNum ;
@property(nonatomic,strong)NSString *couponValue;
@property(nonatomic,strong)NSString *createTime ;
@property(nonatomic,assign)NSInteger creatorId ;
@property(nonatomic,strong)NSString* exchangeIntro;
@property(nonatomic,assign)NSInteger exchangeLimitNum;
@property(nonatomic,assign)NSInteger exchangeNum;
@property(nonatomic,strong)NSString *giftIntro;
@property(nonatomic,strong)NSString *isDelete;
@property(nonatomic,strong)NSString *isZeroOffline;
@property(nonatomic,assign)NSInteger limitGetNum ;
@property(nonatomic,strong)NSString *modifierId ;
@property(nonatomic,strong)NSString *modifyTime;
@property(nonatomic,assign)NSInteger  needScore;
@property(nonatomic,strong)NSString *offlineTime;
@property(nonatomic,strong)NSString *onlineTime;
@property(nonatomic,assign)NSInteger organizeId;
@property(nonatomic,strong)NSString *picUrl ;
@property(nonatomic,assign)NSInteger pointsRewardId;
@property(nonatomic,assign)NSInteger relateId;
@property(nonatomic,strong)NSString *relateName ;
@property(nonatomic,strong)NSString *rewardState;
@property(nonatomic,strong)NSString *rewardType;
@property(nonatomic,strong)NSString *serviceAmount;
@property(nonatomic,strong)NSString *showSerial;
@property(nonatomic,strong)NSString *singleGetNum;
@property(nonatomic,strong)NSString *state;
@end
