//
//  WCLFindShopVC.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/21.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLFindShopVC.h"
#import "WCLFindShopService.h"
#import "WCLFindShopViewModel.h"
@interface WCLFindShopVC ()
@property(nonatomic,strong)WCLFindShopViewModel* viewModel;
@property(nonatomic,strong)WCLFindShopService * findShopService;
@end

@implementation WCLFindShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找店铺";
    self.viewModel = [[WCLFindShopViewModel alloc]init];
    self.findShopService = [[WCLFindShopService alloc]initWithVC:self ViewModel:self.viewModel];
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
