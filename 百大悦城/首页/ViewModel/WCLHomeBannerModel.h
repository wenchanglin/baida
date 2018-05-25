//
//  WCLHomeBannerModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLHomeBannerModel : NSObject
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger objectId;
@property(nonatomic,strong)NSString * objectName;
@property(nonatomic,strong)NSString * organizeId;
@property(nonatomic,assign)NSInteger sort;
@property(nonatomic,strong)NSString*advertPic;
@property(nonatomic,strong)NSString*advertUrl;
@property(nonatomic,strong)NSString*createTime;
@property(nonatomic,strong)NSString*creatorId;
@property(nonatomic,strong)NSString*isDelete;
@property(nonatomic,strong)NSString*modifierId;
@property(nonatomic,strong)NSString*modifyTime;
@property(nonatomic,strong)NSString*moduleCode;
@end
