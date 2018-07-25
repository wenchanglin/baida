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
#import "WCLBroadModel.h"
#import "WCLHomeTopicModel.h"
#import "WCLMallFloorModel.h"
#import "WCLMiaoShaModel.h"
@implementation WCLHomeViewModel
-(instancetype)init
{
    if (self==[super init]) {
        self.mainArr = [NSMutableArray array];
        self.mallFloorArr = [NSMutableArray array];
        self.mallfloor_cell_data_dict = [NSMutableDictionary dictionary];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)siganlForexchangeByPointsWithCouponId:(NSInteger)couponid withcyCouponId:(NSInteger)cyCouponId withExchangeValue:(NSString*)exchange
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"couponId"] = @(couponid);
    params[@"cyCouponId"] = @(cyCouponId);
    params[@"exchangeNum"] =@"1";
    params[@"memberId"] = [WCLUserManageCenter shareInstance].userInfoModel.memberId;
    params[@"exchangeValue"] = exchange;
    [[wclNetTool sharedTools]request:POST urlString:URL_ExchageByPoints parameters:params finished:^(id responseObject, NSError *error) {
//        WCLLog(@"%@",responseObject);
        if([responseObject[@"code"] integerValue]==0)
            {
                NSDictionary * dict = @{@"shengyu":[responseObject stringForKey:@"data"],@"istrue":@(YES)};
                [subject sendNext:dict];
                [SVProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
            }
        else
        {
            [subject sendNext:@(NO)];
            if ([responseObject stringForKey:@"msg"].length>0) {
                [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];

            }
            
        }
        [subject sendCompleted];
    }];
    return subject;
}
-(RACSignal *)mainDataSignal
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [[wclNetTool sharedTools]request:POST urlString:@"app/homepage/homePage.json" parameters:params finished:^(id responseObject, NSError *error) {
        if ([responseObject[@"code"]integerValue]==500) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        else
        {
            if ([responseObject[@"data"]count]>0) {
                NSMutableArray * mainArr = [MainFenLeiModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                
                for (MainFenLeiModel * model in mainArr) {
                    //                WCLLog(@"%@---%@--",model.moduleName,responseObject);
                    
                    params[@"moduleCode"]= model.moduleCode;
                    [[wclNetTool sharedTools]request:POST urlString:@"app/homepage/queryByCode.json" parameters:params finished:^(id responseObject, NSError *error) {
                        NSMutableArray * bannerArr =[NSMutableArray array];
                        
                        if ([model.moduleCode isEqualToString:@"BANNER"]) {
                            if ([responseObject[@"code"]intValue]==500) {
                                //                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                                bannerArr = [NSMutableArray array];
                            }
                            else
                            {
//                                WCLLog(@"%@",responseObject[@"data"]);
                                bannerArr = [WCLHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                            }
                        }
                        else if ([model.moduleCode isEqualToString:@"MAIN"]||[model.moduleCode isEqualToString:@"EXTRA"])
                        {
                            if ([responseObject[@"code"]intValue]==500) {
                                //                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                                bannerArr = [NSMutableArray array];
                            }
                            else
                            {
                                bannerArr = [WCLHomeFuncModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                            }
                        }
                        else if ([model.moduleCode isEqualToString:@"COUPON"])
                        {
                            if ([responseObject[@"code"]intValue]==500) {
                                //                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                                bannerArr = [NSMutableArray array];
                            }
                            else
                            {
//                                WCLLog(@"%@---%@--",model.moduleName,responseObject);

                                bannerArr = [WCLHomeCouPonModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                            }
                        }
                        else if ([model.moduleCode isEqualToString:@"ACTIVITY"])
                        {
                            //                        WCLLog(@"%@",responseObject);
                            if ([responseObject[@"code"]intValue]==500) {
                                //                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                                bannerArr = [NSMutableArray array];
                            }
                            else
                            {
                                bannerArr = [WCLHomeActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                            }
                        }
                        else if ([model.moduleCode isEqualToString:@"GIFT"])
                        {
                            if ([responseObject[@"code"]intValue]==500) {
                                //                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                                bannerArr = [NSMutableArray array];
                            }
                            else
                            {
                                bannerArr = [WCLHomeGiftModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                            }
                        }
                        else if([model.moduleCode isEqualToString:@"BROAD"])
                        {
                            if ([responseObject[@"code"]intValue]==500) {
                                //                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                                bannerArr = [NSMutableArray array];
                            }
                            else
                            {
                                bannerArr = [WCLBroadModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                            }
                        }
                        else if([model.moduleCode isEqualToString:@"TOPIC"])//主题 TOPIC
                        {
                            //                        WCLLog(@"%@-%@-%@",model.moduleCode,model.moduleName,responseObject);
                            if ([responseObject[@"code"]intValue]==500) {
                                //                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                                bannerArr = [NSMutableArray array];
                            }
                            else
                            {
                                bannerArr = [WCLHomeTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                            }
                        }
                        else if([model.moduleCode isEqualToString:@"GROUPON"])//团购
                        {
//                            WCLLog(@"%@--%@",model.moduleCode,responseObject);
                            if ([responseObject[@"code"]intValue]==500) {
                                //                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                                bannerArr = [NSMutableArray array];
                            }
                            else
                            {
                                bannerArr = [WCLMiaoShaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                            }
                        }
                        else if ([model.moduleCode isEqualToString:@"SECKILL"])
                        {
//                            WCLLog(@"%@--%@",model.moduleCode,responseObject);
                            if ([responseObject[@"code"]intValue]==500) {
                                //                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                                bannerArr = [NSMutableArray array];
                            }
                            else
                            {
                                bannerArr = [WCLMiaoShaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                            }
                        }
                        else
                        {
                            //                        WCLLog(@"%@-%@-%@",model.moduleCode,model.moduleName,responseObject);
                            
                        }
                        [self.cell_data_dict setObject:bannerArr.count>0?bannerArr:@[].mutableCopy forKey:model.moduleCode];
                        [subject sendNext:self.cell_data_dict];
                    }];
                }
                
            }
            else
            {
               NSMutableArray* bannerArr = [NSMutableArray array];
                [self.cell_data_dict setObject:bannerArr forKey:@"无模块数据"];
                [subject sendNext:self.cell_data_dict];
            }
        }
    }];
    return subject;
}
-(RACSignal *)mallfloorSiganl
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"加载中"];
    [[wclNetTool sharedTools]request:GET urlString:URL_MallFloor parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
//        WCLLog(@"%@---%@",responseObject,error);
       if([responseObject[@"data"]count]>0)
       {
           self.mallFloorArr = [WCLMallFloorModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
           [self.mallfloor_cell_data_dict setObject:self.mallFloorArr forKey:@"室内导航"];
           [subject sendNext:self.mallfloor_cell_data_dict];
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
