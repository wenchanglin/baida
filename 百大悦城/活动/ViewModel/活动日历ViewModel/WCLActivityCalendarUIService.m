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
#import "WCLActivityDetailVC.h"
@interface WCLActivityCalendarUIService()<LTSCalendarEventSource>
@property(nonatomic,weak)WCLActivityCalendarViewModel * viewModel;
@property(nonatomic,weak)WCLActivityCalendarVC * activityCalendarVC;
@end
@implementation WCLActivityCalendarUIService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _viewModel = (WCLActivityCalendarViewModel*)viewModel;
        _activityCalendarVC  =(WCLActivityCalendarVC*)VC;
//        [_activityingVC.view addSubview:self.activityTableView];
        [self lts_InitUI];
        [self requstdata];

    }
    return self;
}
-(void)requstdata
{
    [self.viewModel.activityCalendarDataSignal subscribeNext:^(id  _Nullable x) {
        //        if ([x intValue]==0) {
        //            [self createViewNoDD];
        //        }
        //        else
        //        {
//        [self.activityTableView.mj_header endRefreshing];
//        [self.activityTableView reloadData];
        //        }
    }];
}
- (void)lts_InitUI{
    self.manager = [LTSCalendarManager new];
    self.manager.eventSource = self;
    [LTSCalendarAppearance share].isShowLunarCalender = NO;//默认显示日历
    self.manager.weekDayView = [[LTSCalendarWeekDayView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [self.activityCalendarVC.view addSubview:self.manager.weekDayView];
    self.manager.calenderScrollView = [[LTSCalendarScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.manager.weekDayView.frame), CGRectGetWidth(self.activityCalendarVC.view.frame), IsiPhoneX? CGRectGetHeight(self.activityCalendarVC.view.frame)-CGRectGetMaxY(self.manager.weekDayView.frame)-98:CGRectGetHeight(self.activityCalendarVC.view.frame)-CGRectGetMaxY(self.manager.weekDayView.frame)-74)];
    [self.activityCalendarVC.view addSubview:self.manager.calenderScrollView];
    WEAK
    [self.manager.calenderScrollView setDidselectBlock:^(NSInteger activityid) {
        STRONG
        WCLActivityDetailVC * wdvc = [[WCLActivityDetailVC alloc]init];
        wdvc.activityID = activityid;
        [self.activityCalendarVC.navigationController pushViewController:wdvc animated:YES];
    }];
    self.activityCalendarVC.automaticallyAdjustsScrollViewInsets = false;
}
- (BOOL)calendarHaveEventWithDate:(NSDate *)date
{
    
    return YES;//是否有点击事件
}

/**
 点击 日期后的执行的操作
 @param date 选中的日期
 */
- (void)calendarDidSelectedDate:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    self.activityCalendarVC.title = key;
    [self.manager.calenderScrollView requstdata];
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
    }
    
    return dateFormatter;
}

/**
 翻页完成后的操作
 
 */
//- (void)calendarDidLoadPageCurrentDate:(NSDate *)date;
@end
