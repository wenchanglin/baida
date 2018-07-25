//
//  ViewController.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/21.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "ViewController.h"
#import "WCLMainScanViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setIsPopGestureRecognizerEnable:YES];
    
    NSString *title = [self getSelfVcTitle];
    //    [TalkingData trackPageEnd:title];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setIsPopGestureRecognizerEnable:YES];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSString *title = [self getSelfVcTitle];
    //    [TalkingData trackPageBegin:title];
}

#pragma mark - 获取当前时间的 时间戳

-(NSString*)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
    
}
-(void)showMesageWithString:(NSString*)message withDelay:(NSTimeInterval)time
{
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD dismissWithDelay:time];
}
- (NSString *)getSelfVcTitle{
    
    NSString *selfVcTitle = self.title;
    if (!selfVcTitle) {
        selfVcTitle = self.navigationItem.title;
    }
    if (!selfVcTitle) {
        selfVcTitle = NSStringFromClass([self class]);
    }
    return selfVcTitle;
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem *backItem;
    if (self.navigationController.viewControllers.count > 1) {
        if ([[self getSelfVcTitle] isEqualToString:@"电子会员卡"]||[[self getSelfVcTitle] isEqualToString:@"WCLMainScanViewController"]) {
            backItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginal:@"back_withe"] style:UIBarButtonItemStyleDone target:self action:@selector(goback1)];
        }
        else
        {
            backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginal:@"icon_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(goback1)];
        }
        self.navigationItem.leftBarButtonItem = backItem;
    }
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"GeTui" object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        NSDictionary *message = [self dictionaryWithJsonString:[x.userInfo stringForKey:@"message"]];
        WCLLog(@"%@",message);
        switch ([message integerForKey:@"type"]) {
//            case 1:
//            {
//                MCListViewController *MCList = [[MCListViewController alloc] init];
//                MCList.mc_Id = [message stringForKey:@"type"];
//                [self.navigationController pushViewController:MCList animated:NO];
//            }
//                break;
//            case 2:
//
//            {
//                MainTabBanerDetailViewController *mainBaner = [[MainTabBanerDetailViewController alloc] init];
//
//                mainBaner.titleContent = [message stringForKey:@"title"];
//                mainBaner.imageUrl = [message stringForKey:@"img_url"];
//                mainBaner.webLink = [message stringForKey:@"link"];
//                mainBaner.shareLink = [message stringForKey:@"share_link"];
//                [self.navigationController pushViewController:mainBaner animated:YES];
//            }
//
//                break;
//            case 3:
//            {
//                mcWuLiuViewController *list = [[mcWuLiuViewController alloc] init];
//                list.mc_Id = [message stringForKey:@"type"];
//                [self.navigationController pushViewController:list animated:YES];
//
//            }
//                break;
//            case 4:
//            {
//                MainTabDetailViewController *MainDetail = [[MainTabDetailViewController alloc] init];
//                MainDetail.webId = [message stringForKey:@"id"];
//                MainDetail.imageUrl = [message stringForKey:@"img_url"];
//                MainDetail.titleContent = [message stringForKey:@"title"];
//                [self.navigationController pushViewController:MainDetail animated:YES];
//            }
//                break;
//            case 5:
//            {
//                DesignersClothesViewController *designerClothes = [[DesignersClothesViewController alloc] init];
//                designerClothes.imageUrl = [message stringForKey:@"img_url"];
//                designerClothes.good_Id = [message stringForKey:@"id"];
//                designerClothes.clothesTitle = [message stringForKey:@"title"];
//                designerClothes.clothesContent = [message stringForKey:@"content"];
//                [self.navigationController pushViewController:designerClothes animated:YES];
//            }
//                break;
//            case 6:
//            {
//                DesignerDetailIntroduce *introduce = [[DesignerDetailIntroduce alloc] init];
//                introduce.desginerId = [message stringForKey:@"id"];
//                introduce.designerImage = [message stringForKey:@"img_url"];
//                introduce.designerName = [message stringForKey:@"title"];
//                introduce.remark = [message stringForKey:@"content"];
//                [self.navigationController pushViewController:introduce animated:YES];
//
//            }
//
//
//                break;
//            case 7:
//            {
//                ToBuyCompanyClothes_SecondPlan_ViewController *toBuy = [[ToBuyCompanyClothes_SecondPlan_ViewController alloc] init];
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                [dic setObject:[message stringForKey:@"id"] forKey:@"id"];
//                [dic setObject:[message stringForKey:@"title"] forKey:@"name"];
//                [dic setObject:[message stringForKey:@"img_url"] forKey:@"thumb"];
//                [dic setObject:[message stringForKey:@"type"] forKey:@"type"];
//                toBuy.goodDic = dic;
//                [self.navigationController pushViewController:toBuy animated:YES];
//            }
//                break;
            default:
                break;
        }
    }];
}
- (void)dealloc
{
    NSLog(@"%@---dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//MD5加密方式
-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5( cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:
            
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
}

- (void)goback1 {
    [self.navigationController popViewControllerAnimated:YES];
}

static bool myTranslucent = YES;

- (void)setMyTranslucent:(BOOL)translucent {
    if (myTranslucent == translucent) {
        return;
    }
    myTranslucent = translucent;
    self.navigationController.navigationBar.translucent = myTranslucent;
    if (translucent) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:YBLColor(255, 255, 255, 0.99) frame:CGRectMake(0, 0, YBLWindowWidth, kNavigationbarHeight)] forBarMetrics:UIBarMetricsDefault];
    }else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:YBLColor(255, 255, 255, 1.0) frame:CGRectMake(0, 0, YBLWindowWidth, kNavigationbarHeight)] forBarMetrics:UIBarMetricsDefault];
    }
}

