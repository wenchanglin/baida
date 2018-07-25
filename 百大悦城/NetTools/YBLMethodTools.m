//
//  YBLMethodTools.m
//  YBL365
//
//  Created by wcl on 2016/12/17.
//  Copyright © 2016年 wcl. All rights reserved.
//

#import "YBLMethodTools.h"
//#import "YBLSaveManyImageTools.h"
//#import "YBLFoundTabBarViewController.h"
//#import "YBLAddressAreaModel.h"
//#import "YBLCompanyTypePricesParaModel.h"
#import "WCLLoginViewController.h"
//#import "YBLNavigationViewController.h"
//#import "YBLpurchaseInfosModel.h"
//#import "YBLGetProductShippPricesModel.h"
#import "WCLWebViewController.h"
//#import "YBLTakeOrderParaItemModel.h"
//#import "YYImageCache.h"
//#import "YYWebImage.h"
//#import "YBLGoodModel.h"
#import "POP.h"
//#import "YBLAdsModel.h"
//#import "YBLGoodsDetailViewController.h"
//#import "YBLStoreViewController.h"
//#import "YBLMineMillionMessageItemModel.h"

@implementation YBLOrderPropertyModel

- (id)mutableCopyWithZone:(NSZone *)zone{
    return [self copyWithZone:zone];
}
- (id)copyWithZone:(NSZone *)zone
{
    //实现自定义浅拷贝
    YBLOrderPropertyModel *property = [[self class] allocWithZone:zone];
    property.order_state = [_order_state mutableCopy];
    property.orderStateCount = [_orderStateCount mutableCopy];
    property.purchaseOrderStateCount = [_purchaseOrderStateCount mutableCopy];
    return property;
}

+ (YBLOrderPropertyModel *)getPropertyModelWithState:(NSString *)state Count:(NSArray *)count purchaseCount:(NSArray *)purchaseCount{
    
    YBLOrderPropertyModel *property = [YBLOrderPropertyModel new];
    property.order_state = state;
    property.orderStateCount = [count mutableCopy];
    property.purchaseOrderStateCount = [purchaseCount mutableCopy];
    return property;
}

@end

@implementation YBLOrderPropertyItemModel

+ (YBLOrderPropertyItemModel *)getItemModelWithOrderState:(NSString *)order_state
                                             order_action:(NSString *)order_action
                                       order_button_title:(NSString *)order_button_title{
    
    YBLOrderPropertyItemModel *itemModel = [YBLOrderPropertyItemModel new];
    itemModel.order_state = order_state;
    itemModel.order_action = order_action;
    itemModel.order_button_title = order_button_title;
    return itemModel;
}

@end

static NSMutableArray *_seller_orderManager;
static NSMutableArray *_buyer_orderManager;

@implementation YBLMethodTools

+ (void)initialize{
}

+ (void) popAnimationWithView:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

+ (void)addAnimationWith:(UIView *)view
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(10.f, 10.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 22.0f;
    scaleAnimation.springSpeed = 20;
    [view.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
    [scaleAnimation setCompletionBlock:^(POPAnimation * anim , BOOL finsih){
        
    }];
}


+(CABasicAnimation *) AlphaLight:(float)time
{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    return animation;
}

+ (CATransform3D)transformFirstViewLayer{

    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 10.0 * M_PI/180.0, 1, 0, 0);
    return t1;
}

+ (CATransform3D)transformSecondViewLayer{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [YBLMethodTools transformFirstViewLayer].m34;
    t2 = CATransform3DTranslate(t2, 0, YBLWindowHeight * (-0.01), 0);
    t2 = CATransform3DScale(t2, 0.9, 0.9, 1);
    return t2;
}

+ (NSMutableArray *)getSeckillTimeWithNewTime:(NSString *)time{
    
    NSArray *timeArray = @[@"00:00",@"08:00",@"12:00",@"16:00",@"20:00"];
    //    NSString *testTimeString = @"00:00";
    NSMutableArray *timeArray_1 =  [[NSMutableArray alloc] initWithCapacity:timeArray.count];
    [timeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([time isEqualToString:(NSString *)obj]) {
            NSRange range = NSMakeRange(idx, timeArray.count-idx);
            NSArray* l_array = [timeArray subarrayWithRange:range];
            [timeArray_1 addObjectsFromArray:l_array];
            NSRange range1 = NSMakeRange(0, idx);
            NSArray* l_array1 = [timeArray subarrayWithRange:range1];
            [timeArray_1 addObjectsFromArray:l_array1];
        }
        
    }];
    
    return timeArray_1;
}

+ (void)transformOpenView:(UIView *)view SuperView:(UIView *)sview fromeVC:(UIViewController *)vc Top:(CGFloat)top{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.backgroundColor = [UIColor blackColor];
    [keyWindow addSubview:sview];
    sview.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:.35f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         vc.view.layer.transform = [YBLMethodTools transformFirstViewLayer];
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:.4f
                                               delay:0
                              usingSpringWithDamping:.85f
                               initialSpringVelocity:0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              
                                              vc.view.layer.transform = [YBLMethodTools transformSecondViewLayer];
                                              sview.backgroundColor = YBLColor(0, 0, 0, 0.4);
                                              view.top = top;
                                          }
                                          completion:^(BOOL finished) {
                                              sview.userInteractionEnabled = YES;
                                          }];
                         
                     }];

    
}

+ (void)transformCloseView:(UIView *)view SuperView:(UIView *)sview fromeVC:(UIViewController *)vc Top:(CGFloat)top completion:(void (^)(BOOL finished))completion{
    
    sview.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         vc.view.layer.transform = [YBLMethodTools transformFirstViewLayer];
                          sview.backgroundColor = YBLColor(0, 0, 0, 0);
                         view.top = top;
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:.34f
                                               delay:0
                              usingSpringWithDamping:10
                               initialSpringVelocity:5
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              vc.view.layer.transform = CATransform3DIdentity;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                                              keyWindow.backgroundColor = [UIColor whiteColor];
                                              
                                              sview.userInteractionEnabled = YES;
                                              
                                              if (finished) {
                                                  completion(finished);
                                              }
                                              
                                          }];
                         
                     }];

    
}

