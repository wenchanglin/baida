//
//  WCLActivityingViewModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLActivityingViewModel : NSObject
-(RACSignal *)activityingDataSignalWithtagId:(NSString*)tagId;
@property(nonatomic,strong) NSMutableArray * tagListArr;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
@end
