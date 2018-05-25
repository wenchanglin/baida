//
//  WCLFindShopViewModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/21.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLFindShopViewModel : NSObject
-(RACSignal *)findShopSignalShopName:(NSString *)shopName withindustryId:(NSString*)industryId withfloorId:(NSString*)floorId;
@property(nonatomic,strong) NSMutableArray * floorArr;
@property(nonatomic,strong)NSMutableArray * shopListArr;
@property(nonatomic,strong)NSMutableArray * shopIndustryArr;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
@end