+ (UIImage *)addTextLabel:(UILabel *)textLabel
              AndQrcImage:(UIImage *)qrcImage
              ToGoodImage:(UIImage *)goodImage{

    UIGraphicsBeginImageContext(goodImage.size);
    
    UIImage *baiseImage = [UIImage imageNamed:@"baise"];
    
    CGFloat goodImageWi = goodImage.size.width;
    CGFloat goodImageHi = goodImage.size.height;
    
    CGFloat qrcImageWi = (double)goodImageWi/9;
    CGFloat qrcImageHi = qrcImageWi;

    //原图
    [goodImage drawInRect:CGRectMake(0, 0, goodImageWi, goodImageHi)];
    //二维码
    [baiseImage drawInRect:CGRectMake(goodImageWi-qrcImageWi-10, goodImageHi-qrcImageHi-10, qrcImageWi+5, qrcImageHi+5)];
    [qrcImage drawInRect:CGRectMake(goodImageWi-qrcImageWi-7.5, goodImageHi-qrcImageHi-7.5, qrcImageWi, qrcImageHi)];
    //label
    if (textLabel.text.length>0) {
        
        textLabel.size = CGSizeMake(goodImageWi-30-qrcImageWi, qrcImageWi/3);
        UIImage *labelImage = [UIImage imageWithUIView:textLabel];
        CGFloat labelImageHi = labelImage.size.height;
        CGFloat labelImageWi = labelImage.size.width;
        [labelImage drawInRect:CGRectMake(10, goodImageHi-labelImageHi-15, labelImageWi, labelImageHi)];
    } 
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

//+ (UIImage *)addLabelWithModel:(YBLSystemSocialModel *)model
//                   AndQRCImage:(UIImage *)qrcImage
//                   ToGoodImage:(UIImage *)goodImage{
//
//    return [self getResultImageWithModel:model
//                                qrcImage:qrcImage
//                               goodImage:goodImage
//                           iconImageName:@"share_caigou_icon"];
//}


//+ (UIImage *)addQRCImage:(UIImage *)qrcImage ToImage:(UIImage *)image{
//
//    return [self getResultImageWithModel:nil
//                                qrcImage:qrcImage
//                               goodImage:image
//                           iconImageName:@"share_yuncai_icon"];
//
//}

//+ (UIImage *)getResultImageWithModel:(YBLSystemSocialModel *)model
//                            qrcImage:(UIImage *)qrcImage
//                           goodImage:(UIImage *)goodImage
//                       iconImageName:(NSString *)iconImageName{
//
//    UIImageView *goodImageView = [[UIImageView alloc] initWithImage:goodImage];
//    goodImageView.frame = CGRectMake(0, 0, 800, 800);
//    CGFloat tempHi = goodImageView.image.size.width;
//    if (tempHi==0) {
//        tempHi = 800;
//    }
//    CGFloat finalHeight = (double)goodImageView.image.size.height/tempHi *goodImageView.width;
//    goodImageView.height = finalHeight;
//
//    UIImageView *qrcImageView = [[UIImageView alloc] initWithImage:qrcImage];
//    qrcImageView.backgroundColor = [UIColor whiteColor];
//    qrcImageView.frame = CGRectMake(0, 0, 120, 120);
//    qrcImageView.bottom = goodImageView.height-space;
//    [goodImageView addSubview:qrcImageView];
//
//    UIImage *iconImage = [UIImage imageNamed:iconImageName];
//    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
//    iconImageView.frame = CGRectMake(space, space, iconImage.size.width*2, iconImage.size.height*2);
//    [goodImageView addSubview:iconImageView];
//
//    if (model) {
//
//        qrcImageView.left = space;
//
//        NSString *price_1 = [NSString stringWithFormat:@"%.2f",model.price.floatValue*model.quantity.integerValue];
//        NSMutableAttributedString *priceString = [NSString price:price_1 color:YBLThemeColor font:30];
//        CGSize priceSize = [price_1 heightWithFont:YBLFont(30) MaxWidth:200];
//        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImageView.bottom+space+priceSize.width/2, priceSize.width+space*4, priceSize.height)];
//        priceLabel.attributedText = priceString;
//        priceLabel.centerX = iconImageView.centerX;
//        [goodImageView addSubview:priceLabel];
//        priceLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
//
//    } else {
//
//        qrcImageView.right = goodImageView.width-space;
//        iconImageView.right = qrcImageView.right;
//
//        UILabel *logenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImageView.bottom+space, 25, 100)];
//        logenLabel.centerX = iconImageView.centerX;
//        logenLabel.verticalText = Yuncai_Slog_string;
//        logenLabel.font = YBLFont(25);
//        logenLabel.textColor = YBLTextColor;
//        [goodImageView addSubview:logenLabel];
//        CGSize logenSize = [logenLabel.text heightWithFont:YBLFont(25) MaxWidth:200];
//        logenLabel.height = logenSize.height;
//
//    }
//
//    UIImage *resultImage = [UIImage imageWithUIView:goodImageView];
//
//    return resultImage;
//}

+ (void)callWithNumber:(NSString *)number{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",number];
    [self OpenURL:[NSURL URLWithString:str]];
}

+ (UIButton *)getContactKefuButtonWithFrame:(CGRect)frame{
    
    UIButton *contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
    contactButton.frame = frame;
    contactButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    NSString *textString = @"遇到问题?您可以联系客服";
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:textString];
    [string1 addAttributes:@{NSFontAttributeName:YBLFont(12),
                             NSForegroundColorAttributeName:YBLColor(176, 176, 176, 1)}
                     range:NSMakeRange(0, textString.length-4)];
    [string1 addAttributes:@{NSFontAttributeName:YBLFont(13),
                             NSForegroundColorAttributeName:[UIColor blueColor],
//                             NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                             }
                     range:NSMakeRange(textString.length-4, 4)];
    [contactButton setAttributedTitle:string1 forState:UIControlStateNormal];

    return contactButton;
}

+ (UIButton *)getNextButtonWithFrame:(CGRect)frame{
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = frame;
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitle:@"下一步" forState:UIControlStateDisabled];
    nextButton.titleLabel.font = YBLFont(16);
    nextButton.layer.cornerRadius = 3;
    nextButton.layer.masksToBounds = YES;
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setTitleColor:YBLColor(212, 212, 212, 1) forState:UIControlStateDisabled];
//    [nextButton setBackgroundColor:YBLThemeColor forState:UIControlStateNormal];
//    [nextButton setBackgroundColor:YBLColor(238, 238, 238, 1) forState:UIControlStateDisabled];

    return nextButton;
}


