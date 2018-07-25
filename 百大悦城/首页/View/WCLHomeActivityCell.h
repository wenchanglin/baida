//
//  WCLHomeActivityCell.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLHomeActivityModel.h"
#import "TJPTagVIew.h"
typedef void(^joinActivityBlock)(NSInteger activityId);
typedef void(^signupActivityBlock)(NSInteger activityId);
@interface WCLHomeActivityCell : UITableViewCell
@property(nonatomic,strong)UIImageView * sfbackImgeView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * tagsLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UIButton * applyBtn;
@property(nonatomic,strong)TJPTagVIew* tagView;
@property(nonatomic,strong)joinActivityBlock blocks;
@property(nonatomic,strong)signupActivityBlock  signblocks;
@property(nonatomic,strong)WCLHomeActivityModel * models;
@property(nonatomic,strong)NSString*string1;

@end
