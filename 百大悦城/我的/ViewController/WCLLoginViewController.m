//
//  WCLLoginViewController.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLLoginViewController.h"
#import "JKCountDownButton.h"
#import "WCLLoginViewModel.h"
#import "WCLRegisterViewController.h"
#import "WCLForgetPassWordViewController.h"
#import "WCLRegisterViewController.h"
#import "WCLRegisterProtocolVC2.h"
@interface WCLLoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView * backImageView1;
@property(nonatomic,strong)UILabel * titleNamesLabel;
@property(nonatomic,strong)UITextField * photoTextField1;
@property(nonatomic,strong)UITextField * checkCountTextField;
@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;
@property(nonatomic,strong)JKCountDownButton *sendButton;
@property(nonatomic,strong)UITextField * passWordTextField;
@property(nonatomic,strong)UIButton * showPassWordBtn;
@property(nonatomic,strong)UIButton * loginBtns;
@property(nonatomic,strong)UIButton * forgetBtns;
@property(nonatomic,strong)UIView * fenGeView;
@property (nonatomic, assign) BOOL isAgree;
@property(nonatomic,strong)YBLButton * agreeButton;
@property(nonatomic,strong)UIButton* xieyiButton;
@end

@implementation WCLLoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)name:@"UITextFieldTextDidChangeNotification" object:_photoTextField1];
    self.isAgree = YES;
    [self createJianBianSe];
    [self createHeaderView];
    [self createUI];
}
-(void)createJianBianSe
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#FFF5E4"].CGColor,  (__bridge id)[UIColor colorWithHexString:@"#F2E2CC"].CGColor];
    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view.layer addSublayer:gradientLayer];
}
-(void)createHeaderView
{
    UILabel * titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"手机快捷登录";
    [self.view addSubview:titleLabel];
    _titleNamesLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(IsiPhoneX?54:34);
    }];
    _backImageView1 = [UIImageView new];
    _backImageView1.image = [UIImage imageNamed:@"icon_sign_bg"];
    [self.view addSubview:_backImageView1];
    [_backImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleNamesLabel.mas_bottom).offset(36);
        make.width.mas_equalTo(256);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    UIButton * xBtn = [UIButton new];
    [xBtn setImage:[UIImage imageNamed:@"address_close"] forState:UIControlStateNormal];
    [[xBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:xBtn];
    [xBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.height.width.mas_equalTo(18);
    }];
}
-(void)createUI{
#pragma mark - 左边按钮
    _leftBtn = [UIButton new];
    _leftBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [_leftBtn setTitle:@"手机快捷登录" forState:UIControlStateNormal];
    _leftBtn.selected =YES;
    [[_leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton* x) {
        self.titleNamesLabel.text = @"手机快捷登录";
        self.rightBtn.selected =NO;
        self.rightBtn.backgroundColor =[UIColor colorWithHexString:@"#E1C08F"];
        x.selected =YES;
        x.backgroundColor = [UIColor clearColor];
        self.checkCountTextField.alpha=1;
        self.sendButton.alpha=1;
        self.passWordTextField.alpha=0;
        self.photoTextField1.text =@"";
        self.checkCountTextField.text = @"";
        self.showPassWordBtn.alpha=0;
        self.fenGeView.alpha=1;
        self.forgetBtns.alpha=0;
        self.xieyiButton.alpha=1;
        self.agreeButton.alpha=1;
    }];
    [_leftBtn setTitleColor:[UIColor colorWithHexString:@"#957E5E"] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor colorWithHexString:@"#990000"] forState:UIControlStateSelected];
    _leftBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView1).offset(2);
        make.left.equalTo(self.backImageView1).offset(4);
        make.width.mas_equalTo(128);
        make.height.mas_equalTo(36);
    }];
