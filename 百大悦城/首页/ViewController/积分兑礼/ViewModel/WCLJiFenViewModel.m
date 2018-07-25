//
//  WCLJiFenViewModel.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLJiFenViewModel.h"
#import "JiFenModel.h"
@implementation WCLJiFenViewModel
-(instancetype)init
{
    if (self==[super init]) {
        self.mainArr = [NSMutableArray array];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)mainDataSignalSortType:(NSString*)type pageNum:(NSInteger)pagenum
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"pageNum"] = @(pagenum);
    params[@"sortType"] = type;
    params[@"pointsRewardTyp"] = @"GIFT";
    [[wclNetTool sharedTools]request:POST urlString:URL_GiftAndCouPonList parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            [subject sendNext:@0];
        }
        else
        {
            if ([responseObject[@"data"]count]>0) {
            NSMutableArray * mainArr = [JiFenModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (JiFenModel * model in mainArr) {
                [self.mainArr addObject:model];
            }
            [self.cell_data_dict setObject:responseObject[@"page"][@"pages"] forKey:@"page"];
            [self.cell_data_dict setObject:self.mainArr forKey:@"jifen"];
            [subject sendNext:self.cell_data_dict];
            }
            else
            {
            [subject sendNext:@0];
            }
        }
//        [subject sendCompleted];
    }];
    return subject;
}
@end
