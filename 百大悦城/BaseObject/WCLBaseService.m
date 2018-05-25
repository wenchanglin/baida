//
//  WCLBaseService.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLBaseService.h"

@implementation WCLBaseService
+ (instancetype)serviceWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel{
    
    return [[self alloc] initWithVC:VC ViewModel:viewModel];
}

- (instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel{
    
    if (self = [super init]) {
        self.baseVc = VC;
    }
    return self;
}

@end
