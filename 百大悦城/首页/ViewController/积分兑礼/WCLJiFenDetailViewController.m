//
//  WCLJiFenDetailViewController.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLJiFenDetailViewController.h"
#import "WCLJiFenDetailService.h"
#import "WCLJiFenDetailViewModel.h"
@interface WCLJiFenDetailViewController ()
@property(nonatomic,strong)WCLJiFenDetailService * service;
@property(nonatomic,strong)WCLJiFenDetailViewModel*viewModel;
@end

@implementation WCLJiFenDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#666666" alpha:1] frame:CGRectMake(0, 0, YBLWindowWidth, kNavigationbarHeight)] forBarMetrics:UIBarMetricsDefault];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:YBLColor(40, 40, 40, 1.0),
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSShadowAttributeName:shadow
                                                                      }];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:YBLColor(255, 255, 255, 1) frame:CGRectMake(0, 0, YBLWindowWidth, kNavigationbarHeight)] forBarMetrics:UIBarMetricsDefault];//alpha 0.99
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[WCLJiFenDetailViewModel alloc]init];
    self.service = [[WCLJiFenDetailService alloc]initWithVC:self ViewModel:self.viewModel];
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
