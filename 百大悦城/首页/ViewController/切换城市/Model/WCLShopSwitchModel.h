//
//  WCLShopSwitchModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLShopSwitchModel : NSObject
@property(nonatomic,assign)NSInteger cityId;
@property(nonatomic,strong)NSString* cityName;
@property(nonatomic,strong)NSString*createTime;
@property(nonatomic,assign)NSInteger creatorId;
@property(nonatomic,strong)NSString* isDelete;
@property(nonatomic,strong)NSString*isSelected;
@property(nonatomic,strong)NSString*modifierId;
@property(nonatomic,strong)NSString*modifyTime;
@property(nonatomic,assign)NSInteger organizeId;
@property(nonatomic,strong)NSArray*organizeList;
@property(nonatomic,assign)NSInteger showSerial;
@end