+ (UIButton *)getFurtureMoneyButtonWithFrame:(CGRect)frame{
    
    UIButton *furtureMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    furtureMoneyButton.frame = frame;
    [furtureMoneyButton setImage:[UIImage imageNamed:@"money_icon"] forState:UIControlStateNormal];
    return furtureMoneyButton;
}

+ (UIButton *)getFangButtonWithFrame:(CGRect)frame{
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = frame;
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setTitleColor:YBLColor(212, 212, 212, 1) forState:UIControlStateDisabled];
//    [doneButton setBackgroundColor:YBLThemeColor forState:UIControlStateNormal];
//    [doneButton setBackgroundColor:YBLColor(238, 238, 238, 1) forState:UIControlStateDisabled];
    doneButton.titleLabel.font = YBLFont(16);
    return doneButton;
}

+ (UIView *)addLineView:(CGRect)frame{
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = YBLLineColor;
    return line;
}

+ (UIView *)getSuperShadowViewWithFrame:(CGRect)frame{
    
    UIView *shadowView = [[UIView alloc]initWithFrame:frame];
    
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    
    shadowView.layer.shadowOpacity = 1;
    
    shadowView.layer.shadowRadius = 9.0;
    
    shadowView.layer.cornerRadius = shadowView.width/2;
    
    shadowView.clipsToBounds = NO;
    
    return shadowView;
}

+ (void)addTopShadowToGoodView:(UIView *)view{
    
    view.layer.shadowColor = YBLColor(70, 70, 70, 1).CGColor;//shadowColor阴影颜色
    view.layer.shadowOpacity = 0.4;//阴影透明度，默认0
    view.layer.shadowOffset = CGSizeMake(0,0);
    view.layer.shadowRadius = 1.5;//阴影半径，默认3
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, -.5)];
    [path addLineToPoint:CGPointMake(view.width, -.5)];
    [path addLineToPoint:CGPointMake(view.width, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, -.5)];
    view.layer.shadowPath = path.CGPath;

}

+ (void)addLeftShadowToView:(UIView *)view{
    
    view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    view.layer.shadowOpacity = 0.6;//阴影透明度，默认0
    view.layer.shadowOffset = CGSizeMake(0,0);
    view.layer.shadowRadius = 3;//阴影半径，默认3
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addQuadCurveToPoint:CGPointMake(0, view.height)
                 controlPoint:CGPointMake(-3, view.height/2)];
    view.layer.shadowPath = path.CGPath;
}

+ (void)addTopShadowToView:(UIView *)view{
    
    view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    view.layer.shadowOpacity = 0.6;//阴影透明度，默认0
    view.layer.shadowOffset = CGSizeMake(0,0);
    view.layer.shadowRadius = 4;//阴影半径，默认3
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, -2)];
    [path addLineToPoint:CGPointMake(view.width, -2)];
    [path addLineToPoint:CGPointMake(view.width, 1)];
    [path addLineToPoint:CGPointMake(0, 1)];
    [path addLineToPoint:CGPointMake(0, -2)];
    view.layer.shadowPath = path.CGPath;
}

+ (void)addCornerRadiusToView:(UIView *)view{
   
}

+ (UIButton *)buttonWithImage:(NSString *)imageName title:(NSString *)title subtitle:(NSString *)subTitle litTitle:(NSString *)litTitle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [button addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@25);
            make.centerX.equalTo(button.mas_centerX);
            make.centerY.equalTo(button.mas_centerY).with.offset(-12);
        }];
    }
    if (title) {
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.font = YBLFont(16);
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@25);
            make.centerY.equalTo(button.mas_centerY).with.offset(-12);
        }];
    }
    
    
    if (subTitle) {
        UILabel *label = [[UILabel alloc] init];
        label.text = subTitle;
        label.font = YBLFont(11);
        label.textColor = YBLColor(40, 40, 40, 1.0);
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@25);
            make.centerY.equalTo(button.mas_centerY).with.offset(12);
        }];
    }
    return button;
}

+ (NSArray *)getRowCount:(NSInteger)count{

    NSInteger row2 = 0;
    NSInteger row3 = 0;
    if (count>10) {
        count = 10;
    }
    if (count%2 == 0) {
        //oushu
        row2 = count/2;
        row3 = 0;
    }else{
        //qishu
        row2 = (count-3)/2;
        row3 = 1;
        if (count==1) {
            row2 = 1;
            row3 = 0;
        }
    }
    return @[@(row2),@(row3)];
}

+ (void)pushVc:(UIViewController *)Vc withNavigationVc:(UINavigationController *)navigationVc{
    
    [navigationVc pushViewController:Vc animated:NO];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35];
    [animation setType: kCATransitionPush];
    [animation setSubtype: kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [navigationVc.view.layer addAnimation:animation forKey:nil];
}

+ (void)popVc:(UIViewController *)Vc withNavigationVc:(UINavigationController *)navigationVc{
    
    if (Vc) {
        [navigationVc popToViewController:Vc animated:NO];
    } else {
        [navigationVc popViewControllerAnimated:NO];
    }
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType: kCATransitionPush];
    [animation setSubtype: kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [navigationVc.view.layer addAnimation:animation forKey:nil];
}

+ (NSString*)getTimeNow{
    NSDateFormatter* formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSString *)dateTimeDifferenceWithEndTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[NSDate date];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
//    int second = (int)value %60;//秒
//    int minute = (int)value /60%60;
//    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    /*
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"耗时%d秒",second];
    }
     */
    return [NSString stringWithFormat:@"%d",abs(day)];
}

+ (NSString *)diffDayOf:(NSString *)beginTime andEndTime:(NSString*)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *startD = [date dateFromString:beginTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    //    int second = (int)value %60;//秒
    //    int minute = (int)value /60%60;
    //    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    /*
     NSString *str;
     if (day != 0) {
     str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
     }else if (day==0 && house != 0) {
     str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
     }else if (day== 0 && house== 0 && minute!=0) {
     str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
     }else{
     str = [NSString stringWithFormat:@"耗时%d秒",second];
     }
     */
    return [NSString stringWithFormat:@"%d",abs(day)];
}