- (UIBarButtonItem *)storeSettingButtonItem{
    
    if (!_storeSettingButtonItem) {
        UIImage *categoryImage = [UIImage newImageWithNamed:@"bar_store_setting" size:(CGSize){21,21}];
        UIBarButtonItem *storeButtonItem = [[UIBarButtonItem alloc] initWithImage:categoryImage
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self
                                                                           action:@selector(storeSettingButtonItemClick:)];
        storeButtonItem.tintColor = YBLColor(130, 130, 130, 1);
        _storeSettingButtonItem = storeButtonItem;
    }
    return _storeSettingButtonItem;
}

- (UIBarButtonItem *)explainButtonItem {
    if (!_explainButtonItem) {
        //
        UIImage *categoryImage = [UIImage newImageWithNamed:@"explain_icon" size:(CGSize){23,23}];
        UIBarButtonItem *categoryButtonItem = [[UIBarButtonItem alloc] initWithImage:categoryImage
                                                                               style:UIBarButtonItemStyleDone
                                                                              target:self
                                                                              action:@selector(explainButtonItemClick:)];
        categoryButtonItem.tintColor = YBLColor(130, 130, 130, 1);
        _explainButtonItem = categoryButtonItem;
    }
    return _explainButtonItem;
}
- (UIBarButtonItem *)addButtonItem {
    if (!_addButtonItem) {
        //
        UIBarButtonItem *add_item = [[UIBarButtonItem alloc] initWithImage:[UIImage newImageWithNamed:@"good_manage_add" size:CGSizeMake(26, 26)]
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(addClick:)];
        add_item.tintColor = YBLTextColor;
        _addButtonItem = add_item;
    }
    return _addButtonItem;
}

- (UIBarButtonItem *)nextButtonItem {
    if (!_nextButtonItem) {
        UIBarButtonItem *nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(nextClick:)];
        _nextButtonItem.tintColor = YBLColor(130, 130, 130, 1);
        _nextButtonItem = nextButtonItem;
    }
    return _nextButtonItem;
}


- (UIBarButtonItem *)shareBarButtonItem {
    if (!_shareBarButtonItem) {
        //分享
        UIImage *shareImage = [UIImage newImageWithNamed:@"icon_header_share" size:(CGSize){22,22}];
        UIBarButtonItem *shareBarButtonItem    = [[UIBarButtonItem alloc] initWithImage:shareImage
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(shareClick:)];
        shareBarButtonItem.tintColor = YBLColor(130, 130, 130, 1);
        _shareBarButtonItem = shareBarButtonItem;
    }
    return _shareBarButtonItem;
    
}

- (UIBarButtonItem *)newsBarButtonItem {
    if (!_newsBarButtonItem) {
        //消息
        UIImage *newImage = [UIImage newImageWithNamed:@"bar_news" size:(CGSize){22,22}];
        UIBarButtonItem *newsBarButtonItem    = [[UIBarButtonItem alloc] initWithImage:newImage
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(newsClick:)];
        newsBarButtonItem.tintColor = YBLColor(130, 130, 130, 1);
        _newsBarButtonItem = newsBarButtonItem;
    }
    return _newsBarButtonItem;
}

- (UIBarButtonItem *)moreBarButtonItem {
    if (!_moreBarButtonItem) {
        //更多
        UIImage *moreImage = [UIImage newImageWithNamed:@"bar_more" size:(CGSize){21,21}];
        UIBarButtonItem *moreBarButtonItem    = [[UIBarButtonItem alloc] initWithImage:moreImage
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(moreClick:)];
        moreBarButtonItem.tintColor = YBLColor(130, 130, 130, 1);
        _moreBarButtonItem = moreBarButtonItem;
    }
    return _moreBarButtonItem;
}


- (UIBarButtonItem *)remandBarButtonItem{
    if (!_remandBarButtonItem) {
        UIImage *remandImage = [UIImage newImageWithNamed:@"seckill_remand" size:(CGSize){21,21}];
        UIBarButtonItem *moreBarButtonItem = [[UIBarButtonItem alloc] initWithImage:remandImage
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(remandClick:)];
        moreBarButtonItem.tintColor = YBLColor(130, 130, 130, 1);
        _remandBarButtonItem = moreBarButtonItem;
    }
    return _remandBarButtonItem;
}

- (UIBarButtonItem *)saveButtonItem{
    if (!_saveButtonItem) {
        UIBarButtonItem *moreBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(saveClick:)];
        moreBarButtonItem.tintColor = YBLColor(130, 130, 130, 1);
        _saveButtonItem = moreBarButtonItem;
    }
    return _saveButtonItem;
}
//时间转时间戳
-(NSString *)dateConversionTimeStamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return timeSp;
}
//字符串转时间
-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}
- (void)explainButtonItemClick:(UIBarButtonItem *)btn{
}
- (void)shareClick:(UIBarButtonItem *)btn{
}
- (void)newsClick:(UIBarButtonItem *)btn{
}
- (void)moreClick:(UIBarButtonItem *)btn{
}
- (void)remandClick:(UIBarButtonItem *)btn{
}
- (void)nextClick:(UIBarButtonItem *)btn{
}
- (void)storeSettingButtonItemClick:(UIBarButtonItem *)btn{
}
- (void)addClick:(UIBarButtonItem *)btn{
}
- (void)saveClick:(UIBarButtonItem *)btn{
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
