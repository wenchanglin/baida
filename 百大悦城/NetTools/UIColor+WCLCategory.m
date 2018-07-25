//
//  UIColor+WCLCategory.m
//  ceshiRac
//
//  Created by 文长林 on 2018/5/9.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "UIColor+WCLCategory.h"

@implementation UIColor (WCLCategory)

+ (instancetype) colorWithHex:(NSUInteger)hexColor {
    return [UIColor colorWithHex:hexColor alpha:1.];
}
+ (instancetype)colorWithHex:(NSUInteger)hexColor alpha:(CGFloat)opacity {
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
+ (instancetype)colorWithHexString:(NSString *)hexStr {
    return [UIColor colorWithHexString:hexStr alpha:1.];
}
+ (instancetype)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)opacity {
    unsigned int hexint = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    return [UIColor colorWithHex:hexint alpha:opacity];
}

@end
