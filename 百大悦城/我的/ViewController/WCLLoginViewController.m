//
//  WCLLoginViewController.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLLoginViewController.h"

@interface WCLLoginViewController ()

@end

@implementation WCLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#FFF5E4"].CGColor,  (__bridge id)[UIColor colorWithHexString:@"#F2E2CC"].CGColor];
    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view.layer addSublayer:gradientLayer];
    UILabel * titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"手机快捷登录";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(IsiPhoneX?54:34);
    }];
    UIImageView * backImageView = [UIImageView new];
    backImageView.image = [UIImage imageNamed:@""];
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(36);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
    }];
    UIButton * xBtn = [UIButton new];
    [xBtn setImage:[UIImage imageNamed:@"address_close"] forState:UIControlStateNormal];
    [[xBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:xBtn];
    [xBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.equalTo(titleLabel.mas_centerY);
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
