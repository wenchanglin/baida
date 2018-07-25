//
//  ViewController.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/21.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+PopGestureRecognizer.h"
@interface ViewController : UIViewController

@property (nonatomic, strong) UIBarButtonItem *storeSettingButtonItem;
@property (nonatomic, strong) UIBarButtonItem *addButtonItem;
@property (nonatomic, strong) UIBarButtonItem *explainButtonItem;
@property (nonatomic, strong) UIBarButtonItem *shareBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *newsBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *moreBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *remandBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *nextButtonItem;
@property (nonatomic, strong) UIBarButtonItem *historyButtonItem;
@property (nonatomic, strong) UIBarButtonItem *saveButtonItem;


- (void)explainButtonItemClick:(UIBarButtonItem *)btn;
- (void)storeSettingButtonItemClick:(UIBarButtonItem *)btn;
- (void)shareClick:(UIBarButtonItem *)btn;
- (void)newsClick:(UIBarButtonItem *)btn;
- (void)moreClick:(UIBarButtonItem *)btn;
- (void)remandClick:(UIBarButtonItem *)btn;
- (void)nextClick:(UIBarButtonItem *)btn;
- (void)addClick:(UIBarButtonItem *)btn;
- (void)saveClick:(UIBarButtonItem *)btn;
-(void)showMesageWithString:(NSString*)message withDelay:(NSTimeInterval)time;
- (void)goback1;
//MD5加密方式
-(NSString *)md5:(NSString *)str;
- (void)setMyTranslucent:(BOOL)translucent;
/**毫秒*/
-(NSString*)getNowTimestamp;
//字符串转时间
-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr;
//时间转时间戳
-(NSString *)dateConversionTimeStamp:(NSDate *)date;



@end

