//
//  WCLShopSwitchViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/19.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopSwitchViewController.h"
#import "WCLShopSwitchViewModel.h"
@interface WCLShopSwitchViewController ()
@property(nonatomic,strong)WCLShopSwitchViewModel * viewModel;
@end

@implementation WCLShopSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商城切换";
    self.viewModel = [[WCLShopSwitchViewModel alloc]init];
    self.service = [[WCLShopSwitchUIService alloc]initWithVC:self ViewModel:self.viewModel];
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
