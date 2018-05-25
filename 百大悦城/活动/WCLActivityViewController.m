//
//  WCLActivityViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityViewController.h"
#import "WCLActivityViewModel.h"
#import "WCLActivityUIService.h"
@interface WCLActivityViewController ()
@property (nonatomic, strong) WCLActivityUIService *homeUIService;//UI 服务
@property (nonatomic, strong) WCLActivityViewModel *viewModel;// 服务
@end

@implementation WCLActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动";
    self.viewModel = [[WCLActivityViewModel alloc]init];
    self.homeUIService = [[WCLActivityUIService alloc]initWithVC:self ViewModel:self.viewModel];
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
