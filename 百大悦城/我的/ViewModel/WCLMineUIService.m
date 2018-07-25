//
//  WCLMineUIService.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLMineUIService.h"
#import "WCLMineViewModel.h"
#import "WCLMineViewController.h"
#import "WCLMineCollectionCell.h"
#import "WCLLoginViewController.h"
#import "WCLSettingViewController.h"
#import "WCLPersonMessageViewController.h"
#import "WCLMessageListViewController.h"
#import "WCLMemberCardViewController.h"
#import "WCLMemberPointsViewController.h"
#import "WCLAccountBalanceVC.h"
@interface WCLMineUIService()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) WCLMineViewController *homeVC;
@property (nonatomic, weak) WCLMineViewModel *viewModel;
@property(nonatomic,strong)NSArray * SourceArray;
@end
@implementation WCLMineUIService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _homeVC = (WCLMineViewController*)VC;
        _homeVC.view.backgroundColor = [UIColor whiteColor];
        [self requestsix];
        _viewModel = (WCLMineViewModel*)viewModel;
        [RACObserve([WCLUserManageCenter shareInstance], isLoginStatus)subscribeNext:^(NSNumber* x) {
            if (x.boolValue) {
                [[WCLLoginViewModel signalForGetUserInfo]subscribeNext:^(NSNumber* x) {
                    if (x.boolValue) {
                        [self createHaveHeaderView];
                        [self.mineCollectionView reloadData];
                    }
                    else
                    {
                         [self createHeaderView];
                    }
                }];
                
            }
            else
            {
                [self createHeaderView];
            }
        }];
    }
    return self;
}
-(void)requestsix
{
    _SourceArray = @[
  @{@"icon":@"user_icon_paycode",@"cntitle":@"付款",@"entitle":@"Pay Code",@"desc":@"向商家出示您的会员码"},
  @{@"icon":@"user_icon_ticket",@"cntitle":@"票券",@"entitle":@"Ticket",@"desc":@""},
  @{@"icon":@"user_icon_orders",@"cntitle":@"订单",@"entitle":@"Orders",@"desc":@""},
  @{@"icon":@"user_icon_exchange",@"cntitle":@"兑换",@"entitle":@"Exchange",@"desc":@""},
  @{@"icon":@"user_icon_activity",@"cntitle":@"活动",@"entitle":@"Activity",@"desc":@""},
//  @{@"icon":@"user_icon_apptool",@"cntitle":@"工具",@"entitle":@"App Tool",@"desc":@"自助积分等"}
  ];
    [self.mineCollectionView reloadData];
}