#pragma mark - 右边按钮
    
    _rightBtn = [UIButton new];
    _rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [_rightBtn setTitle:@"账号密码登录" forState:UIControlStateNormal];
    self.rightBtn.backgroundColor = [UIColor colorWithHexString:@"#E1C08F"];
    [[_rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton* x) {
        self.titleNamesLabel.text = @"账号密码登录";
        self.leftBtn.selected=NO;
        self.leftBtn.backgroundColor = [UIColor colorWithHexString:@"#E1C08F"];
        x.selected =YES;
        x.backgroundColor =[UIColor clearColor];
        self.checkCountTextField.alpha=0;
        self.sendButton.alpha=0;
        self.passWordTextField.alpha=1;
        self.passWordTextField.text = @"";
        self.photoTextField1.text = @"";
        self.showPassWordBtn.alpha = 1;
        self.fenGeView.alpha=0;
        self.forgetBtns.alpha=1;
        self.xieyiButton.alpha=0;
        self.agreeButton.alpha=0;
        
    }];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#957E5E"] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#990000"] forState:UIControlStateSelected];
    [self.view addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftBtn);
        make.right.equalTo(self.backImageView1.mas_right).offset(-4);
        make.width.mas_equalTo(128);
        make.height.mas_equalTo(36);
    }];
    _photoTextField1 = [UITextField new];
    WEAK
    
    [self.view addSubview:_photoTextField1];
    _photoTextField1.placeholder = @"输入手机号码";
    _photoTextField1.keyboardType = UIKeyboardTypeNumberPad;
    [_photoTextField1 setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [_photoTextField1 setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    _photoTextField1.clearButtonMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    _photoTextField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _photoTextField1.delegate = self;
    [_photoTextField1 setValue:[UIColor colorWithHexString:@"#F7E9D3"] forKeyPath:@"_placeholderLabel.textColor"];
    [_photoTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftBtn.mas_bottom).offset(30);
        make.left.equalTo(self.backImageView1.mas_left).offset(20);
        make.right.equalTo(self.backImageView1.mas_right).offset(-20);
        make.height.mas_equalTo(18);
    }];
    UIView *lineUserName = [UIView new];
    [lineUserName setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.view addSubview:lineUserName];
    [lineUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoTextField1.mas_bottom).offset(10);
        make.left.right.equalTo(self.photoTextField1);
        make.height.mas_equalTo(1);
    }];
    
    _checkCountTextField = [UITextField new];
    [self.view addSubview:_checkCountTextField];
    [_checkCountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineUserName.mas_bottom).offset(16);
        make.left.right.height.equalTo(self.photoTextField1);
    }];
    [_checkCountTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [_checkCountTextField setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    _checkCountTextField.placeholder = @"输入验证码";
//    [_checkCountTextField setSecureTextEntry:YES];
    _checkCountTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_checkCountTextField setValue:[UIColor colorWithHexString:@"#F7E9D3"] forKeyPath:@"_placeholderLabel.textColor"];
    _checkCountTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    _checkCountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _checkCountTextField.delegate = self;
    
    _passWordTextField = [UITextField new];
    _passWordTextField.alpha=0;
    [self.view addSubview:_passWordTextField];
    [_passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineUserName.mas_bottom).offset(16);
        make.left.right.height.equalTo(self.photoTextField1);
    }];
    [_passWordTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [_passWordTextField setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    _passWordTextField.placeholder = @"输入密码";
//    _passWordTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passWordTextField.secureTextEntry=YES;
    [_passWordTextField setValue:[UIColor colorWithHexString:@"#F7E9D3"] forKeyPath:@"_placeholderLabel.textColor"];
    _passWordTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    _passWordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passWordTextField.delegate = self;
    
    _showPassWordBtn = [UIButton new];
    [_showPassWordBtn setImage:[UIImage imageNamed:@"icon_closeeyes"] forState:UIControlStateNormal];
    _showPassWordBtn.alpha=0;
    [[_showPassWordBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton* x) {
        STRONG
        x.selected =!x.selected;
        self.passWordTextField.secureTextEntry = !x.selected;
        [self.showPassWordBtn setImage:x.selected?[UIImage imageNamed:@"icon_openeyes"]:[UIImage imageNamed:@"icon_closeeyes"] forState:UIControlStateNormal];
    }];
    [self.view addSubview:_showPassWordBtn];
    [_showPassWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passWordTextField);
        make.right.equalTo(self.backImageView1.mas_right).offset(-30.4);
    }];
    
    UIView *lineCheck = [UIView new];
    [lineCheck setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.view addSubview:lineCheck];
    [lineCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkCountTextField.mas_bottom).offset(10);
        make.left.right.equalTo(self.checkCountTextField);
        make.height.mas_equalTo(1);
    }];
    UIButton * forgetBtn = [UIButton new];
    forgetBtn.alpha=0;
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"#957E5E"] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [[forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        WCLForgetPassWordViewController * fvc = [[WCLForgetPassWordViewController alloc]init];
        [self.navigationController pushViewController:fvc animated:YES];
    }];
    [self.view addSubview:forgetBtn];
    _forgetBtns = forgetBtn;
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineCheck.mas_bottom).offset(12);
        make.right.equalTo(self.backImageView1.mas_right).offset(-20);
    }];
    _sendButton = [JKCountDownButton new];
    [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor colorWithHexString:@"#990000"] forState:UIControlStateNormal];
    [[_sendButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIButton * _Nullable x) {
        x.enabled=NO;
            // 检测手机号码是否输入
            if (self.photoTextField1.text.length == 0){
                [self showMesageWithString:@"手机号不能为空" withDelay:1];
                [self.photoTextField1 becomeFirstResponder];
                return;
            }
            //登录操作
            BOOL isPhone = [YBLMethodTools checkPhone:self.photoTextField1.text];
            if (!isPhone) {
                [SVProgressHUD showErrorWithStatus:@"手机号格式不正确!"];
                return ;
            }
            [self.sendButton startWithSecond:60];
            [[WCLLoginViewModel signalForSecurityCodeByPhone:self.photoTextField1.text]subscribeNext:^(id  _Nullable x) {
                
                 }];
    }];
    [_sendButton didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        countDownButton.enabled = NO;
        NSString *title = [NSString stringWithFormat:@"(%d)s重发",second];
        return title;
    }];
    [_sendButton didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"重新获取";
    }];
    [self.view addSubview:_sendButton];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkCountTextField);
        make.right.equalTo(self.backImageView1.mas_right).offset(-20);
        make.height.mas_equalTo(18);
    }];
    
    _fenGeView = [UIView new];
    _fenGeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_fenGeView];
    [_fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineCheck.mas_bottom).offset(-4);
        make.right.equalTo(self.sendButton.mas_left).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(1);
    }];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 20;
    _loginBtns = loginButton;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateDisabled];
    loginButton.titleLabel.font = YBLFont(16);
    
    [loginButton setTitleColor:[UIColor colorWithHexString:@"#E0BE8D"] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithHexString:@"#E0BE8D"] forState:UIControlStateDisabled];
    loginButton.backgroundColor = [UIColor colorWithHexString:@"#996B6B"];
    [[loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        STRONG
        if (self.leftBtn.selected) {
            BOOL isPhone = [YBLMethodTools checkPhone:self.photoTextField1.text];
            if (!isPhone) {
                [SVProgressHUD showErrorWithStatus:@"手机号格式不正确!"];
                return ;
            }
            // 检测验证码是否输入
            if (self.checkCountTextField.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
                [self.checkCountTextField becomeFirstResponder];
                return;
            }
            if (self.isAgree==NO) {
                [SVProgressHUD showErrorWithStatus:@"请勾选下方的协议"];
                return;
            }
            [[WCLLoginViewModel signalForLoginByPhone:self.photoTextField1.text withValidatePhone:self.checkCountTextField.text]subscribeNext:^(NSNumber* x) {
                if (x.boolValue) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"youhuiquanlistsucess" object:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
        if (self.rightBtn.selected){
            // 检测手机号码是否输入
            if (self.photoTextField1.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
                [self.photoTextField1 becomeFirstResponder];
                return;
            }
            
            // 检测密码是否输入
            if (self.passWordTextField.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
                [self.passWordTextField becomeFirstResponder];
                return;
            }
            if (self.passWordTextField.text.length < 6){
                [SVProgressHUD showErrorWithStatus:@"请输入6-16位密码"];
                [self.passWordTextField becomeFirstResponder];
                return;
            }
            
            
            //登录操作
            BOOL isPhone = [YBLMethodTools checkPhone:self.photoTextField1.text];
            if (!isPhone) {
                [SVProgressHUD showErrorWithStatus:@"手机号格式不正确!"];
                return ;
            }
            
            //登录操作
            NSString *phone = [self.photoTextField1.text substringFromIndex:self.photoTextField1.text.length-4];
//            WCLLog(@"%@",phone);
            NSString * md5 = [self md5:[NSString stringWithFormat:@"%@%@",self.passWordTextField.text,phone]];
            [[WCLLoginViewModel signalForLoginByPhone:self.photoTextField1.text withPassWord:md5 ]subscribeNext:^(NSNumber* x) {
                if (x.boolValue) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"youhuiquanlistsucess" object:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
            
        }
    }];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.backImageView1.mas_bottom).offset(-2);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(150);
    }];
    _agreeButton = [YBLButton new];
    [_agreeButton setImage:[UIImage imageNamed:@"icon_disagree_btn"] forState:UIControlStateNormal];
    [_agreeButton setImage:[UIImage imageNamed:@"icon_agree_btn"] forState:UIControlStateSelected];
    [_agreeButton setTitle:@"我已阅读并同意" forState:UIControlStateNormal];
    _agreeButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _agreeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_agreeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _agreeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_agreeButton setImageRect:CGRectMake(0, 5, 10, 10)];
    _agreeButton.selected = self.isAgree;
    [[_agreeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(YBLButton* x) {
        STRONG
        self.isAgree = !self.isAgree;
        x.selected = self.isAgree;
    }];
    [self.view addSubview:_agreeButton];
    [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(30);
        make.left.mas_equalTo(SCREEN_SCALE_Iphone6*60);
        make.height.mas_equalTo(17);
    }];
    NSString *text1 = @"《百大悦城用户服务协议》";
    UIButton *xieyiServiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xieyiServiceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [xieyiServiceButton setTitle:text1 forState:UIControlStateNormal];
    xieyiServiceButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [xieyiServiceButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [[xieyiServiceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        STRONG
        WCLRegisterProtocolVC2 * pvc = [[WCLRegisterProtocolVC2 alloc]init];
        pvc.hidesBottomBarWhenPushed =YES;
        pvc.navTitle = @"百大悦城注册协议";
        pvc.url = [NSString stringWithFormat:@"%@protocol",URL_H5];
        [self.navigationController pushViewController:pvc animated:YES];
    }];
    [self.view addSubview:xieyiServiceButton];
    _xieyiButton = xieyiServiceButton;
    [xieyiServiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.agreeButton.mas_right);
        make.centerY.equalTo(self.agreeButton.mas_centerY);
    }];
    
    
    
    
    UIButton * registBtn = [UIButton new];
