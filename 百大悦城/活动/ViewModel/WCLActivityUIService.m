//
//  WCLActivityUIService.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/17.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityUIService.h"
#import "WCLActivityViewModel.h"
#import "WCLActivityViewController.h"
#import "WCLHomeActivityCell.h"
#import "activityAndCalendarCell.h"
#import "TYSlidePageScrollView.h"
#import "TYTitlePageTabBar.h"
#import "FatherActivityTableViewController.h"
#import "WCLTagListModel.h"
#import "WCLActivityingVC.h"
#import "WCLActivityCalendarVC.h"
#import "WCLShopSwitchModel.h"
@interface WCLActivityUIService()<TYSlidePageScrollViewDataSource,TYSlidePageScrollViewDelegate>
@property(nonatomic,weak)WCLActivityViewModel * viewModel;
@property(nonatomic,weak)WCLActivityViewController * activityVC;
@property (nonatomic, weak) TYSlidePageScrollView *slidePageScrollView;
@property(nonatomic,assign)BOOL didEndDecelerating;
@property(nonatomic,strong)UIButton* activityImageView;
@property(nonatomic,strong)UILabel * activityDescLabel;
@property(nonatomic,strong)UIButton* calendarImageView;
@property(nonatomic,strong)UILabel * calendarDescLabel;
@property(nonatomic,strong)NSString * jiluID;
@end
@implementation WCLActivityUIService
{
    NSArray * array1;
}
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _viewModel = (WCLActivityViewModel*)viewModel;
        _activityVC = (WCLActivityViewController*)VC;
        _activityVC.view.backgroundColor = [UIColor whiteColor];
        self.activityVC.view.backgroundColor = [UIColor whiteColor];
        [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"clickHomeActivity" object:nil]subscribeNext:^(NSNotification * _Nullable x) {
            if ([self.activityVC.childViewControllers count]!=0) {
                [self.activityVC.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj removeFromParentViewController];
                }];
            }
            [self.viewModel.tagListArr removeAllObjects];
            [self.viewModel.tagIdArr removeAllObjects];
            [self.viewModel.cell_data_dict removeAllObjects];
            if (self.slidePageScrollView) {
                self.slidePageScrollView.hidden=YES;
                [self.slidePageScrollView removeFromSuperview];
            }
            [self.slidePageScrollView.pageTabBar removeFromSuperview];
            [self addSlidePageScrollView];
            [self addHeaderView];
            [self requestActivityData];
          
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"baoming1" object:nil];
            
        }];
        [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"changeCity" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            WCLShopSwitchListModel * model = (WCLShopSwitchListModel*)[x.userInfo objectForKey:@"key"];
            [[NSUserDefaults standardUserDefaults]setObject:@(model.organizeId) forKey:@"organizeId"];
            if ([self.activityVC.childViewControllers count]!=0) {
                [self.activityVC.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj removeFromParentViewController];
                }];
            }
            [self.viewModel.tagListArr removeAllObjects];
            [self.viewModel.tagIdArr removeAllObjects];
            [self.viewModel.cell_data_dict removeAllObjects];
            if (self.slidePageScrollView) {
                self.slidePageScrollView.hidden=YES;
                [self.slidePageScrollView removeFromSuperview];
            }
            [self.slidePageScrollView.pageTabBar removeFromSuperview];
            [self addSlidePageScrollView];
            [self addHeaderView];
            [self requestActivityData];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"baoming1" object:nil];
        }];
        [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"clickBtn" object:nil]throttle:1] subscribeNext:^(NSNotification * _Nullable x) {
           NSInteger index1 =[[x.userInfo objectForKey:@"clickindex"] integerValue];
            if (array1.count>0) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"gundong" object:nil userInfo:@{@"gundongId": array1[index1]}];
            }
        }];
       
        [self requestActivityData];
        [self addSlidePageScrollView];
        [self addHeaderView];
