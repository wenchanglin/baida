//
//  WCLFoodViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLFoodViewController.h"

@interface WCLFoodViewController ()

@end

@implementation WCLFoodViewController
{
    UIView *bgNoDingView;   //没有订单界面底层

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewNoDD];
}
-(void)createViewNoDD    // 创建没有订单界面
{
    
    UIImageView *NoDD = [UIImageView new];
    NoDD.contentMode =UIViewContentModeScaleAspectFill;
    NoDD.clipsToBounds = YES;
    [NoDD setImage:[UIImage imageNamed:@"icon_big_placeholder"]];
    [self.view addSubview:NoDD];
    [NoDD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UILabel * label1 = [UILabel new];
    label1.text = @"敬请期待…";
    label1.textColor = [UIColor colorWithHexString:@"#A4C9EE"];
    label1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:25];
    [NoDD addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(81);
        make.centerX.equalTo(self.view.mas_centerX);
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
