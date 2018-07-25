
//
//  WCLMineViewModel.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLMineViewModel.h"

@implementation WCLMineViewModel
-(instancetype)init
{
    if (self==[super init]) {
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
//-(RACSignal *)loginSignal
//{
//    RACReplaySubject * subject = [RACReplaySubject subject];
//    [SVProgressHUD showWithStatus:@"加载中"];
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    params[@"organizeId"] = @"2";//responseObject[@"data"][@"organizeId"];
//    [[wclNetTool sharedTools]request:POST urlString:@"appRequest/appLogin.json" parameters:params finished:^(id     responseObject, NSError *error) {
//          
//      }];
//    return subject;
//}

@end
