//
//  WCLFindShopViewModel.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/21.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLFindShopViewModel.h"
#import "WCLFindShopModel.h"
@implementation WCLFindShopViewModel
-(instancetype)init
{
    if (self==[super init]) {
        self.floorArr = [NSMutableArray array];
        self.shopListArr = [NSMutableArray array];
        self.shopIndustryArr = [NSMutableArray array];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)findShopSignalShopName:(NSString *)shopName withindustryId:(NSString*)industryId withfloorId:(NSString*)floorId
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"shopName"] = shopName;
    parameter[@"floorId"] = floorId;
    parameter[@"industryId"] = industryId;
    parameter[@"organizeId"] = @"2";//responseObject[@"data"][@"organizeId"];
    [[wclNetTool sharedTools]request:POST urlString:@"shop/getShopList.json" parameters:parameter finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismissWithDelay:1];
        
        self.shopIndustryArr = [WCLShopIndustryModel mj_objectArrayWithKeyValuesArray:responseObject[@"industryList"]];
        self.floorArr = [WCLFindShopFloorModel mj_objectArrayWithKeyValuesArray:responseObject[@"floorList"]];
        self.shopListArr = [WCLFindShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"shopList"]];
        [self.cell_data_dict setObject:self.floorArr forKey:@"全部楼层"];
        [self.cell_data_dict setObject:self.shopListArr forKey:@"店铺列表"];
        [self.cell_data_dict setObject:self.shopIndustryArr forKey:@"全部分类"];
        [subject sendNext:self.cell_data_dict];
    }];
    return subject;
}
@end
