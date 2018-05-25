//
//  WCLHomeViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLHomeViewController.h"
#import "WCLHomeUIService.h"
#import "WCLHomeViewModel.h"

@interface WCLHomeViewController ()
@property (nonatomic, strong) WCLHomeUIService *homeUIService;//首页UI 服务
@property (nonatomic, strong) WCLHomeViewModel *viewModel;//首页UI 服务
@end

@implementation WCLHomeViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:false];
    //    [self.homeUIService stopTimer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    if(self.homeUIService.contentY > NAVBAR_CHANGE_POINT) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:false];
//    }else {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:false];
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
 
//    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"定位" style:UIBarButtonItemStylePlain target:self action:@selector(leftclick:)];
    self.viewModel = [[WCLHomeViewModel alloc] init];
    self.homeUIService = [[WCLHomeUIService alloc] initWithVC:self ViewModel:self.viewModel];
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:App_Notification_Version object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSDictionary *userInfo = [x userInfo];
        WCLLog(@"%@",userInfo);
    }];
   
    
}
-(void)leftclick:(UIBarButtonItem*)leftitem
{
    WCLLog(@"你点击了我");
}
- (void)showUpdateVersionView:(NSNotification *)not{
    
    
    //    YBLUpdateReaseNotModel *notModel = userInfo[@"model"];
    //    [YBLUpdateVersionView showUpdateVersionViewWithModel:notModel
    //                                               doneBlock:^{
    //                                                   NSURL *url = [NSURL URLWithString:AppOfAppstore_URL];
    //                                                   [YBLMethodTools OpenURL:url];
    //                                               }];
    
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
