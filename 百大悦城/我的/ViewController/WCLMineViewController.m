


//
//  WCLMineViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLMineViewController.h"
#import "WCLMineViewModel.h"
#import "WCLMineUIService.h"
@interface WCLMineViewController ()
@property (nonatomic, strong) WCLMineUIService *MineUIService;//首页UI 服务
@property (nonatomic, strong) WCLMineViewModel *viewModel;//首页UI 服务
@end

@implementation WCLMineViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:false];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:false];
    [self.MineUIService requestUserInfoData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.MineUIService = [[WCLMineUIService alloc]initWithVC:self ViewModel:self.viewModel];
    [self.MineUIService setSixBtnBlock:^(NSInteger index) {
        WCLLog(@"%@",@(index));
    }];
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
