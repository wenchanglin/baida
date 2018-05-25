//
//  WCLActivityDetailVC.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityDetailVC.h"
#import "WCLActivityDetailViewModel.h"
#import "WCLActivityDetailUIService.h"
@interface WCLActivityDetailVC ()
@property(nonatomic,strong)WCLActivityDetailViewModel * viewModel;
@property(nonatomic,strong)WCLActivityDetailUIService* activitydetailService;
@end

@implementation WCLActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    self.viewModel = [[WCLActivityDetailViewModel alloc]init];
    self.activitydetailService = [[WCLActivityDetailUIService alloc]initWithVC:self ViewModel:self.viewModel];

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
