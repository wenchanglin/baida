//
//  WCLActivityDetailCell.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLActivityModel.h"
#import "TJPTagVIew.h"
@interface WCLActivityDetailCell : UITableViewCell
@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UILabel * titleNameLabel;
@property(nonatomic,strong)TJPTagVIew* tagView;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * placeLabel;
@property(nonatomic,strong)UILabel * activityLabel;
@property(nonatomic,strong)UILabel * addressLabel;
@property(nonatomic,strong)UILabel * introLabel;
@property(nonatomic,strong)WCLActivityModel* models;

@end
