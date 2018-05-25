//
//  WCLJiFenViewModel.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLJiFenViewModel : NSObject
@property(nonatomic,strong) NSMutableArray * mainArr;
/**主数据分类*/
-(RACSignal *)mainDataSignalSortType:(NSString*)type pageNum:(NSInteger)pagenum;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;

@end
