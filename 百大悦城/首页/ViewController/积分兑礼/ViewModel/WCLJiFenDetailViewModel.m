//
//  WCLJiFenDetailViewModel.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLJiFenDetailViewModel.h"
#import "JiFenModel.h"
@implementation WCLJiFenDetailViewModel
-(instancetype)init
{
    if (self==[super init]) {
        self.mainArr = [NSMutableArray array];
    }
    return self;
}
-(NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)exchangeGiftSignalWithNum:(NSInteger)num WithID:(NSInteger)giftId
{
    RACReplaySubject * subject = [RACReplaySubject subject];
//    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"pointsRewardId"] = @(giftId);
    params[@"exchangeNum"] = @(num);
    [[wclNetTool sharedTools]request:POST urlString:URL_GiftExchange parameters:params finished:^(id responseObject, NSError *error) {
//        [SVProgressHUD dismiss];
        WCLLog(@"%@",responseObject);
        if ([responseObject[@"code"]integerValue]==0) {
            NSDictionary* dict =responseObject;
            [subject sendNext:dict];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            [subject sendNext:@0];
        }
        [subject sendCompleted];
    }];
    return subject;
}
-(RACSignal *)mainDataSignalWithID:(NSInteger)ID
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"pointsRewardId"] = @(ID);
    [[wclNetTool sharedTools]request:POST urlString:URL_GiftDetail parameters:params finished:^(id responseObject, NSError *error) {
        WCLLog(@"%@",responseObject);
        if ([responseObject[@"data"]count]>0) {
            JiFenModel *model = [JiFenModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.mainArr addObject:model];
            [self.cell_data_dict setObject:self.mainArr forKey:@"jifenDetail"];
            [subject sendNext:self.cell_data_dict];
        }
        else if ([responseObject[@"code"]integerValue]==500)
        {
            [SVProgressHUD showErrorWithStatus:[responseObject stringForKey:@"msg"]];
            [subject sendNext:@0];
        }
        else
        {
            [subject sendNext:@0];
        }
        [subject sendCompleted];
    }];
    return subject;
}
-(RACSignal *)exchangeGiftSignalWithgainid:(NSInteger)gainid WithID:(NSInteger)giftId
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"pointsRewardId"] = @(giftId);
    params[@"gainId"] = @(gainid);
    [[wclNetTool sharedTools]request:POST urlString:URL_GiftDetail parameters:params finished:^(id responseObject, NSError *error) {
        //        WCLLog(@"%@",responseObject);
        if ([responseObject[@"data"]count]>0) {
        JiFenModel *model = [JiFenModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.mainArr addObject:model];
        [self.cell_data_dict setObject:self.mainArr forKey:@"jifenDetail"];
        [subject sendNext:self.cell_data_dict];
        }
        else if ([responseObject[@"code"]integerValue]==500)
        {
            [SVProgressHUD showErrorWithStatus:[responseObject stringForKey:@"msg"]];
            [subject sendNext:@0];

        }
        else
        {
            [subject sendNext:@0];
        }
        [subject sendCompleted];

    }];
    return subject;
}
@end
