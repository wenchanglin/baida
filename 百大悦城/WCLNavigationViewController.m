//
//  WCLNavigationViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLNavigationViewController.h"
#import "YBLNetWorkHudBar.h"

@interface WCLNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    BOOL isEnable;
}
@property (nonatomic, strong) NSArray *classNameArray;

@property (nonatomic, strong) NSArray *homeTopClassNameArray;
@end

@implementation WCLNavigationViewController
- (void)setIsPopGestureRecognizerEnable:(BOOL)isPopGestureRecognizerEnable{
    isEnable = isPopGestureRecognizerEnable;
}

/**
 * 定制UINavigationBar
 */
+ (void)initialize {
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    [navigationBar setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName:YBLColor(40, 40, 40, 1.0),
                                            NSFontAttributeName:[UIFont systemFontOfSize:17],
                                            NSShadowAttributeName:shadow
                                            }];
    [navigationBar setBackgroundImage:[UIImage createImageWithColor:YBLColor(255, 255, 255, 1) frame:CGRectMake(0, 0, YBLWindowWidth, kNavigationbarHeight)] forBarMetrics:UIBarMetricsDefault];//alpha 0.99
    [navigationBar setShadowImage:[UIImage new]];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    for (NSString *className in self.homeTopClassNameArray) {
//        if ([self.visibleViewController isKindOfClass:NSClassFromString(className)]) {
//            //
//            [self requestCartNumber];
//        }
//    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //添加一条线
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, YBLWindowWidth, 0.5)];
//    lineView.backgroundColor = YBLColor(230, 230, 230, 1.0);
//    lineView.tag = 999;
//    [self.navigationBar addSubview:lineView];
    
    __weak WCLNavigationViewController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate = weakSelf;
    }
}

- (void)requestCartNumber{
    
    //    [YBLShopCarViewModel getCurrentCartsNumber];
}

- (NSArray *)classNameArray{
    if (!_classNameArray) {
        _classNameArray = @[@"YBLCategoryViewController",
                            @"YBLProfileViewController",
                            @"YBLHomeViewController",
                            @"YBLStoreSelectBannerViewController",
                            @"YBLOrderExpressImageBrowerVC",
                            @"YBLScanQRCodeViewController"];
    }
    return _classNameArray;
}

- (NSArray *)homeTopClassNameArray{
    if (!_homeTopClassNameArray) {
        _homeTopClassNameArray = @[
                                   @"WCLMainScanViewController",
//                                   @"WCLActivityViewController",
//                                   @"YBLShopCarViewController",
//                                   @"WCLMineViewController"
                                   ];
    }
    return _homeTopClassNameArray;
}

#pragma mark -

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated

{
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]&& animated == YES ){
        
        self.interactivePopGestureRecognizer.enabled = NO;
        
    }
    
    return [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
        
        self.interactivePopGestureRecognizer.enabled = NO;
        
    }
    
    return [super popToViewController:viewController animated:animated];
    
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        
        if (navigationController.childViewControllers.count == 1) {
            
            self.interactivePopGestureRecognizer.enabled = NO;
            
        }else
            
            self.interactivePopGestureRecognizer.enabled = isEnable;
        
    }
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = NO;
    for (NSString *className in self.classNameArray) {
        if ([viewController isKindOfClass:[NSClassFromString(className) class]]){
            isShowHomePage = YES;
        }
    }
    [viewController.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


- (void)dealloc
{
    NSLog(@"%@----dealloc",self.class);
    
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