- (void)requestUserInfoData{
    if ([WCLUserManageCenter shareInstance].isLoginStatus) {
        [[WCLLoginViewModel signalForGetUserInfo]subscribeNext:^(NSNumber* x) {
            if (x.boolValue) {
                [self createHaveHeaderView];
                [self.mineCollectionView reloadData];
            }
            else
            {
                [self createHeaderView];
            }
        }];
        
    }
    else
    {
        [self createHeaderView];
        
    }
}
-(void)createHaveHeaderView
{
    _backImageView = [UIImageView new];
    _backImageView.image = [UIImage imageNamed:@"img_user_bg"];
    [self.homeVC.view addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.homeVC.view);
        make.height.mas_equalTo(SCREEN_SCALE_Iphone6*180);
    }];
    _settingBtn = [UIButton new];
    [[_settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        WCLSettingViewController * svc = [[WCLSettingViewController alloc]init];
        svc.hidesBottomBarWhenPushed =YES;
        [self.homeVC.navigationController pushViewController:svc animated:YES];
        
    }];
    [_settingBtn setImage:[UIImage imageNamed:@"home_icon_setting"] forState:UIControlStateNormal];
    [self.homeVC.view addSubview:_settingBtn];
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-24);
        make.top.mas_equalTo(IsiPhoneX?45:34);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
    }];
    _messageBtn = [UIButton new]; //暂时不用，消息列表，无接口
    [[_messageBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
       // WCLLog(@"%@",x);
        WCLMessageListViewController * message = [[WCLMessageListViewController alloc]init];
        message.hidesBottomBarWhenPushed=YES;
        [self.homeVC.navigationController pushViewController:message animated:YES];
    }];
    [_messageBtn setImage:[UIImage imageNamed:@"home_icon_message"] forState:UIControlStateNormal];
    [self.homeVC.view addSubview:_messageBtn];
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.settingBtn);
        make.right.equalTo(self.settingBtn.mas_left).offset(-22);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
    }];
    _userBackImageView = [UIImageView new];
    _userBackImageView.userInteractionEnabled = YES;
    _userBackImageView.image = [UIImage imageNamed:@"img_user_card"];
    [self.homeVC.view addSubview:_userBackImageView];
    [_userBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageBtn.mas_bottom).offset(11);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(SCREEN_SCALE_Iphone6*160);
    }];
    
    UIButton * loginbtn =[UIButton new];
    [[loginbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        WCLPersonMessageViewController * person = [[WCLPersonMessageViewController alloc]init];
        person.hidesBottomBarWhenPushed=YES;
        [self.homeVC.navigationController pushViewController:person animated:YES];
    }];
    [_userBackImageView addSubview:loginbtn];
    _loginBtn=loginbtn;
    _userHeaderView = [UIImageView new];
    _userHeaderView.userInteractionEnabled = YES;
    if ([WCLUserManageCenter shareInstance].userInfoModel.memberHead.length>0&&[[WCLUserManageCenter shareInstance].userInfoModel.memberHead hasPrefix:@"http"]) {
        [_userHeaderView sd_setImageWithURL:[NSURL URLWithString:[WCLUserManageCenter shareInstance].userInfoModel.memberHead]];
    }
    else
    {
    _userHeaderView.image = [UIImage imageNamed:@"banner_placehoder"];
    }
    _userHeaderView.layer.cornerRadius=30;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
    [[tap rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        WCLPersonMessageViewController * person = [[WCLPersonMessageViewController alloc]init];
        person.hidesBottomBarWhenPushed=YES;
        [self.homeVC.navigationController pushViewController:person animated:YES];
    }];
    [_userHeaderView addGestureRecognizer:tap];
    _userHeaderView.layer.masksToBounds=YES;
    [_userBackImageView addSubview:_userHeaderView];
    [_userHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userBackImageView.mas_top).offset(10);
        make.right.equalTo(self.userBackImageView.mas_right).offset(-32);
        make.width.height.mas_equalTo(60);
    }];
    UILabel * nicknameLabel = [UILabel new];
    nicknameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    nicknameLabel.font = [UIFont boldSystemFontOfSize:22];
    nicknameLabel.textColor=[UIColor colorWithHexString:@"#101010"];
    if ([WCLUserManageCenter shareInstance].userInfoModel.memberNickname.length>0) {
        nicknameLabel.text=[WCLUserManageCenter shareInstance].userInfoModel.memberNickname;
    }
    else
    {
        nicknameLabel.text=[WCLUserManageCenter shareInstance].userInfoModel.memberNickname;
    }
    [_userBackImageView addSubview:nicknameLabel];
    [nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userBackImageView.mas_left).offset(20);
        make.top.equalTo(self.userBackImageView.mas_top).offset(10);
        make.right.equalTo(self.userHeaderView.mas_left).offset(-5);
        make.height.mas_equalTo(30);
    }];
    [loginbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(nicknameLabel);
    }];
    UILabel * desc = [UILabel new];
    desc.text=@"近者悦，远者来";
    desc.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    desc.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [_userBackImageView addSubview:desc];
    _userDescLabel = desc;
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginbtn);
        make.top.equalTo(loginbtn.mas_bottom).offset(5);
        make.height.mas_equalTo(17);
    }];
    
    _jifenLabel = [UILabel new];
    NSString * string2 =[NSString stringWithFormat:@"%@分", [WCLUserManageCenter shareInstance].userInfoModel.points.length>0? [WCLUserManageCenter shareInstance].userInfoModel.points:@"0"];
    NSMutableAttributedString *textColor2 = [[NSMutableAttributedString alloc]initWithString:string2];
    NSRange rangel3 = [[textColor2 string] rangeOfString:[string2 substringFromIndex:string2.length-1]];
    NSRange rangel4 = [[textColor2 string] rangeOfString:[string2 substringToIndex:string2.length-1]];
    [textColor2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#101010"] range:rangel3];
    [textColor2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rangel3];
    [textColor2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#101010"] range:rangel4];
    [textColor2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:rangel4];
    [_jifenLabel setAttributedText:textColor2];
    _jifenLabel.textAlignment = NSTextAlignmentCenter;
    [_userBackImageView addSubview:_jifenLabel];
    UITapGestureRecognizer * tap3=[[UITapGestureRecognizer alloc]init];
    [[tap3 rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        WCLMemberPointsViewController * acc = [[WCLMemberPointsViewController alloc]init];
        acc.hidesBottomBarWhenPushed= YES;
        [self.homeVC.navigationController pushViewController:acc animated:YES];
    }];
    _jifenLabel.userInteractionEnabled=YES;
    [_jifenLabel addGestureRecognizer:tap3];
    [_jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.homeVC.view.mas_centerX);
        make.bottom.equalTo(self.userBackImageView.mas_bottom).offset(-15);
    }];
    UILabel * jifenLabel = [UILabel new];
    jifenLabel.text = @"积分";
    jifenLabel.textAlignment = NSTextAlignmentCenter;
    jifenLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    jifenLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [_userBackImageView addSubview:jifenLabel];
    _integralLabel = jifenLabel;
    [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jifenLabel.mas_top).offset(-5);
        make.centerX.equalTo(self.homeVC.view.mas_centerX);
    }];
   
    _yueView = [UIView new];
    _yueView.backgroundColor = [UIColor colorWithHexString:@"#B3956B"];
    [_userBackImageView addSubview:_yueView];
    [_yueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jifenLabel.mas_bottom).offset(-5);
        make.right.equalTo(self.jifenLabel.mas_left).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(1);
    }];
    UILabel * yueLabel = [UILabel new];
    yueLabel.text = @"余额";
    yueLabel.textAlignment = NSTextAlignmentCenter;
    yueLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    yueLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [_userBackImageView addSubview:yueLabel];
    _balanceLabel = yueLabel;
    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(jifenLabel.mas_centerY);
        make.right.equalTo(self.yueView.mas_left).offset(-SCREEN_SCALE_Iphone6*30);
        make.height.mas_equalTo(20);
    }];
    _moneyLabel = [UILabel new];
    NSString * string1 = [NSString stringWithFormat:@"%@元",[WCLUserManageCenter shareInstance].userInfoModel.accountBalance.length>0?[WCLUserManageCenter shareInstance].userInfoModel.accountBalance:@"0"];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:string1];
    NSRange rangel = [[textColor string] rangeOfString:[string1 substringFromIndex:string1.length-1]];
    NSRange rangel2 = [[textColor string] rangeOfString:[string1 substringToIndex:string1.length-1]];
    [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#101010"] range:rangel];
    [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rangel];
    [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#101010"] range:rangel2];
    [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:rangel2];
    [_moneyLabel setAttributedText:textColor];
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    [_userBackImageView addSubview:_moneyLabel];
    UITapGestureRecognizer * tap2=[[UITapGestureRecognizer alloc]init];
    [[tap2 rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        WCLAccountBalanceVC * acc = [[WCLAccountBalanceVC alloc]init];
        acc.hidesBottomBarWhenPushed= YES;
        [self.homeVC.navigationController pushViewController:acc animated:YES];
    }];
    _moneyLabel.userInteractionEnabled=YES;
    [_moneyLabel addGestureRecognizer:tap2];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(yueLabel.mas_centerX);
        make.centerY.equalTo(self.jifenLabel.mas_centerY);
//        make.height.mas_equalTo(28);
    }];
    _jifenView = [UIView new];
    _jifenView.backgroundColor = [UIColor colorWithHexString:@"#B3956B"];
    [_userBackImageView addSubview:_jifenView];
    [_jifenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jifenLabel.mas_bottom).offset(-5);
        make.left.equalTo(self.jifenLabel.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(1);
    }];
    _gradeLabel = [UIButton new];
    if([WCLUserManageCenter shareInstance].userInfoModel.cardLevel.length>0)
    {
        [_gradeLabel setTitle:[WCLUserManageCenter shareInstance].userInfoModel.cardLevel forState:UIControlStateNormal];
    }
    else
    {
        [_gradeLabel setTitle:@"领取会员卡" forState:UIControlStateNormal];
        
    }
    [_gradeLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _gradeLabel.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    [[_gradeLabel rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        WCLMemberCardViewController * mvc = [[WCLMemberCardViewController alloc]init];
        mvc.hidesBottomBarWhenPushed =YES;
        [self.homeVC.navigationController pushViewController:mvc animated:YES];
    }];
    [_userBackImageView addSubview:_gradeLabel];
    [_gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jifenLabel.mas_centerY);
        make.left.equalTo(self.jifenView.mas_right).offset(10);
        make.height.mas_equalTo(28);
    }];
    UILabel * lvLabel = [UILabel new];
    lvLabel.text = @"等级";
    lvLabel.textAlignment = NSTextAlignmentCenter;
    lvLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    lvLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [_userBackImageView addSubview:lvLabel];
    _lvLabel= lvLabel;
    [lvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(jifenLabel.mas_centerY);
        make.centerX.equalTo(self.gradeLabel.mas_centerX);
        make.height.mas_equalTo(20);
    }];
   
    [self.homeVC.view addSubview:self.mineCollectionView];
}
-(void)createHeaderView
{
    _backImageView = [UIImageView new];
    _backImageView.image = [UIImage imageNamed:@"img_user_bg"];
    [self.homeVC.view addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.homeVC.view);
        make.height.mas_equalTo(SCREEN_SCALE_Iphone6*180);
    }];
    _settingBtn = [UIButton new];
    [[_settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        WCLSettingViewController * svc = [[WCLSettingViewController alloc]init];
        svc.hidesBottomBarWhenPushed =YES;
        [self.homeVC.navigationController pushViewController:svc animated:YES];
    }];
    [_settingBtn setImage:[UIImage imageNamed:@"home_icon_setting"] forState:UIControlStateNormal];
    [self.homeVC.view addSubview:_settingBtn];
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-24);
        make.top.mas_equalTo(IsiPhoneX?45:34);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
    }];
    _messageBtn = [UIButton new];
