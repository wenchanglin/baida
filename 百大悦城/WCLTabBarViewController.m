//
//  WCLTabBarViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLTabBarViewController.h"
#import "WCLNavigationViewController.h"
#import "WCLHomeViewController.h"
#import "WCLActivityViewController.h"
#import "WCLFindViewController.h"
#import "WCLMineViewController.h"
@interface WCLTabBarViewController ()

@end

@implementation WCLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    // 添加所有的子控制器
    [self addAllChildVcs];
    //观察购物车角标
//    [self notifiCarNumber];
}
/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    WCLHomeViewController *home = [[WCLHomeViewController alloc] init];
    WCLNavigationViewController *nav1 = [[WCLNavigationViewController alloc] initWithRootViewController:home];
    [self addOneChlildVc:nav1 title:@"首页" imageName:@"tabBar_home_normal" selectedImageName:@"tabBar_home_press"];
    WCLActivityViewController * activity =[[WCLActivityViewController alloc]init];
    WCLNavigationViewController *nav2 = [[WCLNavigationViewController alloc] initWithRootViewController:activity];
    [self addOneChlildVc:nav2 title:@"活动" imageName:@"tabBar_activity_normal" selectedImageName:@"tabBar_activity_press"];
    WCLFindViewController * find =[[WCLFindViewController alloc]init];
//    WCLNavigationViewController *nav3 = [[WCLNavigationViewController alloc] initWithRootViewController:find];
    [self addOneChlildVc:find title:@"发现" imageName:@"tabBar_find_normal" selectedImageName:@"tabBar_find_press"];
    WCLMineViewController * mine =[[WCLMineViewController alloc]init];
    [self addOneChlildVc:mine title:@"我的" imageName:@"tabBar_my_normal" selectedImageName:@"tabBar_my_press"];
    
//    YBLCategoryViewController *category = [[YBLCategoryViewController alloc] init];
//    //    category.viewModel = category_viewModel;
//    [self addOneChlildVc:category title:@"分类" imageName:@"tabBar_category_normal" selectedImageName:@"tabBar_category_press"];
    

//
//    YBLProfileViewController *me = [[YBLProfileViewController alloc] init];
//    [self addOneChlildVc:me title:@"我的" imageName:@"tabBar_my_normal" selectedImageName:@"tabBar_my_press"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    childVc.tabBarItem.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithOriginal:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithOriginal:selectedImageName];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    //调整tabbarItem  图片的位置
    [childVc.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateSelected];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#999999"]} forState:UIControlStateNormal];
    // 添加为tabbar控制器的子控制器
    
    [self addChildViewController:childVc];
}
//- (void)notifiCarNumber {
//    WEAK
//    [RACObserve([YBLUserManageCenter shareInstance], cartsCount) subscribeNext:^(id x) {
//        STRONG
//        [self.tabBar setBadgeValue:[YBLUserManageCenter shareInstance].cartsCount AtIndex:3];
//    }];
//}
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
