//
//  WCLMemberCodeVC.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLMemberCodeVC.h"
#import "JXButton.h"
@interface WCLMemberCodeVC ()
@property(nonatomic,strong)JXButton * firstBtn;
@property(nonatomic,strong)JXButton * secondBtn;

@end

@implementation WCLMemberCodeVC
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
    UIView * view1 = [UIView new];
    view1.backgroundColor = [UIColor colorWithHexString:@"#BF0000"];
    view1.alpha=1;
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIImageView * backImageView = [UIImageView new];
    backImageView.layer.cornerRadius=8;
    backImageView.layer.masksToBounds=YES;
    backImageView.backgroundColor= [UIColor whiteColor];
    [view1 addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(36);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(503);
    }];
    UIView* headerView = [UIView new];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#E0BE8D"];
    [view1 addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImageView.mas_top);
        make.left.right.equalTo(backImageView);
        make.height.mas_equalTo(40);
    }];
    UILabel * cordLabel = [UILabel new];
    cordLabel.text = @"电子会员码";
    cordLabel.alpha=1;
    [view1 addSubview:cordLabel];
    [cordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView.mas_centerY);
        make.left.equalTo(headerView.mas_left).offset(10);
    }];
    UILabel * vipLabel = [UILabel new];
    vipLabel.text = @"VIP积分卡";
    vipLabel.font= [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [view1 addSubview:vipLabel];
    [vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    //条形码
    UIImageView *barCodeImageView = [[UIImageView alloc]init];
    barCodeImageView.image = [YBLMethodTools generateBarcodeWithInputMessage:@"0999032800022000" Width:self.view.bounds.size.width-120 Height:62];
    [view1 addSubview:barCodeImageView];
    [barCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    //二维码
    UIImageView *QRCodeImageView = [[UIImageView alloc]init];
    QRCodeImageView.image = [YBLMethodTools generateQRCodeWithInputMessage:@"0999032800022000" Width:180 Height:180];
    //    QRCodeImageView.image = [BarCodeAndQRCodeManager generateQRCodeWithInputMessage:@"自动那天起" Width:200 Height:200 AndCenterImage:[UIImage imageNamed:@"center.png"]];
    [view1 addSubview:QRCodeImageView];
    [QRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(barCodeImageView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    UILabel * kahaoLabel = [UILabel new];
    kahaoLabel.text = @"VIP积分卡";
    kahaoLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    kahaoLabel.textColor = [UIColor colorWithHexString:@"#A9B5C4"];
    [view1 addSubview:kahaoLabel];
    [kahaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(QRCodeImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    UIButton * helpBtn = [UIButton new];
    [helpBtn setTitle:@"会员特权与优惠" forState:UIControlStateNormal];
    [helpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view1 addSubview:helpBtn];
    [[helpBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        WCLLog(@"你单击了会员码");
    }];
    [helpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kahaoLabel.mas_bottom).offset(34);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
#pragma mark - view2
    UIView * view2 = [UIView new];
    view2.backgroundColor = [UIColor colorWithHexString:@"#BF0000"];
    view2.alpha=0;
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIImageView * backImageView2 = [UIImageView new];
    backImageView2.layer.cornerRadius=8;
    backImageView2.layer.masksToBounds=YES;
    backImageView2.backgroundColor= [UIColor whiteColor];
    [view2 addSubview:backImageView2];
    [backImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(36);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(503);
    }];
    UIView* headerView2 = [UIView new];
    headerView2.backgroundColor = [UIColor colorWithHexString:@"#E0BE8D"];
    [view2 addSubview:headerView2];
    [headerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImageView2.mas_top);
        make.left.right.equalTo(backImageView2);
        make.height.mas_equalTo(40);
    }];
    UILabel * cordLabel2 = [UILabel new];
    cordLabel2.text = @"付款码";
    cordLabel2.alpha=1;
    [view2 addSubview:cordLabel2];
    [cordLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView2.mas_centerY);
        make.left.equalTo(headerView2.mas_left).offset(10);
    }];
   
    //条形码
    UIImageView *barCodeImageView2 = [[UIImageView alloc]init];
    barCodeImageView2.image = [YBLMethodTools generateBarcodeWithInputMessage:@"0999032800022000" Width:self.view.bounds.size.width-120 Height:62];
    [view2 addSubview:barCodeImageView2];
    [barCodeImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView2.mas_bottom).offset(25);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    UIButton * vipLabel2 = [UIButton new];
    [vipLabel2 setTitle:@"点击查看数字" forState:UIControlStateNormal];
    [vipLabel2 setTitleColor:[UIColor colorWithHexString:@"#4A90E2"] forState:UIControlStateNormal];
    vipLabel2.titleLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [[vipLabel2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        vipLabel2.selected =!x.selected;
        [vipLabel2 setTitle:vipLabel2.selected?@"0999032800022000":@"点击查看数字" forState:UIControlStateNormal];
    }];
    [view2 addSubview:vipLabel2];
    [vipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(barCodeImageView2.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    //二维码
    UIImageView *QRCodeImageView2 = [[UIImageView alloc]init];
    QRCodeImageView2.image = [YBLMethodTools generateQRCodeWithInputMessage:@"0999032800022000" Width:180 Height:180];
    //    QRCodeImageView.image = [BarCodeAndQRCodeManager generateQRCodeWithInputMessage:@"自动那天起" Width:200 Height:200 AndCenterImage:[UIImage imageNamed:@"center.png"]];
    [view2 addSubview:QRCodeImageView2];
    [QRCodeImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipLabel2.mas_bottom).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    UILabel * moneyLabel = [UILabel new];
    moneyLabel.text = @"余额";
    moneyLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    moneyLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [view2 addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(QRCodeImageView2.mas_bottom).offset(40);
        make.left.mas_equalTo(73);
    }];
    UILabel * moneyLabel2 = [UILabel new];
    moneyLabel2.text = @"35600.00";
    moneyLabel2.font= [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    moneyLabel2.textColor = [UIColor blackColor];
    [view2 addSubview:moneyLabel2];
    [moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLabel.mas_bottom).offset(7);
        make.centerX.equalTo(moneyLabel.mas_centerX);
    }];
    UIView * oneview = [UIView new];
    oneview.backgroundColor = [UIColor colorWithHexString:@"#B3956B"];
    [view2 addSubview:oneview];
    [oneview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLabel2.mas_right).offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
        make.top.equalTo(QRCodeImageView2.mas_bottom).offset(47);
    }];
    UILabel * jifenLabel = [UILabel new];
    jifenLabel.text = @"积分";
    jifenLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    jifenLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [view2 addSubview:jifenLabel];
    [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(QRCodeImageView2.mas_bottom).offset(40);
        make.left.equalTo(oneview.mas_right).offset(39);
    }];
    UILabel * jifenLabel2 = [UILabel new];
    jifenLabel2.text = @"32980";
    jifenLabel2.font= [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    jifenLabel2.textColor = [UIColor blackColor];
    [view2 addSubview:jifenLabel2];
    [jifenLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenLabel.mas_bottom).offset(7);
        make.centerX.equalTo(jifenLabel.mas_centerX);
    }];
    UIView * twoview = [UIView new];
    twoview.backgroundColor = [UIColor colorWithHexString:@"#B3956B"];
    [view2 addSubview:twoview];
    [twoview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jifenLabel2.mas_right).offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
        make.top.equalTo(QRCodeImageView2.mas_bottom).offset(47);
    }];
    UILabel * piaojuanLabel = [UILabel new];
    piaojuanLabel.text = @"票券";
    piaojuanLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    piaojuanLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [view2 addSubview:piaojuanLabel];
    [piaojuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(QRCodeImageView2.mas_bottom).offset(40);
        make.left.equalTo(twoview.mas_right).offset(39);
    }];
    UILabel * piaojuanLabel2 = [UILabel new];
    piaojuanLabel2.text = @"6";
    piaojuanLabel2.font= [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    piaojuanLabel2.textColor = [UIColor blackColor];
    [view2 addSubview:piaojuanLabel2];
    [piaojuanLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(piaojuanLabel.mas_bottom).offset(7);
        make.centerX.equalTo(piaojuanLabel.mas_centerX);
    }];
