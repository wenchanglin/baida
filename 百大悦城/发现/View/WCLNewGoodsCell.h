//
//  WCLNewGoodsCell.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLGoodsModel.h"
@interface WCLNewGoodsCell : UITableViewCell
@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * titleNameLabel;
@property(nonatomic,strong)UILabel * descLabel;
@property(nonatomic,strong)UILabel * dateTimeLabel;
@property(nonatomic,strong)UIImageView * smellImageView;
@property(nonatomic,strong)WCLGoodsModel * models;
@end
