//
//  WCLActivityCalendarViewModel.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityCalendarViewModel.h"
#import "WCLActivityModel.h"
@implementation WCLActivityCalendarViewModel
-(instancetype)init
{
    if (self==[super init]) {
        _tagListArr = [NSMutableArray array];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)activityCalendarDataSignal
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tagId"] = @"0";
    [[wclNetTool sharedTools]request:POST urlString:URL_ActivityList parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        if([responseObject[@"data"] count]>0)
        {
            NSArray*   bannerArr = [WCLActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.cell_data_dict setObject:bannerArr forKey:@"活动日历"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [subject sendNext:@(0)];
        }
    }];
    return subject;
}
@end
