//
//  WCLShopListCell.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLFindShopModel.h"
@interface WCLShopListCell : UITableViewCell
@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel * subLabel;
@property(nonatomic,strong)UILabel * floorLabel;
@property(nonatomic,strong)WCLFindShopModel * model;
@property(nonatomic,strong)UIImageView * smallIcon;
@property(nonatomic,strong)UILabel * teQuanLabel;

@end