#pragma mark - 底部二按钮
    JXButton * btn = [JXButton new];//[[UIButton alloc]initWithFrame:CGRectMake(50,SCREEN_HEIGHT-88-84-49, 50, 49)];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImageView.mas_bottom).offset(31);
        make.left.mas_equalTo(SCREEN_WIDTH/4);
        make.height.mas_equalTo(51);
    }];
    [btn setTitle:@"会员码" forState:UIControlStateNormal];
    _firstBtn = btn;
    [btn setImage:[UIImage imageNamed:@"icon_vipqrcode_normal"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_vipqrcode_activied"] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithHexString:@"#E39999"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected= !x.selected;
        self.secondBtn.selected=NO;
        view2.alpha=0;
        cordLabel.alpha=1;
        headerView.alpha=1;
        view1.alpha=1;
    }];
    JXButton * btn2 = [JXButton new];//:CGRectMake(320, SCREEN_HEIGHT-88-84-49, 50, 49)];
    [btn2 setTitle:@"付款码" forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"icon_payqrcode_activied"] forState:UIControlStateSelected];
    [btn2 setImage:[UIImage imageNamed:@"icon_payqrcode_normal"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"#E39999"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _secondBtn= btn2;
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn);
        make.right.mas_equalTo(-SCREEN_WIDTH/4);
        make.height.equalTo(btn);
    }];
    [btn2 setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected=!x.selected;
        self.firstBtn.selected=NO;
        view1.alpha=0;
        cordLabel.alpha=0;
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
