//
//  WCLJiFenDetailViewModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLJiFenDetailViewModel : NSObject
@property(nonatomic,strong) NSMutableArray * mainArr;
/**主数据分类*/
-(RACSignal *)mainDataSignalWithID:(NSInteger)ID;
-(RACSignal *)exchangeGiftSignalWithNum:(NSInteger)num WithID:(NSInteger)giftId;

@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
@end
