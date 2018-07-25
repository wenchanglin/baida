


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
#import "WCLMineActivityViewController.h"
#import "WCLMemberCodeVC.h"
#import "WCLTicketViewController.h"
#import "WCLMineExchangeViewController.h"
#import "WCLMineOrderViewController.h"
@interface WCLMineViewController ()
@property (nonatomic, strong) WCLMineUIService *MineUIService;//首页UI 服务
@property (nonatomic, strong) WCLMineViewModel *viewModel;//首页UI 服务
@end

@implementation WCLMineViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.MineUIService requestUserInfoData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.viewModel = [[WCLMineViewModel alloc]init];
    self.MineUIService = [[WCLMineUIService alloc]initWithVC:self ViewModel:self.viewModel];
    WEAK
    [self.MineUIService setSixBtnBlock:^(NSInteger index) {
        STRONG
        if ([YBLMethodTools checkLoginWithVc:self] ) {
        switch (index) {
            case 0:
            {
                WCLMemberCodeVC * cvc = [[WCLMemberCodeVC alloc]init];
                cvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:cvc animated:YES];
            }
                break;
            case 1:
            {
                WCLTicketViewController * tvc =[[WCLTicketViewController alloc]init];
                tvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:tvc animated:YES];
            }break;
            case 2:
            {
                WCLMineOrderViewController *ovC = [[WCLMineOrderViewController alloc]init];
                ovC.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:ovC animated:YES];
            }
                break;
            case 3:
            {
                WCLMineExchangeViewController *tvc = [[WCLMineExchangeViewController alloc]init];
                tvc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:tvc animated:YES];
            }break;
            case 4:
                {
                    WCLMineActivityViewController * avc =[[WCLMineActivityViewController alloc]init];
                    avc.hidesBottomBarWhenPushed =YES;
                    [self.navigationController pushViewController:avc animated:YES];
                }
                break;
            case 5:
            {}break;
            default:
                break;
            }
        }
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
