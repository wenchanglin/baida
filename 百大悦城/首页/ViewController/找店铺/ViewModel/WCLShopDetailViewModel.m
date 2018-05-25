//
//  WCLShopDetailViewModel.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/24.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopDetailViewModel.h"
#import "WCLShopSwitchListModel.h"
#import "WCLFindShopModel.h"
#import "WCLGoodsModel.h"
@implementation WCLShopDetailViewModel
-(instancetype)init
{
    if (self==[super init]) {
        self.mallArr = [NSMutableArray array];
        self.shopArr = [NSMutableArray array];
        self.xinpinArr = [NSMutableArray array];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)ShopDetailWithShopId:(NSInteger)shopID
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"shopId"] = @(shopID);
    parameter[@"organizeId"] = @"2";//responseObject[@"data"][@"organizeId"];
    [[wclNetTool sharedTools]request:POST urlString:URL_Shop_Detail parameters:parameter finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismissWithDelay:1];
      //  WCLLog(@"%@",responseObject);
        WCLShopSwitchListModel * model = [WCLShopSwitchListModel mj_objectWithKeyValues:responseObject[@"mall"]];
        [self.mallArr addObject:model];
        WCLFindShopModel * models = [WCLFindShopModel mj_objectWithKeyValues:responseObject[@"shop"]];
        [self.shopArr addObject:models];
        [self.cell_data_dict setObject:self.mallArr forKey:@"mall"];
        [self.cell_data_dict setObject:self.shopArr forKey:@"shop"];
//        [self ShopDetailWithShopId:shopID];
       
        [subject sendNext:self.cell_data_dict];
    }];
    return subject;
}
//-(RACSignal *)ShopDetailWithXinPinId:(NSInteger)shopID
//{
//    RACReplaySubject * subject = [RACReplaySubject subject];
//    [SVProgressHUD showWithStatus:@"加载中"];
//    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
//    parameter[@"shopId"] = @(shopID);
//    parameter[@"commodityType"] = @"FIRSTLOOK";
//    parameter[@"organizeId"] = @"2";//responseObject[@"data"][@"organizeId"];
//    [[wclNetTool sharedTools]request:POST urlString:URL_Find_GoodsList parameters:parameter finished:^(id responseObject, NSError *error) {
//        [SVProgressHUD dismissWithDelay:1];
//          WCLLog(@"%@",responseObject);
//        if ([responseObject[@"data"] count]>0) {
//            self.xinpinArr = [WCLGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            [self.cell_data_dict setObject:self.xinpinArr forKey:@"xinpin"];
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:@"未获取到数据，请重试"];
//            
//        }
//        [subject sendNext:self.cell_data_dict];
//    }];
//    return subject;
//    
//}
@end
