//
//  WCLGoodsViewModel.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLGoodsViewModel.h"
#import "WCLGoodsModel.h"
@implementation WCLGoodsViewModel
-(instancetype)init
{
    if (self==[super init]) {
        _goodsArr = [NSMutableArray array];
        _goodsNewArr = [NSMutableArray array];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)goodsSpecialDataSignal
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"organizeId"] = @"2";//responseObject[@"data"][@"organizeId"];
    params[@"commodityType"] = @"SPECIAL";
    [[wclNetTool sharedTools]request:POST urlString:URL_Find_GoodsList parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismissWithDelay:1];
          if ([responseObject[@"data"] count]>0) {
        self.goodsArr = [WCLGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.cell_data_dict setObject:self.goodsArr forKey:@"人气"];
        [subject sendNext:self.cell_data_dict];
          }else
          {
              [SVProgressHUD showErrorWithStatus:@"未获取到数据，请重试"];
          }
    }];
    return subject;
}
-(RACSignal *)goodsNewDataSignal
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"organizeId"] = @"2";//responseObject[@"data"][@"organizeId"];
    params[@"commodityType"] = @"FIRSTLOOK";
    [[wclNetTool sharedTools]request:POST urlString:URL_Find_GoodsList parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismissWithDelay:1];
//        WCLLog(@"新品:%@",responseObject[@"data"]);
        if ([responseObject[@"data"] count]>0) {
            self.goodsNewArr = [WCLGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.cell_data_dict setObject:self.goodsNewArr forKey:@"新品"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"未获取到数据，请重试"];
            
        }
    }];
    return subject;
}

@end
