//
//  WCLGoodsViewModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLGoodsViewModel : NSObject
@property(nonatomic,strong)RACSignal * goodsNewDataSignal;
@property(nonatomic,strong) NSMutableArray * goodsArr;
@property(nonatomic,strong)RACSignal * goodsSpecialDataSignal;
@property(nonatomic,strong)NSMutableArray *goodsNewArr;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
@end
