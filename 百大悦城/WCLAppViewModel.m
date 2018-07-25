//
//  WCLAppViewModel.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLAppViewModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
#import "WXApiManager.h"
#import "WeiboSDK.h"
#import "PageControlView.h"
//#import "StoresSearchVC.h"
#import "YBLUpdateVersionView.h"

@interface WCLAppViewModel()
@property(strong , nonatomic)PageControlView *pageControlV;
@end
static WCLAppViewModel * appView=nil;

//BMKMapManager* _mapManager;
@implementation WCLAppViewModel

+(WCLAppViewModel *)shareApp
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appView = [[WCLAppViewModel alloc]init];
    });
    return appView;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


-(void)finishLaunchOption:(NSDictionary *)option
{
  
    /* Share SDK */
    [ShareSDK registerApp:@"26b866b20dacc"
          activePlatforms:@[
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformSubTypeQQFriend),
                            @(SSDKPlatformTypeSinaWeibo)
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                            [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                      
                      
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wxde304ec90e9db692"
                                            appSecret:@"2bf6169f6504c7ecf3cec586de20ae5c"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"1106903897"//
                                           appKey:@"MOnjZRpob2q70TZE"
                                         authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeSinaWeibo:
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"193484684" appSecret:@"27049a63f30eaf0047241e320134c08d" redirectUri:@"http://yjwang.wamlle.com" authType:SSDKAuthTypeWeb];
                      break;
                  default:
                      break;
              }
          }];
    /**
     *  HUD 设置
     */
    [self setUpSvpProgress];
    //验证用户是否登录
//    [[WCLLoginViewModel signalForPerson]subscribeNext:^(NSNumber* x) {
//    }];
    /**第一次进入程序*/
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    /**
     *  数组越界
     */
//        [AvoidCrash becomeEffective];
    /**
     *  键盘
     */
    [IQKeyboardManager sharedManager].previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide;
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    [IQKeyboardManager sharedManager].toolbarTintColor = YBLColor(40, 40, 40, 1);
//    /**
//     *  导航栏设置
//     */
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:YBLColor(40, 40, 40, 1),
                                                           NSFontAttributeName:YBLFont(18)}];
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attrs[NSForegroundColorAttributeName] = YBLColor(70, 70, 70, 1);
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    /**
     *  检查更新
     */
    [self checkAppVersion];
   
    
}


//初始化提示框
- (void)setUpSvpProgress {
    
    [[UIButton appearance] setExclusiveTouch:YES];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"hud_error"]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"hud_success"]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setCornerRadius:8];
//    [SVProgressHUD setBackgroundColor:YBLColor(0, 0, 0, 0.6)];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setFont:YBLFont(16)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    CGFloat wi = YBLWindowWidth/3-space;
    [SVProgressHUD setMinimumSize:CGSizeMake(wi, wi)];
    
}
- (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}
- (void)checkAppVersion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString * URL = nil;
        if ([[self getPreferredLanguage] hasPrefix:@"zh-"]) {
            URL = @"https://itunes.apple.com/search?term=百大悦城&country=cn&entity=software";
            URL = [URL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        }
        else //en-US 英文版
        {
            URL = @"http://itunes.apple.com/lookup?id=1084967248";//1159191582 1084967248
        }
       
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
        if (!data) {
            return ;
        }
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        jsonDict = [jsonDict[@"results"] firstObject];
        
        if (!error && jsonDict) {
            NSString *newVersion =jsonDict[@"version"];
            NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
            
            NSString *dot = @".";
            NSString *whiteSpace = @"";
            int newV = [newVersion stringByReplacingOccurrencesOfString:dot withString:whiteSpace].intValue;
            int nowV = [nowVersion stringByReplacingOccurrencesOfString:dot withString:whiteSpace].intValue;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(newV > nowV)
                {
        
                    //需要更新
                    YBLUpdateReaseNotModel *notModel = [YBLUpdateReaseNotModel new];
                    notModel.releaseNot = jsonDict[@"releaseNotes"];
                    notModel.version =jsonDict[@"version"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:App_Notification_Version object:nil userInfo:@{@"model":notModel}];
                }
                
            });
        }
    });
    
    
}

- (void)showLaunchAnimationView{
    
    BOOL noFirstLaunch = [[[NSUserDefaults standardUserDefaults] objectForKey:NO_FIRST_LAUNCH_KEY] boolValue];
    if (noFirstLaunch) {
        //正常动画
        [self showAnimationLaunchImageView];
    } else {
        //引导页
        [self showGuideView];
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:NO_FIRST_LAUNCH_KEY];
    }
}

- (void)showGuideView{
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 1; i < 4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@%@",@"LaunchIntrudutionImage",@(i)];
        [imageArray addObject:imageName];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _pageControlV = [[PageControlView instance] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andImageList:imageArray];
    [window addSubview:self.pageControlV];
}



- (void)showAnimationLaunchImageView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    __block UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage getTheLaunchImage]];
    launchView.frame = window.bounds;
    launchView.contentMode = UIViewContentModeScaleAspectFill;
    launchView.userInteractionEnabled = NO;
    [window addSubview:launchView];
    
    UIImage *launchImage = [UIImage imageNamed:@"loadding_line"];
    UIImageView *launchbgImageView = [[UIImageView alloc] initWithImage:launchImage];
    launchbgImageView.frame = CGRectMake(0, 0, launchImage.size.width, launchImage.size.height);
    launchbgImageView.center = launchView.center;
    [launchView addSubview:launchbgImageView];
    
    UIImage *launchProgressArrowImage = [UIImage imageNamed:@"launchProgressIcon"];
    UIImageView *launchProgressArrowImageView = [[UIImageView alloc] initWithImage:launchProgressArrowImage];
    launchProgressArrowImageView.frame = CGRectMake(0, 0, launchProgressArrowImage.size.width, launchProgressArrowImage.size.height);
    launchProgressArrowImageView.center = CGPointMake(launchProgressArrowImage.size.width/2, launchbgImageView.height/2);
    [launchbgImageView addSubview:launchProgressArrowImageView];
    
    [UIView animateWithDuration:0.7f
                          delay:0.7f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         launchProgressArrowImageView.left = launchbgImageView.width-launchProgressArrowImageView.width*1.5;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0f
                                               delay:0.5f
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              launchView.alpha = 0.0f;
                                              launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2, 1.2, 1);
                                          }
                                          completion:^(BOOL finished) {
                                              [launchView removeFromSuperview];
                                              launchView = nil;
                                          }];
                     }];
    
}




@end
