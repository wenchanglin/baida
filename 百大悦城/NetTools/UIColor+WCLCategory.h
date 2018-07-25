//
//  UIColor+WCLCategory.h
//  ceshiRac
//
//  Created by 文长林 on 2018/5/9.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIColor (WCLCategory)
+ (instancetype)colorWithHex:(NSUInteger)hexColor;
+ (instancetype)colorWithHexString:(NSString *)hexStr;
+ (instancetype)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)opacity;


@end
