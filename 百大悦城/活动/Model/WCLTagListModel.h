//
//  WCLTagListModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/17.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLTagListModel : NSObject
@property(nonatomic,strong)NSString*  createTime;
@property(nonatomic,assign)NSInteger creatorId;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString* isDelete;
@property(nonatomic,assign)NSInteger modifierId;
@property(nonatomic,strong)NSString* modifyTime;
@property(nonatomic,assign)NSInteger organizeId;
@property(nonatomic,assign)NSInteger showSerial;
@property(nonatomic,strong)NSString *tagName;
@end
