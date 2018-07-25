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
#import "YBLUpdateVersionView.h"

@interface WCLHomeViewController ()
@property (nonatomic, strong) WCLHomeUIService *homeUIService;//首页UI 服务
@property (nonatomic, strong) WCLHomeViewModel *viewModel;//首页UI 服务
@end

@implementation WCLHomeViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:false];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];    
    self.viewModel = [[WCLHomeViewModel alloc] init];
    self.homeUIService = [[WCLHomeUIService alloc] initWithVC:self ViewModel:self.viewModel];
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:App_Notification_Version object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSDictionary *userInfo = [x userInfo];
        YBLUpdateReaseNotModel *notModel = userInfo[@"model"];
        [YBLUpdateVersionView showUpdateVersionViewWithModel:notModel
        doneBlock:^{
                NSURL *url = [NSURL URLWithString:AppOfAppstore_URL];
                [YBLMethodTools OpenURL:url];
        }];
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
