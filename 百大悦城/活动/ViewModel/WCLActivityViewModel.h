//
//  WCLActivityViewModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/17.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLActivityViewModel : NSObject
@property(nonatomic,strong)RACSignal * activityDataSignal;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
@property(nonatomic,strong) NSMutableArray * tagListArr;
@property(nonatomic,strong)NSMutableArray * tagIdArr;

@end
