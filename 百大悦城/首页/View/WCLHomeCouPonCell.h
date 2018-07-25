//
//  WCLHomeCouPonCell.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLHomeCouPonModel.h"
typedef void(^PointsBlock)(WCLHomeCouPonModel*model);
typedef void(^FreeBlock)(WCLHomeCouPonModel*model);
typedef void(^FanliBlock)(WCLHomeCouPonModel*model,NSString* jifen);

@interface WCLHomeCouPonCell : UITableViewCell
@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * couponLabel;
@property(nonatomic,strong)UILabel* couponSubLabel;
@property(nonatomic,strong)UILabel* couponCountLabel;
@property(nonatomic,strong)UIButton * receiveBtn;
@property(nonatomic,strong)UILabel* receiveLabel;
@property(nonatomic,strong)PointsBlock pointsBlock;
@property(nonatomic,strong)FreeBlock freeBlock;
@property(nonatomic,strong)FanliBlock fanliBlock;

@property(nonatomic,strong)WCLHomeCouPonModel* models;
@end
