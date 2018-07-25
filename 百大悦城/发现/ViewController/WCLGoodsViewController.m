//
//  WCLGoodsViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLGoodsViewController.h"
#import "WCLGoodsViewModel.h"
#import "WCLGoodsUIService.h"
@interface WCLGoodsViewController ()
@property (nonatomic, strong) WCLGoodsUIService *goodsUIService;//UI 服务
@property (nonatomic, strong) WCLGoodsViewModel *viewModel;// 服务
@end

@implementation WCLGoodsViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"好物";
    self.viewModel = [[WCLGoodsViewModel alloc]init];
    self.goodsUIService = [[WCLGoodsUIService alloc]initWithVC:self ViewModel:self.viewModel];
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
