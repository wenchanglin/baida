//
//  WCLMainScanViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/19.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLMainScanViewController.h"

@interface WCLMainScanViewController ()

@end

@implementation WCLMainScanViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FFFFFF"],
                                            NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18],
                                            NSShadowAttributeName:shadow
                                            }];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#BF0000"] frame:CGRectMake(0, 0, YBLWindowWidth, kNavigationbarHeight)] forBarMetrics:UIBarMetricsDefault];
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
    self.title = @"电子会员卡";
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-88-84-49)];
    view1.backgroundColor = [UIColor cyanColor];
    view1.alpha=1;
    [self.view addSubview:view1];
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-88-84-49)];
    view2.backgroundColor = [UIColor magentaColor];
    view2.alpha=0;
    [self.view addSubview:view2];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(50,SCREEN_HEIGHT-88-84-49, 50, 49)];
    [self.view addSubview:btn];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];

    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected=!x.selected;
        view2.alpha=0;
        view1.alpha=1;
    }];
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(120, SCREEN_HEIGHT-88-84-49, 50, 49)];
    [btn2 setTitle:@"测试2" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected=!x.selected;
        view1.alpha=0;
        view2.alpha=1;
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
