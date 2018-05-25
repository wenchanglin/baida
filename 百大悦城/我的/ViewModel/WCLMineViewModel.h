//
//  WCLMineViewModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLMineViewModel : NSObject
/**登录*/
@property (nonatomic, strong) RACSignal           *loginSignal;

//@property(nonatomic,strong)RACSignal * 
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;

@end
