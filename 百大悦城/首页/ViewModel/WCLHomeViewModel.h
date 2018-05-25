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
/**主数据分类*/
@property (nonatomic, strong) RACSignal           *mainDataSignal;

/**
 *  广告Signal
 */
@property (nonatomic, strong) RACSignal           *bannerAndZhengWenSignal;
/**
 *  设计师作品和店铺Signal
 */
@property (nonatomic, strong) RACSignal           *designerAndDianPuSiganl;
/**
 *  正文Signal
 */
- (RACSignal *)siganlForProductRecommend;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
@end