//        [_slidePageScrollView reloadData];
    }
    return self;
}
-(void)requestActivityData
{
    WEAK
    [self.viewModel.activityDataSignal subscribeNext:^(id  _Nullable x) {
        STRONG
//        WCLLog(@"%@",x);
        [self.activityTableView.mj_header endRefreshing];
        [self addTabPageMenu];
        [self addVC];

        [self.slidePageScrollView reloadData];
    }];
}
- (void)addSlidePageScrollView
{
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-88-84:SCREEN_HEIGHT-49-64)];
    slidePageScrollView.pageTabBarIsStopOnTop = YES;
    slidePageScrollView.dataSource = self;
    slidePageScrollView.delegate =self;
    [self.activityVC.view addSubview:slidePageScrollView];
    _slidePageScrollView = slidePageScrollView;
}
- (void)addHeaderView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 130)];
    imageView.userInteractionEnabled=YES;
    _activityImageView = [UIButton new];
    _activityImageView.userInteractionEnabled= YES;
    _activityImageView.layer.cornerRadius=8;
    _activityImageView.contentMode = UIViewContentModeScaleAspectFill;
    _activityImageView.layer.masksToBounds=YES;
    WEAK
    [[_activityImageView rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        if (self.jiluID.length>0) {
             WCLActivityingVC * avc = [[WCLActivityingVC alloc]init];
            avc.stringID = self.jiluID;
            [self.activityVC.navigationController pushViewController:avc animated:YES];
        }
        else
        {
            self.jiluID = @"0";
            WCLActivityingVC * avc = [[WCLActivityingVC alloc]init];
            avc.stringID = self.jiluID;
            [self.activityVC.navigationController pushViewController:avc animated:YES];
        }
       
        
    }];
    [_activityImageView setImage:[UIImage imageNamed:@"home_icon_bedoing"] forState:UIControlStateNormal];
    [imageView addSubview:_activityImageView];
    [_activityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.mas_equalTo(12);
        make.height.mas_equalTo(96);
        make.right.mas_equalTo(-SCREEN_WIDTH/2-12);
    }];
    _activityDescLabel = [UILabel new];
    _activityDescLabel.textAlignment = NSTextAlignmentCenter;
    _activityDescLabel.text = @"发现进行中的活动";
    _activityDescLabel.font = [UIFont systemFontOfSize:12];
    _activityDescLabel.textColor = [UIColor colorWithHexString:@"#BF914D"];
    [_activityImageView addSubview:_activityDescLabel];
    [_activityDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.activityImageView.mas_bottom).offset(-26);
        //        make.left.equalTo(self.activityImageView.mas_left).offset(60);
        make.right.equalTo(self.activityImageView.mas_right).offset(-14);
        make.height.mas_equalTo(17);
    }];
    _calendarImageView = [UIButton new];
    _calendarImageView.layer.cornerRadius=8;
    _calendarImageView.layer.masksToBounds=YES;
    [[_calendarImageView rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        if (self.jiluID.length>0) {
            WCLActivityCalendarVC * avc = [[WCLActivityCalendarVC alloc]init];
            avc.stringID = self.jiluID;
            [self.activityVC.navigationController pushViewController:avc animated:YES];
        }
        else
        {
            self.jiluID = @"0";
            WCLActivityCalendarVC * avc = [[WCLActivityCalendarVC alloc]init];
            avc.stringID = self.jiluID;
            [self.activityVC.navigationController pushViewController:avc animated:YES];
        }
       
    }];
    [_calendarImageView setImage: [UIImage imageNamed:@"home_icon_calendar"]  forState:UIControlStateNormal];
    [imageView addSubview:_calendarImageView];
    [_calendarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.height.mas_equalTo(96);
        make.right.mas_equalTo(-12);
        make.left.equalTo(self.activityImageView.mas_right).offset(11);
    }];
    _calendarDescLabel = [UILabel new];
    _calendarDescLabel.textAlignment = NSTextAlignmentCenter;
    _calendarDescLabel.text = @"查看每月精彩活动";
    _calendarDescLabel.font = [UIFont systemFontOfSize:12];
    _calendarDescLabel.textColor = [UIColor colorWithHexString:@"#BF694D"];
    [_calendarImageView addSubview:_calendarDescLabel];
    [_calendarDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.activityImageView.mas_bottom).offset(-26);
        //        make.left.equalTo(self.calendarImageView.mas_left).offset(60);
        make.right.equalTo(self.calendarImageView.mas_right).offset(-14);
        make.height.mas_equalTo(17);
    }];
    UIView * view1 = [UIView new];
    view1.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    [imageView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imageView);
        make.top.equalTo(self.calendarImageView.mas_bottom).offset(12);
        make.height.mas_equalTo(10);
    }];
    _slidePageScrollView.headerView = imageView;
}
- (void)addTabPageMenu
{
    NSArray * array = [self.viewModel.cell_data_dict arrayForKey:@"活动标签"];
    if (array.count>0) {
        TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:array];
        titlePageTabBar.frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 64);
        titlePageTabBar.backgroundColor = [UIColor whiteColor];
        titlePageTabBar.titleSpacing =20;
        _slidePageScrollView.pageTabBar = titlePageTabBar;
    }
   
}
-(void)addVC{
    array1 = [self.viewModel.cell_data_dict arrayForKey:@"活动标签ID"];
    if(array1.count>0)
    {
       for (NSNumber* ID in array1) {
        FatherActivityTableViewController *tableViewVC = [[FatherActivityTableViewController alloc]init];
        tableViewVC.itemNum = 1;
        tableViewVC.ID = [ID integerValue];
        tableViewVC.view.tag = [ID integerValue];
        // don't forget addChildViewController
        [self.activityVC addChildViewController:tableViewVC];
        }
       
    }
    
}
#pragma mark - dataSource

- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.activityVC.childViewControllers.count;
}
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index
{
    if (array1.count>index) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"gundong" object:nil userInfo:@{@"gundongId": array1[index]}];
        self.jiluID = array1[index];
        
    }
//    WCLLog(@"滑动的%d",index);
}
- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    FatherActivityTableViewController *tableViewVC = self.activityVC.childViewControllers[index];
    return tableViewVC.tableView;
}
@end
