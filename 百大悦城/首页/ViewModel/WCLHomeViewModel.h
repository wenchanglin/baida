//
//  WCLHomeViewModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLHomeViewModel : NSObject
@property(nonatomic,strong) NSMutableArray * mainArr;
@property(nonatomic,strong) NSMutableArray * mallFloorArr;
@property (nonatomic, strong) NSMutableDictionary *mallfloor_cell_data_dict;

/**主数据分类*/
@property (nonatomic, strong) RACSignal           *mainDataSignal;

/**
 *  广告Signal
 */
@property (nonatomic, strong) RACSignal           *bannerAndZhengWenSignal;
/**
 *  室内导航Signal
 */
@property (nonatomic, strong) RACSignal           *mallfloorSiganl;
/**
 *  正文Signal
 */
-(RACSignal *)siganlForexchangeByPointsWithCouponId:(NSInteger)couponid withcyCouponId:(NSInteger)cyCouponId withExchangeValue:(NSString*)exchange;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
@end
