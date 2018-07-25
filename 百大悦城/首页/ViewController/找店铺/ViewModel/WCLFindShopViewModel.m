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
-(RACSignal *)findShopSignalShopName:(NSString *)shopName withindustryId:(NSString*)industryId withfloorId:(NSString*)floorId page:(NSInteger)page
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"shopName"] = shopName;
    parameter[@"floorId"] = floorId;
    parameter[@"pageNum"] = @(page);

    parameter[@"industryId"] = industryId;
    [[wclNetTool sharedTools]request:POST urlString:@"shop/getShopList.json" parameters:parameter finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        self.shopIndustryArr = [WCLShopIndustryModel mj_objectArrayWithKeyValuesArray:responseObject[@"industryList"]];
        self.floorArr = [WCLFindShopFloorModel mj_objectArrayWithKeyValuesArray:responseObject[@"floorList"]];
        NSMutableArray*shopArr = [WCLFindShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"shopList"]];
        WCLShopIndustryModel* model = [WCLShopIndustryModel mj_objectWithKeyValues:@{@"industryId":@"",@"industryName":@"全部分类",@"organizeId":[[NSUserDefaults standardUserDefaults] objectForKey:@"organizeId"],@"organizeIndustryId":@"",@"shopCount":@"",@"shopId":@"",@"styleName":@""}];
        [self.shopIndustryArr insertObject:model atIndex:0];
        WCLFindShopFloorModel * modelse = [WCLFindShopFloorModel mj_objectWithKeyValues:@{@"createTime":@"",@"creatorId":@"",@"floorDesc":@"",@"floorIcon":@"",@"floorId":@"",@"floorName":@"全部楼层",@"floorPicturePath":@"",@"modifierId":@"",@"modifyTime":@"",@"organizeId":[[NSUserDefaults standardUserDefaults] objectForKey:@"organizeId"],@"shopId":@"",@"showSerial":@""}];
        [self.floorArr insertObject:modelse atIndex:0];
//        WCLLog(@"%@",shopArr);
        for (WCLFindShopModel*model in shopArr) {
            [self.shopListArr addObject:model];
        }
        
        [self.cell_data_dict setObject:responseObject[@"page"][@"pages"] forKey:@"page"];
        [self.cell_data_dict setObject:self.floorArr forKey:@"全部楼层"];
        [self.cell_data_dict setObject:self.shopListArr forKey:@"店铺列表"];
        [self.cell_data_dict setObject:self.shopIndustryArr forKey:@"全部分类"];
        [subject sendNext:self.cell_data_dict];
//        [subject sendCompleted];
    }];
    return subject;
}
//-(RACSignal *)findShopSignalMoreDataShopName:(NSString *)shopName withindustryId:(NSString*)industryId withfloorId:(NSString*)floorId page:(NSInteger)page
//{
//    RACReplaySubject * subject = [RACReplaySubject subject];
//    [SVProgressHUD showWithStatus:@"加载中"];
//    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
//    parameter[@"shopName"] = shopName;
//    parameter[@"floorId"] = floorId;
//    parameter[@"industryId"] = industryId;
//    parameter[@"organizeId"] = @"2";//responseObject[@"data"][@"organizeId"];
//    [[wclNetTool sharedTools]request:POST urlString:@"shop/loadMoreShop.json" parameters:parameter finished:^(id responseObject, NSError *error) {
//        [SVProgressHUD dismissWithDelay:1];
//        //        WCLLog(@"%@",responseObject[@"shopList"]);
//        self.shopIndustryArr = [WCLShopIndustryModel mj_objectArrayWithKeyValuesArray:responseObject[@"industryList"]];
//        self.floorArr = [WCLFindShopFloorModel mj_objectArrayWithKeyValuesArray:responseObject[@"floorList"]];
//        NSMutableArray*shopArr = [WCLFindShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"shopList"]];
//        for (WCLFindShopModel*model in shopArr) {
//            [self.shopListArr addObject:model];
//        }
//        [self.cell_data_dict setObject:responseObject[@"page"][@"pages"] forKey:@"page"];
//        [self.cell_data_dict setObject:self.floorArr forKey:@"全部楼层"];
//        [self.cell_data_dict setObject:self.shopListArr forKey:@"店铺列表"];
//        [self.cell_data_dict setObject:self.shopIndustryArr forKey:@"全部分类"];
//        [subject sendNext:self.cell_data_dict];
//        //        [subject sendCompleted];
//    }];
//    return subject;
//}
@end
