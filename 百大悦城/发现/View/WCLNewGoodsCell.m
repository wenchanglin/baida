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
//        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _iconImageView = [UIImageView new];
    CALayer *cellImageLayer = _iconImageView.layer;
    [cellImageLayer setCornerRadius:4];
    [cellImageLayer setMasksToBounds:YES];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(135);
        make.height.mas_equalTo(90);
    }];
    _titleNameLabel = [UILabel new];
    _titleNameLabel.numberOfLines=2;
    _titleNameLabel.textColor = [UIColor colorWithHexString:@"#101010"];
    _titleNameLabel.font = [UIFont systemFontOfSize:16];//fontWithName:@"SFProText-Regular" size:14];
    [self.contentView addSubview:_titleNameLabel];
    [_titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(9);
        make.top.equalTo(self.iconImageView);
        make.width.mas_equalTo(SCREEN_WIDTH-168);
    }];
    _descLabel = [UILabel new];
    _descLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    _descLabel.font = [UIFont systemFontOfSize:14];//[UIFont fontWithName:@"SFUIText-Regular" size:14];
    [self.contentView addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleNameLabel);
        make.top.equalTo(self.titleNameLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-168);
    }];
   
    _smellImageView = [UIImageView new];
    _smellImageView.image = [UIImage imageNamed:@"home_icon_time"];
    [self.contentView addSubview:_smellImageView];
    [_smellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).offset(5);
        make.left.equalTo(self.descLabel);
    }];
    _dateTimeLabel = [UILabel new];
    _dateTimeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _dateTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self.contentView addSubview:_dateTimeLabel];
    [_dateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smellImageView.mas_right).offset(5);
        make.top.equalTo(self.descLabel.mas_bottom).offset(11);
        make.width.mas_equalTo(SCREEN_WIDTH-168);

    }];
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smellImageView);
        make.top.equalTo(self.smellImageView.mas_bottom).offset(5);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(0);
    }];
    
}
-(void)setModels:(WCLGoodsModel *)models
{
    _models =models;
    _titleNameLabel.text = models.commodityName;
    _descLabel.text = models.industryName;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:models.picturePath] placeholderImage:[UIImage imageNamed:@"logoImage"]];
    _dateTimeLabel.text = models.nowDate;
}
@end
