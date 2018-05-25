//
//  WCLBaseService.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLBaseService : NSObject
@property (nonatomic, weak) UIViewController *baseVc;

- (instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel;

+ (instancetype)serviceWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel;


@end
