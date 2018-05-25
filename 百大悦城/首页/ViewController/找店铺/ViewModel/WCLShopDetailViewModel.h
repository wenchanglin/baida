//
//  WCLShopDetailViewModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/24.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLShopDetailViewModel : NSObject
-(RACSignal *)ShopDetailWithShopId:(NSInteger)shopID;
-(RACSignal *)ShopDetailWithXinPinId:(NSInteger)shopID;
@property(nonatomic,strong)NSMutableArray * xinpinArr;
@property(nonatomic,strong)NSMutableArray * mallArr;
@property(nonatomic,strong)NSMutableArray * shopArr;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
@end
