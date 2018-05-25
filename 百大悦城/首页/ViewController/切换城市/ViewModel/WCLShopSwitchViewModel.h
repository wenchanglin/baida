//
//  WCLShopSwitchViewModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLShopSwitchViewModel : NSObject
@property (nonatomic, strong) RACSignal           *mainDataSignal;
@property(nonatomic,strong) NSMutableArray * leftArr;
@property(nonatomic,strong) NSMutableArray * rightArr;

@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;

@end
