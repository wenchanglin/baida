//
//  WCLActivityingViewModel.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityingViewModel.h"
#import "WCLActivityModel.h"
@implementation WCLActivityingViewModel
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
-(RACSignal *)activityingDataSignal
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"status"] = @"DOING";//进行中
    params[@"organizeId"] =@"2";//[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
    [[wclNetTool sharedTools]request:POST urlString:URL_ActivityList parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismissWithDelay:1];
       if([responseObject[@"data"] count]>0)
       {
       NSArray*   bannerArr = [WCLActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.cell_data_dict setObject:bannerArr forKey:@"活动进行时"];
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
