//
//  WCLJiFenViewController.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLJiFenViewController.h"
#import "WCLJiFenViewModel.h"
#import "WCLJiFenService.h"
@interface WCLJiFenViewController ()
@property(nonatomic,strong)WCLJiFenService * service;
@property(nonatomic,strong)WCLJiFenViewModel * viewModel;

@end

@implementation WCLJiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分兑礼";
    self.viewModel = [[WCLJiFenViewModel alloc]init];
    self.service = [[WCLJiFenService alloc]initWithVC:self ViewModel:self.viewModel];
    
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
