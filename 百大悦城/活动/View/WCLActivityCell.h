//
//  WCLActivityCell.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJPTagVIew.h"
#import "WCLActivityModel.h"
@interface WCLActivityCell : UITableViewCell
@property(nonatomic,strong)UIImageView * sfbackImgeView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * tagsLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UIButton * applyBtn;
@property(nonatomic,strong)TJPTagVIew* tagView;
@property(nonatomic,strong)WCLActivityModel * models;
@end
