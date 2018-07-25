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
#import "WCLMineActivityViewController.h"
#import "WCLSureSignUpVC.h"
#import "WCLActivityH5VC.h"
@interface WCLActivityingUIService()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)WCLActivityingViewModel * viewModel;
@property(nonatomic,weak)WCLActivityingVC * activityingVC;
@property(nonatomic,strong)NSString * string1;

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
    [[self.viewModel activityingDataSignalWithtagId:self.activityingVC.stringID] subscribeNext:^(id  _Nullable x) {
        if (![x isKindOfClass:[NSDictionary class]]) {
            [self.activityTableView reloadData];
            [self.activityTableView.mj_header endRefreshing];
            [self createViewNoDD];
        }
        else
        {
            [bgNoDingView removeFromSuperview];
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
    [NoDD setImage:[UIImage imageNamed:@"noactivityplace"]];
    
    
    UIButton *clickToLookOther = [UIButton new];
    [bgNoDingView addSubview:clickToLookOther];
    
    clickToLookOther.sd_layout
    .centerXEqualToView(bgNoDingView)
    .topSpaceToView(NoDD, 20)
    .widthIs(80)
    .heightIs(35);
    [clickToLookOther.layer setCornerRadius:3];
    [clickToLookOther.layer setMasksToBounds:YES];
    [clickToLookOther setBackgroundColor:[UIColor colorWithHexString:@"#A4C9EE"]];
    [clickToLookOther.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [clickToLookOther setTitle:@"暂无活动" forState:UIControlStateNormal];
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
    NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString * organizeId =[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
    WCLActivityModel * models = array1[indexPath.section];
    WCLActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"activityingcell"];
    if (!cell) {
        cell = [[WCLActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activitycellsf"];
    }
    [cell setSignblocks:^(WCLActivityModel*model) {
        if ([YBLMethodTools checkLoginWithVc:self.activityingVC]) {
            if ([models.memberSignupState isEqualToString:@"去参加"]||[models.memberSignupState isEqualToString:@"待报名"]||[models.memberSignupState isEqualToString:@"已结束"])
            {
                WCLActivityH5VC *vc = [[WCLActivityH5VC alloc]init];
                vc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId];
                vc.navTitle = models.activityTitle;
                vc.activityid = models.marketingActivitySignupId;
                vc.buyStates =models.memberSignupState;
                vc.hidesBottomBarWhenPushed=YES;
                [self.activityingVC.navigationController pushViewController:vc animated:YES];
            }
            else if ([models.memberSignupState isEqualToString:@"去报名"])
            {
            [YBLMethodTools pushWebVcFrom:self.activityingVC URL:[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&orgainzeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId] title:models.activityTitle string:self.string1 type:@"活动详情" buystate:models.memberSignupState activityid:@(models.marketingActivitySignupId)];
            }
        }
        
    }];
    [cell setBlocks:^(WCLActivityModel*model) {
        if ([YBLMethodTools checkLoginWithVc:self.activityingVC]) {
//            WCLMineActivityViewController * hx = [[WCLMineActivityViewController alloc]init];
//            hx.hidesBottomBarWhenPushed =YES;
//            [self.activityingVC.navigationController pushViewController:hx animated:YES];
            WCLActivityH5VC *vc = [[WCLActivityH5VC alloc]init];
            vc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId];
            vc.navTitle = models.activityTitle;
            vc.activityid = models.marketingActivitySignupId;
            vc.buyStates =models.memberSignupState;
            vc.hidesBottomBarWhenPushed=YES;
            [self.activityingVC.navigationController pushViewController:vc animated:YES];
        }
    }];
    cell.models = models;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"活动进行时"];
    WEAK
    WCLActivityModel * models = array1[indexPath.section];
    [RACObserve(models, acivityType)subscribeNext:^(id  _Nullable x) {
        STRONG
        if ([x isEqualToString:@"NONEED"]) {
            self.string1 = @"无需报名";
        }
        else if ([x isEqualToString:@"FREE"])
        {
            self.string1 = @"免费";
        }
        else if ([x isEqualToString:@"SCORE"])
        {
            self.string1 =[NSString stringWithFormat:@"%@积分报名",models.enrollScore.length>0?models.enrollScore:@"0"];
        }
        else if ([x isEqualToString:@"CASH"])
        {
            self.string1 = [NSString stringWithFormat:@"¥%@报名",models.enrollFee];
        }
    }];
    NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString* organizeId = [[NSUserDefaults standardUserDefaults]objectForKey:@"orgainzeId"];
        if ([models.memberSignupState isEqualToString:@"已失效"]) {
            WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
            pivc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&orgainzeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId];
            pivc.navTitle = models.activityTitle;
            pivc.hidesBottomBarWhenPushed =YES;
            [self.activityingVC.navigationController pushViewController:pivc animated:YES];
        }
        else if ([models.memberSignupState isEqualToString:@"去报名"])
        {
            
            if ([self.string1 isEqualToString:@"无需报名"]) {
                WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
                pivc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&orgainzeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId];
                pivc.navTitle = models.activityTitle;
                pivc.hidesBottomBarWhenPushed =YES;
                [self.activityingVC.navigationController pushViewController:pivc animated:YES];
            }
            else
            {
                 [YBLMethodTools pushWebVcFrom:self.activityingVC URL:[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&orgainzeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId] title:models.activityTitle string:self.string1 type:@"活动详情" buystate:models.memberSignupState activityid:@(models.marketingActivitySignupId)];
            }
           
        }
        else if ([models.memberSignupState isEqualToString:@"去参加"]||[models.memberSignupState isEqualToString:@"待报名"]||[models.memberSignupState isEqualToString:@"已结束"])
        {
            WCLActivityH5VC *vc = [[WCLActivityH5VC alloc]init];
            vc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId];
            vc.navTitle = models.activityTitle;
            vc.activityid = models.marketingActivitySignupId;
            vc.buyStates =models.memberSignupState;
            vc.hidesBottomBarWhenPushed=YES;
            [self.activityingVC.navigationController pushViewController:vc animated:YES];
        }
}
@end
