//
//  WCLActivityCalendarVC.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityCalendarVC.h"
#import "WCLActivityCalendarUIService.h"
#import "WCLActivityCalendarViewModel.h"
@interface WCLActivityCalendarVC ()
@property (nonatomic, strong) WCLActivityCalendarUIService *activityUIService;//UI 服务
@property (nonatomic, strong) WCLActivityCalendarViewModel *viewModel;// 服务
@end

@implementation WCLActivityCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动日历";
    self.viewModel = [[WCLActivityCalendarViewModel alloc]init];
    self.activityUIService = [[WCLActivityCalendarUIService alloc]initWithVC:self ViewModel:self.viewModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
