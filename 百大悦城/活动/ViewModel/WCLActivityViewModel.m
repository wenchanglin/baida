//
//  WCLActivityViewModel.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/17.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityViewModel.h"
#import "WCLTagListModel.h"
@implementation WCLActivityViewModel
-(instancetype)init
{
    if (self==[super init]) {
        _tagIdArr = [NSMutableArray array];
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
-(RACSignal *)activityDataSignal
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"organizeId"] =@"2";//[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
    [[wclNetTool sharedTools]request:POST urlString:URL_ActivityList parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismissWithDelay:1];
        for (NSDictionary* tagdict  in responseObject[@"tagList"]) {
            [self.tagListArr addObject:[tagdict stringForKey:@"tagName"]];
            [self.tagIdArr addObject:[tagdict stringForKey:@"id"]];
        }
        [self.cell_data_dict setObject:self.tagListArr forKey:@"活动标签"];
        [self.cell_data_dict setObject:self.tagIdArr forKey:@"活动标签ID"];
        [subject sendNext:self.cell_data_dict];
    }];
    return subject;
}
@end