+ (NSInteger)getGoodManageStatusWith:(NSString *)value{
    
    if ([value isEqualToString:@"offline"]) {
        return 2;
    } else if ([value isEqualToString:@"online"]){
        return 1;
    } else if ([value isEqualToString:@"rack"]){
        return 0;
    }
    return 0;
}

+ (void)headerRefreshWithTableView:(id )view completion:(void (^)(void))completion{
  
    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        completion();
    }];
//    NSString *title = @"\n让采购更便捷";;
//    NSString *stateString1 = [NSString stringWithFormat:@"%@\n下拉更新...",title];
//    NSString *stateString2 = [NSString stringWithFormat:@"%@\n松开更新...",title];
//    NSString *stateString3 = [NSString stringWithFormat:@"%@\n更新中...",title];
//    [headerView setTitle:stateString1 forState:MJRefreshStateIdle];
//    [headerView setTitle:stateString2 forState:MJRefreshStatePulling];
//    [headerView setTitle:stateString3 forState:MJRefreshStateRefreshing];
//
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (int i = 1; i <= 9; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"YCRefreshTableHeader%d", i]];
//        if (image != nil) {
//            [refreshingImages addObject:image];
//        }
//    }
//    [headerView setImages:refreshingImages forState:MJRefreshStateIdle];
//
//    [headerView setImages:refreshingImages forState:MJRefreshStatePulling];
//    // 设置正在刷新状态的动画图片
//    [headerView setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)view;
        tableview.mj_header = headerView;
    } else if ([view isKindOfClass:[UICollectionView class]]){
        UICollectionView *tableview = (UICollectionView *)view;
        tableview.mj_header = headerView;
    }
    
}

+ (void)footerRefreshWithTableView:(id )view completion:(void (^)(void))completion{
    
    MJRefreshBackStateFooter *footerR = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        completion();
    }];
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)view;
        tableview.mj_footer = footerR;
    } else if ([view isKindOfClass:[UICollectionView class]]){
        UICollectionView *tableview = (UICollectionView *)view;
        tableview.mj_footer = footerR;

    }
}
+ (void)footerNormalRefreshWithTableView:(id )view completion:(void (^)(void))completion
{
    MJRefreshBackNormalFooter *footerR = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        completion();
    }];
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)view;
        tableview.mj_footer = footerR;
    } else if ([view isKindOfClass:[UICollectionView class]]){
        UICollectionView *tableview = (UICollectionView *)view;
        tableview.mj_footer = footerR;
        
    }
}
+ (void)footerAutoRefreshWithTableView:(id )view completion:(void (^)(void))completion{
    
    MJRefreshAutoNormalFooter *footerR = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        completion();
    }];
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)view;
        tableview.mj_footer = footerR;
    } else if ([view isKindOfClass:[UICollectionView class]]){
        UICollectionView *tableview = (UICollectionView *)view;
        tableview.mj_footer = footerR;
        
    }
//    NSString *title = @"\n让采购更便捷";
//    NSString *stateString1 = [NSString stringWithFormat:@"%@\n下拉更新...",title];
//    NSString *stateString2 = [NSString stringWithFormat:@"%@\n松开更新...",title];
//    NSString *stateString3 = [NSString stringWithFormat:@"%@\n更新中...",title];
//    [footerR setTitle:stateString1 forState:MJRefreshStateIdle];
//    [footerR setTitle:stateString2 forState:MJRefreshStatePulling];
//    [footerR setTitle:stateString3 forState:MJRefreshStateRefreshing];
//
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (int i = 1; i <= 9; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"YCRefreshTableHeader%d", i]];
//        if (image != nil) {
//            [refreshingImages addObject:image];
//        }
//    }
//    [footerR setImages:refreshingImages forState:MJRefreshStateIdle];
//
//    [footerR setImages:refreshingImages forState:MJRefreshStatePulling];
//    // 设置正在刷新状态的动画图片
//    [footerR setImages:refreshingImages forState:MJRefreshStateRefreshing];
   
}


+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay dateFormatter:(NSDateFormatter *)dateFormatter
{
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}


+ (void)dismissViewControllerToRoot:(UIViewController *)Vc{
    
    UIViewController *rootVC = Vc.navigationController.viewControllers[0];
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}

+ (BOOL)popToMyPurchaseVCFrom:(UIViewController *)fromeVC{
    return [self popToPurchaseVC:0 fromVC:fromeVC];
}

+ (BOOL)popToFoundVCFrom:(UIViewController *)fromeVC{
    return [self popToPurchaseVC:-1 fromVC:fromeVC];
}

+ (BOOL)popToHomeBarFromEditPurchaseVC:(UIViewController *)vc {
    return [self popToPurchaseVC:-2 fromVC:vc];
}

+ (BOOL)popToPurchaseVC:(NSInteger)select fromVC:(UIViewController *)fromeVC{
    BOOL isHaveTabVc = NO;
    for (UIViewController *controller in fromeVC.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[YBLFoundTabBarViewController class]]) {
//            YBLFoundTabBarViewController *vc = (YBLFoundTabBarViewController *)controller;
//            if (select!=-1) {
//                vc.selectedIndex = select;
//            }
//            [fromeVC.navigationController popToViewController:vc animated:YES];
//            if (select==-2) {
//                vc.navigationController.tabBarController.selectedIndex = 4;
//                [vc.navigationController popToRootViewControllerAnimated:YES];
//            }
//            isHaveTabVc = YES;
//        }
    }
    return isHaveTabVc;
}

+ (void)pushVC:(UIViewController *)Vc FromeUndefineVC:(UIViewController *)superVC{
    
    if ([superVC.tabBarController.navigationController respondsToSelector:@selector(pushViewController:animated:)]) {
        [superVC.tabBarController.navigationController pushViewController:Vc animated:YES];
    } else {
        [superVC.navigationController pushViewController:Vc animated:YES];;
    }
}

