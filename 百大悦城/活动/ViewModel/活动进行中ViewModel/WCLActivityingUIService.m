//
//  WCLActivityingUIService.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityingUIService.h"
#import "WCLActivityingVC.h"
#import "WCLActivityingViewModel.h"
#import "WCLActivityModel.h"
#import "WCLActivityCell.h"
#import "WCLActivityDetailVC.h"
@interface WCLActivityingUIService()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)WCLActivityingViewModel * viewModel;
@property(nonatomic,weak)WCLActivityingVC * activityingVC;
@end
@implementation WCLActivityingUIService
{
    UIView * bgNoDingView;
}
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _viewModel = (WCLActivityingViewModel*)viewModel;
        _activityingVC  =(WCLActivityingVC*)VC;
        [_activityingVC.view addSubview:self.activityTableView];
        [self requstdata];
    }
    return self;
}
-(void)requstdata
{
    [self.viewModel.activityingDataSignal subscribeNext:^(id  _Nullable x) {
        if (![x isKindOfClass:[NSDictionary class]]) {
            [self createViewNoDD];
        }
        else
        {
            [self.activityTableView.mj_header endRefreshing];
            [self.activityTableView reloadData];
        }
    }];
}
-(UITableView *)activityTableView
{
    if (!_activityTableView) {
        
        _activityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-84:SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _activityTableView.delegate = self;
        _activityTableView.dataSource = self;
        self.activityTableView.estimatedSectionHeaderHeight = 0;
        self.activityTableView.estimatedSectionFooterHeight=0;
        [_activityTableView registerClass:[WCLActivityCell class] forCellReuseIdentifier:@"activityingcell"];
//        [_activityTableView registerClass:[WCLHomeCouPonCell class] forCellReuseIdentifier:@"WCLHomeCouPonCell"];
//        [_activityTableView registerClass:[WCLHomeGiftCell class] forCellReuseIdentifier:@"GiftCell"];
        //        [_homeTableView registerClass:[WCLHomeActivityCell class] forCellReuseIdentifier:@"activitycells"];
        [_activityTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_activityTableView setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED"]];
        WEAK
        //        [YBLMethodTools footerAutoRefreshWithTableView:_homeTableView completion:^{
        //            STRONG
        //            [self loadCommandMore];
        //        }];
        [YBLMethodTools headerRefreshWithTableView:_activityTableView completion:^{
            STRONG
            [self requstdata];
        }];
    }
    return _activityTableView;
}
-(void)createViewNoDD    // 创建没有订单界面
{
    bgNoDingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - 41 - 64)];
    [bgNoDingView setBackgroundColor:[UIColor whiteColor]];
    [self.activityingVC.view addSubview:bgNoDingView];
    
    UIImageView *NoDD = [UIImageView new];
    [bgNoDingView addSubview:NoDD];
    NoDD.sd_layout
    .centerXEqualToView(bgNoDingView)
    .topSpaceToView(bgNoDingView, 120)
    .widthIs(211)
    .heightIs(220);
    [NoDD setImage:[UIImage imageNamed:@"HaveNoOrder"]];
    
    
    UIButton *clickToLookOther = [UIButton new];
    [bgNoDingView addSubview:clickToLookOther];
    
    clickToLookOther.sd_layout
    .centerXEqualToView(bgNoDingView)
    .topSpaceToView(NoDD, 20)
    .widthIs(80)
    .heightIs(35);
    [clickToLookOther.layer setCornerRadius:3];
    [clickToLookOther.layer setMasksToBounds:YES];
    [clickToLookOther setBackgroundColor:[UIColor blackColor]];
    [clickToLookOther.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [clickToLookOther setTitle:@"去逛逛" forState:UIControlStateNormal];
    //    [clickToLookOther addTarget:self action:@selector(goToLookClothes) forControlEvents:UIControlEventTouchUpInside];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel.cell_data_dict[@"活动进行时"] count] ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 301;
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
    if (section==[self.viewModel.cell_data_dict[@"活动进行时"]count]-1) {
        return 65;
    }
    else
        return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==[self.viewModel.cell_data_dict[@"活动进行时"]count]-1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        UILabel * couponLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 25, 200, 30)];
        couponLabel.textAlignment = NSTextAlignmentCenter;
        couponLabel.text = @"-我是有底线的-";
        couponLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        couponLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [view addSubview:couponLabel];
        return view;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"活动进行时"];

    WCLActivityModel * models = array1[indexPath.section];
    WCLActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"activityingcell"];
    if (!cell) {
        cell = [[WCLActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activitycellsf"];
    }
    cell.models = models;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"你点击了第%@行",@(indexPath.section));
    NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"活动进行时"];
    
    WCLActivityModel * models = array1[indexPath.section];
    WCLActivityDetailVC *  dvc = [[WCLActivityDetailVC alloc]init];
    dvc.activityID =models.marketingActivitySignupId;
    [self.activityingVC.navigationController pushViewController:dvc animated:YES];
}
@end
