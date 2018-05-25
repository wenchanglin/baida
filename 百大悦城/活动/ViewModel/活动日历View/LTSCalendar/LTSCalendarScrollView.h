//
//  LTSCalendarScrollView.h
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/13.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSCalendarContentView.h"
#import "LTSCalendarWeekDayView.h"
typedef void(^didSelectBlock)(NSInteger activityid);
@interface LTSCalendarScrollView : UIScrollView
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LTSCalendarContentView *calendarView;
-(void)requstdata;
@property (nonatomic,strong)UIColor *bgColor;
- (void)scrollToSingleWeek;
@property(nonatomic,copy)didSelectBlock didselectBlock;
- (void)scrollToAllWeek;
@end