+ (YBLButton *)getTopAndCommandButton{
   
    YBLButton *button = [YBLButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"home_tuijian_top_icon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"home_tuijian_icon"] forState:UIControlStateSelected];
    button.frame = CGRectMake(0, 0, 40, 40);
    return button;
}

+ (UIButton *)getButtonWithImage:(NSString *)imageName{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.highlighted = NO;
    return  button;
}

+ (NSString *)getCharactersWithRoleName:(NSString *)roleName{
    
    NSString *roleCharacter = nil;
    
    if ([roleName isEqualToString:@"seller_manager"]) {
        roleCharacter = @"销售经理";
    } else if ([roleName isEqualToString:@"seller_salesman"]) {
        roleCharacter = @"销售人员";
    } else if ([roleName isEqualToString:@"seller_accountant"]) {
        roleCharacter = @"财务人员";
    } else if ([roleName isEqualToString:@"seller_warehouse_man"]) {
        roleCharacter = @"仓库人员";
    } else if ([roleName isEqualToString:@"seller_delivery_man"]) {
        roleCharacter = @"配送人员";
    }
    return roleCharacter;
}

+ (NSString *)getStaffRoleValueWithArray:(NSArray *)array{
    return [YBLMethodTools getStaffRoleNamesWithArray:array isName:NO];
}

+ (NSString *)getStaffRoleNamesWithArray:(NSArray *)array{
    
    return [YBLMethodTools getStaffRoleNamesWithArray:array isName:YES];
}

+ (NSString *)getStaffRoleNamesWithArray:(NSArray *)array isName:(BOOL)isName{

    NSString *baseName = @"";
    for (NSString *roleName in array) {
        if (![roleName isEqualToString:@"staff"]) {
            NSString *chararaterName = roleName;
            if (isName) {
                chararaterName = [self getCharactersWithRoleName:roleName];
            }
            baseName = [[baseName stringByAppendingString:chararaterName] stringByAppendingString:@","];
        }
    }
    baseName = [baseName substringToIndex:baseName.length-1];
    if (isName) {
        NSArray *componeArray = [baseName componentsSeparatedByString:@","];
        if (componeArray.count==5) {
            baseName = @"全职通";
        }
    }
    return baseName;
}

+ (void)removeSearchBarBackgroundColorWithBar:(UIView *)bar {

    for (UIView *view in bar.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
}

+ (void)changeSearchBarCancleButton:(UIView *)bar{
    
    for(id sousuo in [bar subviews])
    {
        for (id zz in [sousuo subviews])
        {
            if([zz isKindOfClass:[UIButton class]]){
                UIButton *btn = (UIButton *)zz;
                [btn setTitle:@"搜索" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
}

+ (NSString *)getFullAppendingAddressWithArray:(NSMutableArray *)selectArray{
    
    NSString *addres1 = @"";
//    for (YBLAddressAreaModel *model in selectArray) {
//        addres1 = [addres1 stringByAppendingString:model.text];
//    }
    return addres1;
}

+ (YBLOrderPropertyModel *)buyerOrderStateWith:(NSString *)state{
    
    __block YBLOrderPropertyModel *sef_propertyModel = nil;
    
    [_buyer_orderManager enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YBLOrderPropertyModel *propertyModel  = (YBLOrderPropertyModel *)obj;
        if ([propertyModel.order_state isEqualToString:state]) {
            sef_propertyModel = [propertyModel mutableCopy];
            *stop = YES;
        }
    }];
    return sef_propertyModel;

}
+ (YBLOrderPropertyModel *)sellerOrderStateWith:(NSString *)state{
  
    __block YBLOrderPropertyModel *sef_propertyModel = nil;
    
    [_seller_orderManager enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YBLOrderPropertyModel *propertyModel  = (YBLOrderPropertyModel *)obj;
        if ([propertyModel.order_state isEqualToString:state]) {
            sef_propertyModel = [propertyModel mutableCopy];
            *stop = YES;
        }
    }];
    return sef_propertyModel;
}

//+ (NSString *)getCachImageSize
//{
//    NSInteger tmpSize = [[SDImageCache sharedImageCache] getSize];
//    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
//    NSUInteger allCount = cache.memoryCache.totalCost+cache.diskCache.totalCost;
//    NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:tmpSize+allCount]];
//    return currentVolum;
//}

+ (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

+ (void)cleanImageCach {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [SVProgressHUD showWithStatus:@"清除中..."];
//        [[SDImageCache sharedImageCache] clearDisk];
//        [[SDImageCache sharedImageCache] clearMemory];
//        YYImageCache *cache = [YYWebImageManager sharedManager].cache;
//        [cache.memoryCache removeAllObjects];
//        [cache.diskCache removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"清除成功~"];
        });
    });
}

//+ (void)filter_priceModel:(YBLCompanyTypePricesParaModel *)priceModel {
//
//    NSMutableArray *filter_price = [NSMutableArray array];
//    for (PricesItemModel *priceItemModel in priceModel.prices) {
//        if (priceItemModel.active.boolValue) {
//            [filter_price addObject:priceItemModel];
//        }
//    }
//    [priceModel setValue:filter_price forKey:@"filter_prices"];
//}
//
//+ (Prices_prices)getPrice_priceWithModel:(YBLCompanyTypePricesParaModel *)priceModel {
//
//    NSInteger minCount = 0;
//    BOOL isEnable = NO;
//    float currentPrice = 0;
//    if (priceModel.prices.count!=0) {
//        PricesItemModel *minPrices = priceModel.filter_prices[0];
//        minCount = minPrices.min.integerValue;
//        currentPrice = minPrices.sale_price.floatValue;
//        if (minPrices.sale_price.floatValue!=0) {
//            isEnable = YES;
//        }
//    }
//    Prices_prices price_price = {minCount,currentPrice,isEnable};
//    return price_price;
//}
//
//+ (float)getCurrentPriceWithCount:(NSInteger)count InPriceArray:(NSArray *)priceArray{
//
//    float finPrices = 0.0;
//
//    NSInteger priceArrayCount = priceArray.count;
//    PricesItemModel *pricesModel1 = nil;
//    PricesItemModel *pricesModel2 = nil;
//    PricesItemModel *pricesModel3 = nil;
//
//    if (priceArrayCount > 0) {
//        pricesModel1 = priceArray[0];
//
//        if (count>=pricesModel1.min.integerValue){
//            finPrices = pricesModel1.sale_price.floatValue;
//        }
//
//    }
//    if (priceArrayCount > 1){
//        pricesModel2 = priceArray[1];
//
//        if (count>=pricesModel2.min.integerValue) {
//            finPrices = pricesModel2.sale_price.floatValue;
//        }
//
//    }
//    if (priceArrayCount == 3){
//        pricesModel3 = priceArray[2];
//
//        if(count>=pricesModel3.min.integerValue){
//            finPrices = pricesModel3.sale_price.floatValue;
//        }
//    }
//
//    return finPrices;
//
//}

+ (NSString *)getAppBuildNumber{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
    
    
//获取版本号
+ (NSString *)getAppVersion
{
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//获取应用当前版本号
    return version;
}



#pragma mark --判断手机号合法性
+ (BOOL)checkPhone:(NSString *)phoneNumber{
    
    /**
     * 手机号码
     * 移动：134 135 136 137 138 139 147 150 151 152 157 158 159 178 182 183 184 187 188 198
     * 联通：130 131 132 145 155 156 166 171 175 176 185 186
     * 电信：133 149 153 173 177 180 181 189 199
     * 虚拟运营商: 170
     */
    NSString *target = @"^(0|86|17951)?(13[0-9]|15[012356789]|16[6]|19[89]]|17[01345678]|18[0-9]|14[579])[0-9]{8}$";
    NSPredicate *targetPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", target];
    if ([targetPredicate evaluateWithObject:phoneNumber])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma mark 判断邮箱
+ (BOOL)checkEmail:(NSString *)email{
    
    //^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w{2,3}){1,3})$
    
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [emailTest evaluateWithObject:email];
    
}
+(NSString *)formatFloat:(float)f
{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}
+ (BOOL)checkIsChinese:(NSString *)string
{
    for (int i=0; i<string.length; i++)
    {
        unichar ch = [string characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5)
        {
            return YES;
        }
    }
    return NO;
}

+ (void)setStatusBarBackgroundColor:(UIColor *)color
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
}
+ (NSString *)transform:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}

+(CGRect)jisuanTextHeightForString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font
{
    CGRect titleBounds = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return titleBounds;
}
/*
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APPID"]];
 
- (UIViewController *)viewController
{
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;
    while (next)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    } 
    return viewController;
}
 */
//方法一：
- (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];

    for (int i=0 ; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
        
    }
    return strlength;
}

