//
//  WCLActivityCalendarUIService.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityCalendarUIService.h"
#import "WCLActivityCalendarVC.h"
#import "WCLActivityCalendarViewModel.h"
#import "WCLMineActivityViewController.h"
#import "WCLSureSignUpVC.h"
#import "WCLActivityH5VC.h"
#import "YXCalendarView.h"
#import "WCLActivityCell.h"
@interface WCLActivityCalendarUIService()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)WCLActivityCalendarViewModel * viewModel;
@property(nonatomic,weak)WCLActivityCalendarVC * activityCalendarVC;
@property(nonatomic,strong)NSString * string1;//代理LTSCalendarEventSource
@property (nonatomic, strong) YXCalendarView *calendar;
@property(nonatomic,strong)NSMutableArray * activityArr;
@property(nonatomic,assign)NSInteger pages;
@property (nonatomic, strong) UITableView *tableView;
//获取投资日历的高度
@property (nonatomic, assign) CGFloat calendarHeight;
@end
@implementation WCLActivityCalendarUIService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _viewModel = (WCLActivityCalendarViewModel*)viewModel;
        _activityCalendarVC  =(WCLActivityCalendarVC*)VC;
        _activityArr = [NSMutableArray array];
        self.pages=1;
        [self.activityCalendarVC.view addSubview:self.calendar];
        //加载每日日历内容
        [self.activityCalendarVC.view addSubview:self.tableView];
        self.tableView.frame = CGRectMake(0, 0+self.calendarHeight, [UIScreen mainScreen].bounds.size.width,IsiPhoneX?[UIScreen mainScreen].bounds.size.height-88-self.calendarHeight:[UIScreen mainScreen].bounds.size.height-64-self.calendarHeight);
        [self serviceDataByData:[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:[NSDate date]]];
    }
    return self;
}
-(void)requstdata:(NSString*)tagid time:(NSString*)time
{
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tagId"] = tagid;
    params[@"activityTime"] = time;
    WEAK
    [[wclNetTool sharedTools]request:POST urlString:URL_ActivityList parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        self.activityArr = [WCLActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        //        WCLLog(@"%d",[responseObject[@"page"][@"pages"] integerValue]);
        if ([responseObject[@"page"][@"pages"] integerValue]>self.pages) {
            [YBLMethodTools footerRefreshWithTableView:self.tableView completion:^{
                STRONG
                self.pages +=1;
                [self requstdata:tagid time:time page:self.pages];
            }];
        }
        else if([responseObject[@"page"][@"pages"] integerValue]<=self.pages)
        {
            self.tableView.mj_footer.hidden=YES;
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
    }];
}
-(void)requstdata:(NSString *)tagid time:(NSString *)time page:(NSInteger)page
{
    [SVProgressHUD showWithStatus:@"加载中"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"tagId"] = tagid;
    params[@"activityTime"] = time;
    params[@"pageNum"] = @(page);
    WEAK
    [[wclNetTool sharedTools]request:POST urlString:URL_ActivityList parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        NSMutableArray* activtiyarr = [WCLActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (WCLActivityModel*models in activtiyarr) {
            [self.activityArr addObject:models];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        STRONG
        if ([responseObject[@"page"][@"pages"] integerValue]>self.pages) {
            [YBLMethodTools footerRefreshWithTableView:self.tableView completion:^{
                STRONG
                self.pages +=1;
                [self requstdata:tagid time:time page:self.pages];
            }];
        }
        else if([responseObject[@"page"][@"pages"] integerValue]<=self.pages)
        {
            self.tableView.mj_footer.hidden=YES;
            [self.tableView reloadData];
        }
    }];
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.userInteractionEnabled = YES;
        [_tableView registerClass:[WCLActivityCell class] forCellReuseIdentifier:@"calendarcells"];

        
    }
    return _tableView;
}
/**
 *  日历的懒加载
 */
- (YXCalendarView *)calendar{
    if(!_calendar){
        _calendar = [[YXCalendarView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [YXCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month]) Date:[NSDate date] Type:CalendarType_Month];
        self.calendarHeight = [YXCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month];
        __weak typeof (self) WeakSelf = self;
        //改变日历头部和tableView 的cell位置
        [self changeLocation];
        //点击日历某一个日期  进行数据刷新
        _calendar.sendSelectDate = ^(NSDate *selDate) {
            [WeakSelf serviceDataByData:[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]];
            
        };
    }
    return _calendar;
}
//请求数据
- (void)serviceDataByData:(NSString *)data{
    //    self.data = @"1";
//    NSLog(@"%@",data);
    [self requstdata:self.activityCalendarVC.stringID time:data];
    [self.tableView reloadData];
}
- (void)changeLocation{
    __weak typeof(_calendar) weakCalendar = _calendar;
    __weak typeof (self) WeakSelf = self;
    _calendar.refreshH = ^(CGFloat viewH) {
        WeakSelf.calendarHeight = viewH;
        [UIView animateWithDuration:0.3 animations:^{
            weakCalendar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, viewH);
            WeakSelf.tableView.frame = CGRectMake(0, 0+viewH, [UIScreen mainScreen].bounds.size.width,IsiPhoneX?[UIScreen mainScreen].bounds.size.height-88-viewH:[UIScreen mainScreen].bounds.size.height-64-viewH);
        }];
    };
}
/**
 *  通过监听tableViewcell的偏移量 从而判断tableView的头部应该收缩或者伸展
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 0) {
        NSNotification *notifi = [[NSNotification alloc] initWithName:@"changeHeaderHeightToLow" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notifi];
    }else if(scrollView.contentOffset.y < 0){
        NSNotification *notifi = [[NSNotification alloc] initWithName:@"changeHeaderHeightToHeigh" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notifi];
    }
}

#pragma mark - cellForRowAtIndexPath
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.activityArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 301;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==self.activityArr.count-1) {
        return 65;
    }
    else
        return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WCLActivityModel * models = self.activityArr[indexPath.row];
    
    WCLActivityCell *cell =[tableView dequeueReusableCellWithIdentifier:@"calendarcells"];
    cell.models = models;
    NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString* organizeId = [[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
    WEAK
    [cell setBlocks:^(WCLActivityModel*model) {
        STRONG
        if ([YBLMethodTools checkLoginWithVc:self.activityCalendarVC]) {
            WCLActivityH5VC *vc = [[WCLActivityH5VC alloc]init];
            vc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.marketingActivitySignupId),hash,organizeId];
            vc.navTitle = model.activityTitle;
            vc.activityid = model.marketingActivitySignupId;
            vc.buyStates =model.memberSignupState;
            vc.hidesBottomBarWhenPushed=YES;
            [self.activityCalendarVC.navigationController pushViewController:vc animated:YES];
        }
    }];
    [cell setSignblocks:^(WCLActivityModel*model) {
        STRONG
        if ([YBLMethodTools checkLoginWithVc:self.activityCalendarVC]) {
            [YBLMethodTools pushWebVcFrom:self.activityCalendarVC URL:[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.marketingActivitySignupId),hash,organizeId] title:model.activityTitle string:self.string1 type:@"活动详情" buystate:model.memberSignupState activityid:@(model.marketingActivitySignupId)];
        }
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    WCLLog(@"%@",@(indexPath.row));
    NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString* organizeId = [[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
    WCLActivityModel * models = self.activityArr[indexPath.row];
    [RACObserve(models, acivityType)subscribeNext:^(id  _Nullable x) {
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
    
    if ([models.memberSignupState isEqualToString:@"已失效"]) {
        WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
        pivc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId];
        pivc.navTitle = models.activityTitle;
        pivc.hidesBottomBarWhenPushed =YES;
        [self.activityCalendarVC.navigationController pushViewController:pivc animated:YES];
    }
    else if ([models.memberSignupState isEqualToString:@"去报名"])
    {
        if ([self.string1 isEqualToString:@"无需报名"]) {
            WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
            pivc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId];
            pivc.navTitle = models.activityTitle;
            pivc.hidesBottomBarWhenPushed =YES;
            [self.activityCalendarVC.navigationController pushViewController:pivc animated:YES];
        }
        else
        {
            [YBLMethodTools pushWebVcFrom:self.activityCalendarVC URL:[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId] title:models.activityTitle string:self.string1 type:@"活动详情" buystate:models.memberSignupState activityid:@(models.marketingActivitySignupId)];
        }
        
        
    }
    else if ([models.memberSignupState isEqualToString:@"去参加"]||[models.memberSignupState isEqualToString:@"已报名"]||[models.memberSignupState isEqualToString:@"已结束"]||[models.memberSignupState isEqualToString:@"待报名"])
    {
        WCLActivityH5VC *vc = [[WCLActivityH5VC alloc]init];
        vc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.marketingActivitySignupId),hash,organizeId];
        vc.navTitle = models.activityTitle;
        vc.activityid = models.marketingActivitySignupId;
        vc.buyStates =models.memberSignupState;
        vc.hidesBottomBarWhenPushed=YES;
        [self.activityCalendarVC.navigationController pushViewController:vc animated:YES];
    }
}

@end
