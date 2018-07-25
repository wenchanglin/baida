//
//  WCLShopSwitchRightCell.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLShopSwitchModel.h"
@interface WCLShopSwitchRightCell : UITableViewCell
@property(nonatomic,strong)UIImageView * backImgView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * subNameLabel;
@property(nonatomic,strong)WCLShopSwitchListModel* models;
@end
