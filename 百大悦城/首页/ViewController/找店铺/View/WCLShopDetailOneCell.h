//
//  WCLShopDetailOneCell.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/24.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLShopSwitchModel.h"
#import "WCLFindShopModel.h"
@interface WCLShopDetailOneCell : UITableViewCell
@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * titleNameLabel;
@property(nonatomic,strong)UILabel * yetaiLabel;
@property(nonatomic,strong)UILabel * addressLabel;
@property(nonatomic,strong)UILabel*dianpuLabels;
@property(nonatomic,strong)UILabel * introLabel;
@property(nonatomic,strong)WCLShopSwitchListModel * model1;
@property(nonatomic,strong)WCLFindShopModel * model2;

-(void)shopDetailMallModel:(WCLShopSwitchListModel *) models withShopModel:(WCLFindShopModel*)model;
@end