//方法二：
-(NSUInteger) unicodeLengthOfString: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++){
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}


//+ (NSString *)getAppendingStringWithArray:(NSArray *)array appendingKey:(NSString *)key ttype:(NSString *)type{
//
//    NSString *appendingString = @"";
//    for (id value in array) {
//        NSString *textvalue = nil;
//        if ([value isKindOfClass:[NSString class]]) {
//            textvalue = (NSString *)value;
//        } else if ([value isKindOfClass:[YBLPurchaseInfosModel class]]){
//            YBLPurchaseInfosModel *infoModel = (YBLPurchaseInfosModel *)value;
//            if ([type isEqualToString:appending_key]) {
//
//                textvalue = infoModel._id;
//
//            } else if([type isEqualToString:appending_title]){
//
//                NSString *sameCityString = nil;
//                if (infoModel.purchase_distribution_ids.count==0) {
//                    if (infoModel.same_city.boolValue) {
//                        sameCityString = @"同城";
//                    } else {
//                        sameCityString = @"异地";
//                    }
//                    textvalue = [NSString stringWithFormat:@"%@ %@",sameCityString,infoModel.title];
//                } else {
//                    textvalue = [NSString stringWithFormat:@"%@",infoModel.title];
//                }
//
//            }
//        } else if ([value isKindOfClass:[YBLAddressAreaModel class]]){
//            YBLAddressAreaModel *areaModel = (YBLAddressAreaModel *)value;
//            if ([type isEqualToString:appending_key]) {
//
//                textvalue = [NSString stringWithFormat:@"%@",areaModel.id];
//
//            } else if([type isEqualToString:appending_title]){
//
//                textvalue = areaModel.text;
//            }
//        } else if ([value isKindOfClass:[YBLExpressCompanyItemModel class]]){
//
//            YBLExpressCompanyItemModel *companyItemModel = (YBLExpressCompanyItemModel *)value;
//            if ([type isEqualToString:appending_key]) {
//
//                textvalue = [NSString stringWithFormat:@"%@",companyItemModel.id];
//
//            } else if([type isEqualToString:appending_title]){
//
//                textvalue = companyItemModel.title;
//            }
//
//        } else if ([value isKindOfClass:[area_prices class]]){
//
//            area_prices *area_prices_Model = (area_prices *)value;
//
//            if ([type isEqualToString:appending_key]) {
//
//                textvalue = area_prices_Model.area_text;
//
//            } else if([type isEqualToString:appending_title]){
//
//                textvalue = area_prices_Model.area_text;
//            }
//        } else if ([value isKindOfClass:[YBLTakeOrderParaLineItemsModel class]]){
//            YBLTakeOrderParaLineItemsModel *paraModel = (YBLTakeOrderParaLineItemsModel *)value;
//            if ([type isEqualToString:appending_payment]) {
//                textvalue = paraModel.select_product_payment_method_name;
//            } else if ([type isEqualToString:appending_shippingment]) {
//                textvalue = paraModel.select_product_shipping_method_name;
//            }
//        } else if ([value isKindOfClass:[YBLGoodModel class]]){
//            YBLGoodModel *paraModel = (YBLGoodModel *)value;
//            if ([type isEqualToString:appending_key]) {
//                textvalue = paraModel.id;
//                if (!textvalue) {
//                    textvalue = paraModel._id;
//                }
//            }
//        } else if ([value isKindOfClass:[YBLMineMillionMessageItemModel class]]){
//            YBLMineMillionMessageItemModel *paraModel = (YBLMineMillionMessageItemModel *)value;
//            textvalue = paraModel.id;
//        }
//        appendingString = [[appendingString stringByAppendingString:textvalue] stringByAppendingString:key];
//        if (appendingString.length==0) {
//            appendingString = @" ";
//        }
//    }
//    if (array.count>0) {
//        NSInteger keyLength = key.length;
//        appendingString = [appendingString substringToIndex:appendingString.length-keyLength];
//    }
//    return appendingString;
//
//}

