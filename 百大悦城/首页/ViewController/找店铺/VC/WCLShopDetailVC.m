//
//  WCLShopDetailVC.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/24.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopDetailVC.h"
#import "WCLShopDetailViewModel.h"
#import "WCLShopDetailService.h"
@interface WCLShopDetailVC ()
@property(nonatomic,strong)WCLShopDetailService * findShopService;
@property(nonatomic,strong)WCLShopDetailViewModel* viewModel;

@end

@implementation WCLShopDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺详情";
    self.viewModel = [[WCLShopDetailViewModel alloc]init];
    self.findShopService = [[WCLShopDetailService alloc]initWithVC:self ViewModel:self.viewModel];

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