//    [[registBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//        WCLRegisterViewController * rvc = [[WCLRegisterViewController alloc]init];
//        [self.navigationController pushViewController:rvc animated:YES];
//    }];
//    [registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [registBtn setTitleColor:[UIColor colorWithHexString:@"#990000"] forState:UIControlStateNormal];
    [self.view addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(13);
        make.right.equalTo(self.backImageView1.mas_right).offset(-10);
    }];
}
-(void)textFiledEditChanged:(NSNotification *)obj
{
    
    
    UITextField *textField = (UITextField *)obj.object;
    
    if (textField == _photoTextField1) {
        
        NSString *toBeString = textField.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > 11)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:11];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:11];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 11)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
            
        }
    }
    else if(textField==_passWordTextField)
    {
        NSString *toBeString = textField.text;
        if ([toBeString length] > 0 && [_photoTextField1.text length] >0) {
            _loginBtns.backgroundColor = [UIColor colorWithHexString:@"#990000"];
        } else {
            _loginBtns.backgroundColor = [UIColor colorWithHexString:@"#996B6B"];
        }
    }
    else if (textField ==_checkCountTextField)
    {
        NSString *toBeString = textField.text;
        if ([toBeString length] > 0 && [_checkCountTextField.text length] >0) {
            _loginBtns.backgroundColor = [UIColor colorWithHexString:@"#990000"];
        } else {
            _loginBtns.backgroundColor = [UIColor colorWithHexString:@"#996B6B"];
        }
    }
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
