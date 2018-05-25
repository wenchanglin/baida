//
//  WCLHomeViewModel.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLHomeViewModel.h"
#import "MainFenLeiModel.h"
#import "WCLHomeBannerModel.h"
#import "WCLHomeFuncModel.h"
#import "WCLHomeCouPonModel.h"
#import "WCLHomeActivityModel.h"
#import "WCLHomeGiftModel.h"
@implementation WCLHomeViewModel
-(instancetype)init
{
    if (self==[super init]) {
        self.mainArr = [NSMutableArray array];
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
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"organizeId"] = @"2";//[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];//@"2";//responseObject[@"data"][@"organizeId"];
    [[wclNetTool sharedTools]request:POST urlString:@"homepage/homePage.json" parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismissWithDelay:1];
        NSMutableArray * mainArr = [MainFenLeiModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (MainFenLeiModel * model in mainArr) {
                params[@"moduleCode"]= model.moduleCode;
                [[wclNetTool sharedTools]request:POST urlString:@"homepage/queryByCode.json" parameters:params finished:^(id responseObject, NSError *error) {
//                    WCLLog(@"%@",responseObject);
                    NSMutableArray * bannerArr;
                    if ([model.moduleName isEqualToString:@"轮播图"]) {
                       bannerArr = [WCLHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                    }
                    else if ([model.moduleName isEqualToString:@"功能菜单"])
                    {
                        bannerArr = [WCLHomeFuncModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                    }
                    else if ([model.moduleName isEqualToString:@"优惠券"])
                    {
//                        WCLLog(@"%@",responseObject[@"data"]);
                        bannerArr = [WCLHomeCouPonModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                    }
                    else if ([model.moduleName isEqualToString:@"活动"])
                    {
//                        WCLLog(@"%@",responseObject);
                        bannerArr = [WCLHomeActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                    }
                    else if ([model.moduleName isEqualToString:@"积分兑礼"])
                    {
                        bannerArr = [WCLHomeGiftModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                    }
                    [self.cell_data_dict setObject:bannerArr forKey:model.moduleName];
                    [subject sendNext:self.cell_data_dict];
                }];
        }
        
    }];
    return subject;
}
@end
