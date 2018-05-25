//
//  WCLAppViewModel.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLAppViewModel : NSObject
+(WCLAppViewModel *)shareApp;
@property(nonatomic,strong)UIViewController * VC;
- (void)finishLaunchOption:(NSDictionary *)option;

- (void)showLaunchAnimationView;

- (UINavigationController *)getNavigationCWithWindow:(UIWindow *)window;

@end