//+ (NSString *)getAppendingPaymentTitleStringWithArray:(NSArray *)array appendingKey:(NSString *)key{
//    return [self getAppendingStringWithArray:array appendingKey:key ttype:appending_payment];
//}
//
//+ (NSString *)getAppendingShippingmentTitleStringWithArray:(NSArray *)array appendingKey:(NSString *)key{
//    return [self getAppendingStringWithArray:array appendingKey:key ttype:appending_shippingment];
//}
//
//+ (NSString *)getAppendingTitleStringWithArray:(NSArray *)array appendingKey:(NSString *)key{
//
//    return [self getAppendingStringWithArray:array appendingKey:key ttype:appending_title];
//}
//
//+ (NSString *)getAppendingStringWithArray:(NSArray *)array appendingKey:(NSString *)key{
//
//    return [self getAppendingStringWithArray:array appendingKey:key ttype:appending_key];
//}
//
/*
 *  判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于6位
 2. 密码中必须同时包含数字和字母
 */
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}
+ (BOOL)checkLoginWithVc:(UIViewController *)Vc{
    BOOL isLogin = [WCLUserManageCenter shareInstance].isLoginStatus;
    if (!isLogin) {
        WCLLoginViewController *loginVC = [[WCLLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [Vc presentViewController:nav animated:YES completion:nil];
    }
    return isLogin;
}

+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

+ (NSMutableAttributedString *)getJoinVisitAttributedStringWithJoin:(NSString *)join
                                                          visitTime:(NSString *)visit
                                                      componeString:(NSString *)componeString{
    
    NSString *joinRecordString = [NSString stringWithFormat:@"%d人参与%@%d人浏览",join.intValue,componeString,visit.intValue];
    
    NSRange gangRange = [joinRecordString rangeOfString:componeString];
    NSMutableAttributedString *att_joinRecordString = [[NSMutableAttributedString alloc] initWithString:joinRecordString];
    NSInteger biddingLength = 1;
    NSInteger visitLength = 1;
    if (join.length>0) {
        biddingLength = join.length;
    }
    if (visit.length>0) {
        visitLength = visit.length;;
    }
    [att_joinRecordString addAttributes:@{NSFontAttributeName:YBLFont(13),
                                          NSForegroundColorAttributeName:YBLThemeColor}
                                  range:NSMakeRange(0, biddingLength)];
    [att_joinRecordString addAttributes:@{NSFontAttributeName:YBLFont(13),
                                          NSForegroundColorAttributeName:YBLThemeColor}
                                  range:NSMakeRange(gangRange.location+1, visitLength)];
    return att_joinRecordString;
}

+ (void)pushWebVcFrom:(UIViewController *)Vc URL:(NSString *)URL title:(NSString *)title string:(NSString*)string type:(NSString*)type buystate:(NSString*)state activityid:(NSNumber*)huodongid{
    
    WCLWebViewController *webVc = [WCLWebViewController new];
    webVc.url = URL;
    webVc.navTitle = title;
    webVc.strings =string;
    webVc.type =type;
    webVc.buyStates = state;
    webVc.huodongid =huodongid;
    webVc.hidesBottomBarWhenPushed =YES;
    if ([type isEqualToString:@"人气单品详情"]) {
        [Vc presentViewController:webVc animated:NO completion:nil];
    }
    else
    {
        [Vc.navigationController pushViewController:webVc animated:YES];
    }
}

+ (NSString *)replaceNYRDataStringWith:(NSString *)dataString{
    
    NSArray *titleKeArray = @[@"年",@"月",@"日"];
    for (NSString *title in titleKeArray) {
        if ([dataString rangeOfString:title].location != NSNotFound) {
            dataString = [dataString stringByReplacingOccurrencesOfString:title withString:@"-"];
        }
    }
    dataString = [dataString substringToIndex:dataString.length];

    return dataString;
}

+ (void)cleanNotificationNumber{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

+ (NSMutableArray *)getSectionAppendingIndexPathsWithIndex:(NSInteger)index_from appendingCount:(NSInteger)appendingCount inSection:(NSInteger)inSection{
    return [self getRowAppendingIndexPathsWithIndex:index_from appendingCount:appendingCount inSection:inSection isApenddingSection:YES];
}

+ (NSMutableArray *)getRowAppendingIndexPathsWithIndex:(NSInteger)index_from appendingCount:(NSInteger)appendingCount inSection:(NSInteger)inSection{
    return [self getRowAppendingIndexPathsWithIndex:index_from appendingCount:appendingCount inSection:inSection isApenddingSection:NO];
}
/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+(void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

+ (NSMutableArray *)getRowAppendingIndexPathsWithIndex:(NSInteger)index_from appendingCount:(NSInteger)appendingCount inSection:(NSInteger)inSection isApenddingSection:(BOOL)isApenddingSection{
    NSMutableArray *indexps = [NSMutableArray array];
    for (NSInteger i = 0; i < appendingCount; i++) {
        if (isApenddingSection) {
            NSIndexPath *indexp = [NSIndexPath indexPathForRow:0 inSection:index_from+i];
            [indexps addObject:indexp];
        } else {
            NSIndexPath *indexp = [NSIndexPath indexPathForRow:index_from+i inSection:inSection];
            [indexps addObject:indexp];
        }
    }
    return indexps;
}

+ (NSString *)updateURL:(NSString *)url versionWithSiganlNumber:(NSInteger)number{
    
    NSString *sigString = @"/v1/";
    if ([url rangeOfString:sigString].location!=NSNotFound) {
        //有V1
        NSString *new_sig = [NSString stringWithFormat:@"/v%ld/",(long)number];
        url = [url stringByReplacingOccurrencesOfString:sigString withString:new_sig];
    }
    return url;
}


// QRCode
+ (UIImage *)generateQRCodeWithInputMessage:(NSString *)inputMessage
                                      Width:(CGFloat)width
                                     Height:(CGFloat)height{
    NSData *inputData = [inputMessage dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:inputData forKey:@"inputMessage"];
    //    [filter setValue:@"H" forKey:@"inputCorrectionLevel"]; // 设置二维码不同级别的容错率
    
    CIImage *ciImage = filter.outputImage;
    // 消除模糊
    CGFloat scaleX = MIN(width, height)/ciImage.extent.size.width;
    CGFloat scaleY = MIN(width, height)/ciImage.extent.size.height;
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    UIImage *returnImage = [UIImage imageWithCIImage:ciImage];
    return returnImage;
}
+ (UIImage *)generateQRCodeWithInputMessage:(NSString *)inputMessage
                                      Width:(CGFloat)width
                                     Height:(CGFloat)height
                             AndCenterImage:(UIImage *)centerImage{
    UIImage *backImage = [self generateQRCodeWithInputMessage:inputMessage Width:width Height:height];
    UIGraphicsBeginImageContext(backImage.size);
    [backImage drawInRect:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    CGFloat centerImageWH = MIN(backImage.size.width, backImage.size.height) * 0.15;
    [centerImage drawInRect:CGRectMake((backImage.size.width - centerImageWH)*0.5, (backImage.size.height - centerImageWH)*0.5, centerImageWH, centerImageWH)];
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}
+ (NSString *)decodeQRCodeWithPhotoCodeImage:(UIImage *)codeImage{
    NSString *outputString = nil;
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [[CIImage alloc] initWithImage:codeImage];
    NSArray *features = [detector featuresInImage:image];
    for (CIQRCodeFeature *feature in features) {
        outputString = feature.messageString;
    }
    return outputString;
}

// BarCode
+ (UIImage *)generateBarcodeWithInputMessage:(NSString *)inputMessage
                                       Width:(CGFloat)width
                                      Height:(CGFloat)height{
    NSData *inputData = [inputMessage dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:inputData forKey:@"inputMessage"]; // 设置条形码内容
    //    [filter setValue:@(50) forKey:@"inputQuietSpace"]; // 设置条形码上下左右margin值
    //    [filter setValue:@(height) forKey:@"inputBarcodeHeight"]; // 设置条形码高度
    CIImage *ciImage = filter.outputImage;
    CGFloat scaleX = width/ciImage.extent.size.width;
    CGFloat scaleY = height/ciImage.extent.size.height;
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    UIImage *returnImage = [UIImage imageWithCIImage:ciImage];
    return returnImage;
}


+ (YBLButton *)getImageTextButtonWithText:(NSString *)text buttonSize:(CGSize)buttonSize{
    
    CGSize textSize = [text heightWithFont:YBLFont(12) MaxWidth:YBLWindowWidth];
    YBLButton *imageTextButton = [YBLButton buttonWithType:UIButtonTypeCustom];
    [imageTextButton setImage:[UIImage imageNamed:@"iButton_L_02"] forState:UIControlStateNormal];
    [imageTextButton setImage:[UIImage imageNamed:@"iButton_L_01"] forState:UIControlStateSelected];
    [imageTextButton setTitle:text forState:UIControlStateNormal];
    imageTextButton.titleLabel.font = YBLFont(12);
    imageTextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [imageTextButton setTitleColor:YBLColor(70, 70, 70, 1) forState:UIControlStateNormal];
    CGFloat imageTopSpace = (buttonSize.height-15)/2;
    CGFloat imageWi = 15;
    [imageTextButton setTitleRect:CGRectMake(imageWi+3, 0, textSize.width+5, buttonSize.height)];
    imageTextButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [imageTextButton setImageRect:CGRectMake(0, imageTopSpace, imageWi, imageWi)];
    imageTextButton.frame = CGRectMake(0, 0, 90, buttonSize.height);
    return imageTextButton;
}

+ (NSString *)changeToNiMing:(NSString *)name{
    NSString *newname = @"匿名";
    if (name.length==1) {
        newname = [NSString stringWithFormat:@"%@***%@",name,name];
    } else if(name.length>1){
        NSString *firstName = [name substringToIndex:1];
        NSString *lastName = [name substringFromIndex:name.length-1];
        newname = [NSString stringWithFormat:@"%@***%@",firstName,lastName];
    }
    return newname;
}

+ (CABasicAnimation *)getShakeAnimation{
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置属性，周期时长
    [animation setDuration:0.10];
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    //恢复原样
    animation.autoreverses = YES;
    return animation;
}

+ (CABasicAnimation *)get3DRotationAnimation{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 3;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = MAXFLOAT;
    return rotationAnimation;
}

+ (CABasicAnimation *)getScaleAnimationScale:(CGFloat)scale{
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    return scaleAnim;
}

+ (void)copyString:(NSString *)copyString{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = copyString;
}
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    @try {
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        //  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        //  取当前时间和转换时间两个日期对象的时间间隔
        //  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        // 再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = @"";
        if (time < 0) {
            if (time >= -60*60*24) {
                dateStr = @"明天";
                [dateFormatter setDateFormat:@"YYYY/MM/dd"];
                NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
                NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
                
                [dateFormatter setDateFormat:@"HH:mm"];
                if ([need_yMd isEqualToString:now_yMd]) {
                    //在同一天
                    dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
                }else{
                    //明天天
                    dateStr = [NSString stringWithFormat:@"明天 %@",[dateFormatter stringFromDate:needFormatDate]];
                }
            }else{
                [dateFormatter setDateFormat:@"yyyy"];
                NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
                NSString *nowYear = [dateFormatter stringFromDate:nowDate];
                
                if ([yearStr isEqualToString:nowYear]) {
                    ////  在同一年
                    [dateFormatter setDateFormat:@"MM月dd日"];
                    dateStr = [dateFormatter stringFromDate:needFormatDate];
                }else{
                    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                    dateStr = [dateFormatter stringFromDate:needFormatDate];
                }
            }
        }
        else if (time<=60) {  //// 1分钟以内的
            dateStr = @"刚刚";
        }else if(time<=60*60){  ////  一个小时以内的
            
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        }else if(time<=60*60*24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        
        return dateStr;
        
        
    } @catch (NSException *exception) {
        return @"";
    }
}

#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue]*1000;
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
    
}

//判断是否为整形：

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

@end
