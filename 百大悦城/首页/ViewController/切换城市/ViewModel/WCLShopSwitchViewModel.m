//
//  WCLShopSwitchViewModel.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopSwitchViewModel.h"
#import "WCLShopSwitchModel.h"
@implementation WCLShopSwitchViewModel
-(instancetype)init
{
    if (self==[super init]) {
        self.leftArr = [NSMutableArray array];
        self.rightArr = [NSMutableArray array];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)mainDataSignal
{
    RACReplaySubject * subject = [RACReplaySubject subject];
//    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [[wclNetTool sharedTools]request:POST urlString:URL_SwitchShop_List parameters:params finished:^(id responseObject, NSError *error) {
//        [SVProgressHUD dismiss];
//        WCLLog(@"%@",responseObject[@"data"]);
        if ([[responseObject arrayForKey:@"data"]count]>0) {
            self.leftArr = [WCLShopSwitchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (WCLShopSwitchModel* model in self.leftArr) {
                NSMutableArray * datas = [NSMutableArray array];
                for (WCLShopSwitchListModel*models in model.organizeList) {
                    [datas addObject:models];
                }
                [self.rightArr addObject:datas];
            }
            [self.cell_data_dict setObject:self.leftArr forKey:@"左表"];
            [self.cell_data_dict setObject:self.rightArr forKey:@"右表"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [subject sendNext:@(YES)];
        }
        [subject sendCompleted];
        
    }];
    return subject;
}
@end
