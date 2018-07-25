//
//  TableViewController.m
//  SlidePageScrollView
//
//  Created by tanyang on 15/7/16.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "FatherActivityTableViewController.h"
#import "MJRefresh.h"
#import "WCLActivityModel.h"
#import "WCLActivityCell.h"
#import "WCLMineActivityViewController.h"
#import "WCLSureSignUpVC.h"
#import "WCLActivityH5VC.h"
#import <UIScrollView+EmptyDataSet.h>
@interface FatherActivityTableViewController ()
@property(nonatomic,assign)BOOL didEndDecelerating;
@property(nonatomic,strong) NSString * string1;

@end

@implementation FatherActivityTableViewController
{
    NSMutableArray * bannerArr;
    UIView *bgNoDingView;   //没有订单界面底层z
    NSInteger page;
    NSInteger cshu;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    bannerArr = [NSMutableArray array];
    page=1;
    cshu=0;
    [[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"gundong" object:nil] map:^id(NSNotification *value) {
        return value.userInfo;
    }] distinctUntilChanged] subscribeNext:^(id x) {
       self.ID =[[x stringForKey:@"gundongId"]integerValue];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.ID ==self.view.tag) {
                [self.tableView.mj_header beginRefreshing];
            }
        });
    }];
    WEAK
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"baoming" object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        STRONG
        self->page=1;
        [self->bannerArr removeAllObjects];
        [self reqestDataForID:self.ID withPageNum:self->page];
        
        
    }];
    self.tableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight=0;
    self.tableView.tableFooterView = [[UIView alloc]init];
    __typeof (self) __weak weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
            self->page=1;
            [self->bannerArr removeAllObjects];
            [self reqestDataForID:weakSelf.ID withPageNum:self->page];
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
    }];
     [self.tableView.mj_header beginRefreshing];
  
}
-(void)reqestDataForID:(NSInteger)ID withPageNum:(NSInteger)page
{
    WEAK
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tagId"] = @(ID);
    params[@"pageNum"] = @(page);
    [[wclNetTool sharedTools]request:GET urlString:URL_ActivityList parameters:params finished:^(id responseObject, NSError *error) {
        STRONG
            NSMutableArray* activityArr = [WCLActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (WCLActivityModel*models in activityArr) {
                [self->bannerArr addObject:models];
            }
            if ([responseObject[@"page"][@"pages"]integerValue]>self->page) {
                self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    // 进入刷新状态后会自动调用这个block
                    self->page +=1;
                    [self reqestDataForID:ID withPageNum:self->page];
                    [self.tableView.mj_footer endRefreshing];
                   
                }];
            }
            else if([responseObject[@"page"][@"pages"]integerValue]<=self->page)
            {
                self.tableView.mj_footer.hidden=YES;
                [self.tableView.mj_header endRefreshing];
            }
         [self.tableView reloadData];
    }];
}
//#pragma mark - 占位图
//-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIImage imageNamed:@"noactivityplace"];
//}
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
//    NSString *title = @"暂无活动";
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
//                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#A4C9EE"]
//                                 };
//    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
//}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return bannerArr.count;
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
    if (section==bannerArr.count-1) {
        return 65;
    }
    else
        return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==bannerArr.count-1) {
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
    NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString * organizeId =[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
    WCLActivityModel * models = bannerArr[indexPath.section];
    WCLActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"activitycellsf"];
    if (!cell) {
        cell = [[WCLActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activitycellsf"];
    }
    cell.models = models;
    [cell setSignblocks:^(WCLActivityModel*model) {
        if ([YBLMethodTools checkLoginWithVc:self]) {
//            WCLSureSignUpVC *svc = [[WCLSureSignUpVC alloc]init];
//            svc.activityid = [NSNumber numberWithInteger:model.marketingActivitySignupId];
//            svc.hidesBottomBarWhenPushed =YES;
//            [self.navigationController pushViewController:svc animated:YES];
            [YBLMethodTools pushWebVcFrom:self URL:[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.marketingActivitySignupId),hash,organizeId] title:model.activityTitle string:self.string1 type:@"活动详情" buystate:model.memberSignupState activityid:@(model.marketingActivitySignupId)];
        }
        
        
    }];
    [cell setBlocks:^(WCLActivityModel*model) {
         if ([YBLMethodTools checkLoginWithVc:self]) {
//             WCLMineActivityViewController * mvc = [[WCLMineActivityViewController alloc]init];
//             [self.navigationController pushViewController:mvc animated:YES];
             WCLActivityH5VC *vc = [[WCLActivityH5VC alloc]init];
             vc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId];
             vc.navTitle = models.activityTitle;
             vc.activityid = models.marketingActivitySignupId;
             vc.buyStates =models.memberSignupState;
             vc.hidesBottomBarWhenPushed=YES;
             [self.navigationController pushViewController:vc animated:YES];
         }
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCLActivityModel * model = bannerArr[indexPath.section];
    WEAK
    [RACObserve(model, acivityType)subscribeNext:^(id  _Nullable x) {
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
            self.string1 =[NSString stringWithFormat:@"%@积分报名",model.enrollScore.length>0?model.enrollScore:@"0"];
        }
        else if ([x isEqualToString:@"CASH"])
        {
            self.string1 = [NSString stringWithFormat:@"¥%@报名",model.enrollFee];
        }
    }];
   
    NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString * organizeId =[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];

        if ([model.memberSignupState isEqualToString:@"已失效"]) {
            WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
            pivc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.marketingActivitySignupId),hash,organizeId];
            pivc.navTitle = model.activityTitle;
            pivc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:pivc animated:YES];
        }
        else if ([model.memberSignupState isEqualToString:@"去报名"])
        {
            if ([self.string1 isEqualToString:@"无需报名"]) {
                WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
                pivc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.marketingActivitySignupId),hash,organizeId];
                pivc.navTitle = model.activityTitle;
                pivc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:pivc animated:YES];
            }
            else
            {
            [YBLMethodTools pushWebVcFrom:self URL:[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.marketingActivitySignupId),hash,organizeId] title:@"活动详情" string:self.string1 type:@"活动详情" buystate:model.memberSignupState activityid:@(model.marketingActivitySignupId)];
            }
        }
        else if ([model.memberSignupState isEqualToString:@"去参加"]||[model.memberSignupState isEqualToString:@"待报名"]||[model.memberSignupState isEqualToString:@"已结束"])
        {
            
            WCLActivityH5VC *vc = [[WCLActivityH5VC alloc]init];
            vc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.marketingActivitySignupId),hash,organizeId];
            vc.navTitle = model.activityTitle;
            vc.activityid = model.marketingActivitySignupId;
            vc.buyStates =model.memberSignupState;
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
