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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    UIColor *topleftColor = [UIColor colorWithHexString:@"#FFE9C0"];
    UIColor *bottomrightColor = [UIColor colorWithHexString:@"#E0BE8D"];
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeLeftToRight imgSize:self.navigationController.navigationBar.size];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#101010"],
                                                        NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18],
                                                                      NSShadowAttributeName:shadow
                                                                      }];
    [self.navigationController.navigationBar setBackgroundImage:bgImg forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
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