//    [[_messageBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//        WCLMessageListViewController * message = [[WCLMessageListViewController alloc]init];
//        message.hidesBottomBarWhenPushed=YES;
//        [self.homeVC.navigationController pushViewController:message animated:YES];
//    }];
//    [_messageBtn setImage:[UIImage imageNamed:@"home_icon_message"] forState:UIControlStateNormal];
    [self.homeVC.view addSubview:_messageBtn];
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.settingBtn);
        make.right.equalTo(self.settingBtn.mas_left).offset(-22);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
    }];
    _userBackImageView = [UIImageView new];
    _userBackImageView.userInteractionEnabled = YES;
    _userBackImageView.image = [UIImage imageNamed:@"img_user_card"];
    [self.homeVC.view addSubview:_userBackImageView];
    [_userBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageBtn.mas_bottom).offset(11);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(SCREEN_SCALE_Iphone6*160);
    }];
    UIButton * loginbtn =[UIButton new];
    [[loginbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        WCLLoginViewController * lvc = [WCLLoginViewController new];
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
        [self.homeVC presentViewController:nvc animated:YES completion:nil];
    }];
    [_userBackImageView addSubview:loginbtn];
    _userHeaderView = [UIImageView new];
    _userHeaderView.userInteractionEnabled = YES;
   _userHeaderView.image = [UIImage imageNamed:@"banner_placehoder"];
    _userHeaderView.layer.cornerRadius=30;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
    [[tap rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        WCLLoginViewController * lvc = [WCLLoginViewController new];
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
        [self.homeVC presentViewController:nvc animated:YES completion:nil];
    }];
    [_userHeaderView addGestureRecognizer:tap];
    _userHeaderView.layer.masksToBounds=YES;
    [_userBackImageView addSubview:_userHeaderView];
    [_userHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userBackImageView.mas_top).offset(10);
        make.right.equalTo(self.userBackImageView.mas_right).offset(-32);
        make.width.height.mas_equalTo(60);
    }];
    UILabel * nicknameLabel = [UILabel new];
    nicknameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    nicknameLabel.font = [UIFont boldSystemFontOfSize:22];
    nicknameLabel.textColor=[UIColor colorWithHexString:@"#101010"];
    nicknameLabel.text=@"注册/登录";
    [_userBackImageView addSubview:nicknameLabel];
    [nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userBackImageView.mas_left).offset(20);
        make.top.equalTo(self.userBackImageView.mas_top).offset(10);
        make.right.equalTo(self.userHeaderView.mas_left).offset(-5);
        make.height.mas_equalTo(30);
    }];
    [loginbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(nicknameLabel);
    }];
    _userHeaderView = [UIImageView new];
    _userHeaderView.image = [UIImage imageNamed:@"banner_placehoder"];
    _userHeaderView.layer.cornerRadius=30;
    _userHeaderView.layer.masksToBounds=YES;
    [_userBackImageView addSubview:_userHeaderView];
    [_userHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userBackImageView.mas_top).offset(10);
        make.right.equalTo(self.userBackImageView.mas_right).offset(-32);
        make.width.height.mas_equalTo(60);
    }];
    UILabel * desc = [UILabel new];
    desc.text=@"近者悦，远者来";
    desc.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    desc.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [_userBackImageView addSubview:desc];
    _userDescLabel = desc;
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginbtn);
        make.top.equalTo(loginbtn.mas_bottom).offset(5);
        make.height.mas_equalTo(17);
    }];
    _jifenLabel = [UILabel new];
    NSString * string2 = @"0分";
    NSMutableAttributedString *textColor2 = [[NSMutableAttributedString alloc]initWithString:string2];
    NSRange rangel3 = [[textColor2 string] rangeOfString:[string2 substringFromIndex:string2.length-1]];
    NSRange rangel4 = [[textColor2 string] rangeOfString:[string2 substringToIndex:string2.length-1]];
    [textColor2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#101010"] range:rangel3];
    [textColor2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rangel3];
    [textColor2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#101010"] range:rangel4];
    [textColor2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:rangel4];
    [_jifenLabel setAttributedText:textColor2];
    _jifenLabel.textAlignment = NSTextAlignmentCenter;
    [_userBackImageView addSubview:_jifenLabel];
    UITapGestureRecognizer * tap5=[[UITapGestureRecognizer alloc]init];
    [[tap5 rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        WCLLoginViewController * lvc = [WCLLoginViewController new];
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
        [self.homeVC presentViewController:nvc animated:YES completion:nil];
    }];
    _jifenLabel.userInteractionEnabled =YES;
    [_jifenLabel addGestureRecognizer:tap5];
    [_jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.homeVC.view.mas_centerX);
        make.bottom.equalTo(self.userBackImageView.mas_bottom).offset(-15);
//        make.height.mas_equalTo(28);
    }];
    UILabel * jifenLabel = [UILabel new];
    jifenLabel.text = @"积分";
    jifenLabel.textAlignment = NSTextAlignmentCenter;
    jifenLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    jifenLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [_userBackImageView addSubview:jifenLabel];
    _integralLabel = jifenLabel;
    [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jifenLabel.mas_top).offset(-5);
        make.centerX.equalTo(self.homeVC.view.mas_centerX);
