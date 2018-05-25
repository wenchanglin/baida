//
//  WCLActivityDetailViewModel.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityDetailViewModel.h"
#import "WCLActivityModel.h"
#import "WCLActivityMemberModel.h"
@implementation WCLActivityDetailViewModel
-(instancetype)init
{
    if (self==[super init]) {
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
-(RACSignal *)activityDetailDataSignal:(NSInteger)ID
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSMutableArray * asfl = [NSMutableArray array];

    params[@"id"] = @(ID);//进行中
    params[@"organizeId"] =@"2";//[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
    [[wclNetTool sharedTools]request:POST urlString:URL_ActivityDetail parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismissWithDelay:1];
        WCLLog(@"%@",responseObject[@"data"][@"member"]);
//        {
            WCLActivityModel* bannerArr = [WCLActivityModel mj_objectWithKeyValues:responseObject[@"data"][@"signupDo"]];
        [self.tagListArr addObject:bannerArr];
//        WCLLog(@"%@",bannerArr);
        [self.cell_data_dict setObject:self.tagListArr forKey:@"活动详情0"];
        WCLActivityMemberModel * memberArr = [WCLActivityMemberModel mj_objectWithKeyValues:responseObject[@"data"][@"member"]];
        [asfl addObject:memberArr];
        [self.cell_data_dict  setObject:asfl forKey:@"活动详情1"];
        [subject sendNext:self.cell_data_dict];
//        }
//        else
//        {
//            [subject sendNext:@(0)];
//        }
    }];
    return subject;
}
@end
