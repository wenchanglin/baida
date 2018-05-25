//
//  WCLFindShopModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WCLShopIndustryModel:NSObject
@property(nonatomic,assign)NSInteger industryId;
@property(nonatomic,strong)NSString *industryName;
@property(nonatomic,assign)NSInteger organizeId;
@property(nonatomic,assign)NSInteger organizeIndustryId;
@property(nonatomic,assign)NSInteger shopCount;
@property(nonatomic,strong)NSString *shopId;
@property(nonatomic,strong)NSString *styleName;

@end
@interface WCLFindShopFloorModel:NSObject
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,assign)NSInteger creatorId;
@property(nonatomic,strong)NSString *floorDesc;
@property(nonatomic,strong)NSString *floorIcon;
@property(nonatomic,assign)NSInteger floorId;
@property(nonatomic,strong)NSString *floorName;
@property(nonatomic,strong)NSString *floorPicturePath;
@property(nonatomic,strong)NSString *isDelete;
@property(nonatomic,assign)NSInteger modifierId;
@property(nonatomic,strong)NSString *modifyTime;
@property(nonatomic,assign)NSInteger organizeId;
@property(nonatomic,strong)NSString *shopId ;
@property(nonatomic,assign)NSInteger showSerial;
@end
@interface WCLFindShopModel : NSObject
@property(nonatomic,assign)NSInteger berthNo;
@property(nonatomic,assign)NSInteger creatorId;
@property(nonatomic,assign)NSInteger clickNum;
@property(nonatomic,assign)NSInteger organizeId;
@property(nonatomic,assign)NSInteger floorId;
@property(nonatomic,assign)NSInteger modifierId;
@property(nonatomic,assign)NSInteger shopId;
@property(nonatomic,strong)NSString* shopIntro;
@property(nonatomic,assign)NSInteger industryId;
@property(nonatomic,strong)NSString *buildName;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *firstLetter;
@property(nonatomic,strong)NSString *floorName;
@property(nonatomic,strong)NSArray *industryList;
@property(nonatomic,strong)NSString *isDelete;
@property(nonatomic,strong)NSString *industryName;
@property(nonatomic,strong)NSString *isCoupon;
@property(nonatomic,strong)NSString *isGroup;
@property(nonatomic,strong)NSString *isScoreShop;
@property(nonatomic,strong)NSString *isSeckill;
@property(nonatomic,strong)NSString *isSpecial;
@property(nonatomic,strong)NSString *modifyTime;
@property(nonatomic,strong)NSString *organizeIndustryIds;
@property(nonatomic,strong)NSString* regionName;
@property(nonatomic,strong)NSString*shopLogo;
@property(nonatomic,strong)NSString*shopName;
@property(nonatomic,strong)NSString*shopNo;
@property(nonatomic,strong)NSString*shopPicture;
@property(nonatomic,strong)NSString*shopScores;
@property(nonatomic,strong)NSString*showSerial;
@property(nonatomic,strong)NSString*spelling;
@property(nonatomic,strong)NSString*shopPhone;

@end
