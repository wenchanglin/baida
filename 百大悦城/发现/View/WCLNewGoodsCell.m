//
//  WCLNewGoodsCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLNewGoodsCell.h"

@implementation WCLNewGoodsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor clearColor];
    view2.frame = CGRectMake(12, 10, 135, 90);
    view2.layer.shadowOpacity = 0.4;
    view2.layer.shadowOffset = CGSizeMake(0, 4);
    [self.contentView addSubview:view2];
    _iconImageView = [UIImageView new];
    CALayer *cellImageLayer = _iconImageView.layer;
    [cellImageLayer setCornerRadius:4];
    [cellImageLayer setMasksToBounds:YES];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [view2 addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(135);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    _titleNameLabel = [UILabel new];
    _titleNameLabel.numberOfLines=0;
    _titleNameLabel.textColor = [UIColor colorWithHexString:@"#101010"];
    _titleNameLabel.font = [UIFont fontWithName:@"SFProText-Regular" size:14];
    [self.contentView addSubview:_titleNameLabel];
    [_titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(9);
        make.top.equalTo(@0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SCREEN_WIDTH-168);
    }];
    _descLabel = [UILabel new];
    _descLabel.numberOfLines=0;
    _descLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    _descLabel.font = [UIFont fontWithName:@"SFUIText-Regular" size:12];
    [self.contentView addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleNameLabel);
        make.top.equalTo(self.titleNameLabel.mas_bottom).offset(9);
        make.width.mas_equalTo(SCREEN_WIDTH-168);
        make.height.mas_equalTo(14);
    }];
   
    _smellImageView = [UIImageView new];
    _smellImageView.image = [UIImage imageNamed:@"home_icon_time"];
    [self.contentView addSubview:_smellImageView];
    [_smellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descLabel);
        make.bottom.equalTo(self.iconImageView.mas_bottom);
    }];
    _dateTimeLabel = [UILabel new];
    _dateTimeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _dateTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self.contentView addSubview:_dateTimeLabel];
    [_dateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smellImageView.mas_right).offset(5);
        make.centerY.equalTo(self.smellImageView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH-168);

    }];
   
    
}
-(void)setModels:(WCLGoodsModel *)models
{
    _models =models;
    _titleNameLabel.text = models.commodityName;
    _descLabel.text = models.shopName;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:models.picturePath] placeholderImage:[UIImage imageNamed:@"logoImage"]];
    NSString *str2 = [models.onlineTime substringWithRange:NSMakeRange(5,models.onlineTime.length-5)];//str2 = "name"
    NSString* str3 = [str2 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
    NSString * str4 = [str3 stringByReplacingOccurrencesOfString:@" " withString:@"月 "];
    _dateTimeLabel.text = str4;
}
@end