//        make.height.mas_equalTo(20);
    }];
  
    _yueView = [UIView new];
    _yueView.backgroundColor = [UIColor colorWithHexString:@"#B3956B"];
    [_userBackImageView addSubview:_yueView];
    [_yueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jifenLabel.mas_bottom).offset(-5);
        make.right.equalTo(self.jifenLabel.mas_left).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(1);
    }];
    UILabel * yueLabel = [UILabel new];
    yueLabel.text = @"余额";
    yueLabel.textAlignment = NSTextAlignmentCenter;
    yueLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    yueLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [_userBackImageView addSubview:yueLabel];
    _balanceLabel = yueLabel;
    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(jifenLabel.mas_centerY);
        make.right.equalTo(self.yueView.mas_left).offset(-SCREEN_SCALE_Iphone6*30);
        make.height.mas_equalTo(20);
    }];
    _moneyLabel = [UILabel new];
    NSString * string1 = @"0元";
    UITapGestureRecognizer * tap4=[[UITapGestureRecognizer alloc]init];
    [[tap4 rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        WCLLoginViewController * lvc = [WCLLoginViewController new];
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
        [self.homeVC presentViewController:nvc animated:YES completion:nil];
    }];
    _moneyLabel.userInteractionEnabled=YES;
    [_moneyLabel addGestureRecognizer:tap4];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:string1];
    NSRange rangel = [[textColor string] rangeOfString:[string1 substringFromIndex:string1.length-1]];
    NSRange rangel2 = [[textColor string] rangeOfString:[string1 substringToIndex:string1.length-1]];
    [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#101010"] range:rangel];
    [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:rangel];
    [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#101010"] range:rangel2];
    [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:rangel2];
    [_moneyLabel setAttributedText:textColor];
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    [_userBackImageView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(yueLabel.mas_centerX);
        make.centerY.equalTo(self.jifenLabel.mas_centerY);
//        make.height.mas_equalTo(28);
    }];
    _jifenView = [UIView new];
    _jifenView.backgroundColor = [UIColor colorWithHexString:@"#B3956B"];
    [_userBackImageView addSubview:_jifenView];
    [_jifenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jifenLabel.mas_bottom).offset(-5);
        make.left.equalTo(self.jifenLabel.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(1);
    }];
    _gradeLabel = [UIButton new];
    [_gradeLabel setTitle:@"领取会员卡" forState:UIControlStateNormal];
    [_gradeLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _gradeLabel.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    [[_gradeLabel rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        WCLLoginViewController * lvc = [WCLLoginViewController new];
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
        [self.homeVC presentViewController:nvc animated:YES completion:nil];
    }];
    [_userBackImageView addSubview:_gradeLabel];
    [_gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jifenLabel.mas_centerY);
        make.left.equalTo(self.jifenView.mas_right).offset(10);
        make.height.mas_equalTo(28);
    }];
    UILabel * lvLabel = [UILabel new];
    lvLabel.text = @"等级";
    lvLabel.textAlignment = NSTextAlignmentCenter;
    lvLabel.font= [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    lvLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [_userBackImageView addSubview:lvLabel];
    _lvLabel= lvLabel;
    [lvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(jifenLabel.mas_centerY);
        make.centerX.equalTo(self.gradeLabel.mas_centerX);
        make.height.mas_equalTo(20);
    }];
  
    [self.homeVC.view addSubview:self.mineCollectionView];
}
- (UICollectionView *)mineCollectionView{
    
    if (!_mineCollectionView) {
//        CGFloat collectionWi = SCREEN_WIDTH-(23*4));
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowlayout.minimumLineSpacing = 0;
        flowlayout.minimumInteritemSpacing = 0;
        _mineCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(23,SCREEN_SCALE_Iphone6*240, SCREEN_WIDTH-46,IsiPhoneX?SCREEN_HEIGHT-88-SCREEN_SCALE_Iphone6*240:SCREEN_HEIGHT-49-SCREEN_SCALE_Iphone6*240) collectionViewLayout:flowlayout];
        _mineCollectionView.dataSource = self;
        _mineCollectionView.delegate = self;
//        _mineCollectionView.scrollEnabled = NO;
        _mineCollectionView.showsHorizontalScrollIndicator = NO;
        _mineCollectionView.backgroundColor = [UIColor whiteColor];
        [_mineCollectionView registerClass:[WCLMineCollectionCell class] forCellWithReuseIdentifier:@"WCLMineCollectionCell"];
        [_homeVC.view addSubview:_mineCollectionView];
    }
    return _mineCollectionView;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _SourceArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   NSDictionary * sixDic =_SourceArray[indexPath.item];
    WCLMineCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLMineCollectionCell" forIndexPath:indexPath];
    switch (indexPath.item) {
        case 0:
        {
            cell.backImageView.backgroundColor =[UIColor colorWithHexString:@"#F2E7D5"];
        }
            break;
        case 1:
        {
            cell.backImageView.backgroundColor =[UIColor colorWithHexString:@"#E6D3E5"];
        }break;
        case 2:
        {
            cell.backImageView.backgroundColor =[UIColor colorWithHexString:@"#DAEEF2"];

//            cell.backImageView.backgroundColor =[UIColor lightGrayColor];//[UIColor colorWithHexString:@"#F2DDD5"];
        }break;
        case 3:
        {
            cell.backImageView.backgroundColor =[UIColor colorWithHexString:@"#DFE2F2 "];
        }break;
        case 4:
        {
            cell.backImageView.backgroundColor =[UIColor colorWithHexString:@"#E4F2DF"];
        }break;
        case 5:
        {
//            cell.backImageView.backgroundColor =[UIColor lightGrayColor];//[UIColor colorWithHexString:@"#DAEEF2"];
        }break;
        default:
            break;
    }
    cell.sixDic = sixDic;

//    changeDiyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"changecell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
//    cell.itemIdex = indexPath.item;
//    chageDiyModel *model = modelArray[indexPath.item];
//    cell.model = model;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    chageDiyModel * model = modelArray[indexPath.row];
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake(SCREEN_WIDTH / 2 - 33, 120);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _sixBtnBlock(indexPath.item);
//    DiyClothesDetailViewController *toButy = [[DiyClothesDetailViewController alloc] init];
//    toButy.goodDic = [NSMutableDictionary dictionaryWithDictionary:detailArray[indexPath.item]];
//    [self.navigationController pushViewController:toButy animated:YES];
}
@end
