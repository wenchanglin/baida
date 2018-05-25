//
//  WCLActivityDetailUIService.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityDetailUIService.h"
#import "WCLActivityDetailVC.h"
#import "WCLActivityDetailViewModel.h"
#import "WCLActivityModel.h"
#import "WCLActivityMemberModel.h"
#import "WCLActivityDetailCell.h"
#import "WCLSignUpCell.h"
#import "WCLActivityMemberModel.h"
@interface WCLActivityDetailUIService()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)WCLActivityDetailViewModel * viewModel;
@property(nonatomic,weak)WCLActivityDetailVC * activityVC;
@end
@implementation WCLActivityDetailUIService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _viewModel = (WCLActivityDetailViewModel*)viewModel;
        _activityVC = (WCLActivityDetailVC*)VC;
        [_activityVC.view addSubview:self.detailTableView];
        [self requestActivityData];
        
    }
    return self;
}
-(void)requestActivityData
{
    WEAK
    [[self.viewModel activityDetailDataSignal:self.activityVC.activityID]subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.detailTableView.mj_header endRefreshing];
        [self.detailTableView reloadData];
    }];
}
-(UITableView *)detailTableView
{
    if (!_detailTableView) {
        
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-84:SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        self.detailTableView.estimatedSectionHeaderHeight = 0;
        self.detailTableView.estimatedSectionFooterHeight=0;
        [_detailTableView registerClass:[WCLActivityDetailCell class] forCellReuseIdentifier:@"WCLActivityDetailCell"];
        [_detailTableView registerClass:[WCLSignUpCell class] forCellReuseIdentifier:@"WCLSignUpCell"];
        //        [_activityTableView registerClass:[WCLHomeGiftCell class] forCellReuseIdentifier:@"GiftCell"];
        //        [_homeTableView registerClass:[WCLHomeActivityCell class] forCellReuseIdentifier:@"activitycells"];
        [_detailTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_detailTableView setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED"]];
        WEAK
        //        [YBLMethodTools footerAutoRefreshWithTableView:_homeTableView completion:^{
        //            STRONG
        //            [self loadCommandMore];
        //        }];
        [YBLMethodTools headerRefreshWithTableView:_detailTableView completion:^{
            STRONG
            [self requestActivityData];
        }];
    }
    return _detailTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;//[self.viewModel.cell_data_dict[@"活动"] count] ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"活动详情0"];
    CGFloat heights=0;
    if (indexPath.section==0) {
        if(array1.count>0)
        {
        WCLActivityModel * models= array1[indexPath.row];
        CGRect titleBounds = [models.activityIntroduce boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14]} context:nil];
        heights = titleBounds.size.height;

        }
        return 460+heights;

    }
    else
    {
        NSArray * array2 = [self.viewModel.cell_data_dict arrayForKey:@"活动详情1"];
        if(array2.count>0)
        {
            WCLActivityMemberModel* models = array2[indexPath.row];
            CGRect titleBounds = [models.listMemberExtraInfo boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14]} context:nil];
            heights = titleBounds.size.height;
        }
    return 195+heights;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * celles;
    if (indexPath.section==0) {
        WCLActivityDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLActivityDetailCell"];
        
        NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"活动详情0"];
        if (array1.count>0) {
            WCLActivityModel * models = array1[indexPath.row];
            cell.models = models;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        celles = cell;
    }
    else
    {
        
        WCLSignUpCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLSignUpCell"];
        NSArray * array2 = [self.viewModel.cell_data_dict arrayForKey:@"活动详情1"];
        if(array2.count>0)
        {
            WCLActivityMemberModel * models = array2[indexPath.row];
            cell.models= models;
        }
        celles= cell;
    }
    
    return celles;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"你点击了第%@行",@(indexPath.section));
}
@end
