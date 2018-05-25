//
//  WCLActivityingVC.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityingVC.h"
#import "WCLActivityingViewModel.h"
#import "WCLActivityingUIService.h"
@interface WCLActivityingVC ()
@property (nonatomic, strong) WCLActivityingUIService *activityUIService;//UI 服务
@property (nonatomic, strong) WCLActivityingViewModel *viewModel;// 服务
@end

@implementation WCLActivityingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动进行时";
    self.viewModel = [[WCLActivityingViewModel alloc]init];
    self.activityUIService = [[WCLActivityingUIService alloc]initWithVC:self ViewModel:self.viewModel];
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
