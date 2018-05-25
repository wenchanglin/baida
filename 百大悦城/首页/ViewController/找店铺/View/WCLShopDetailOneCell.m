//
//  WCLShopDetailOneCell.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/24.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopDetailOneCell.h"

@implementation WCLShopDetailOneCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    UIView * views = [UIView new];
    views.backgroundColor = [UIColor colorWithHexString:@"#E0BE8D"];
    [self.contentView addSubview:views];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(197.5);
    }];
    _backImageView = [UIImageView new];
    [views addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(174.5);
    }];
    _iconImageView = [UIImageView new];
    _iconImageView.layer.cornerRadius = 25;
    _iconImageView.layer.masksToBounds=YES;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(views.mas_bottom).offset(12);
        make.left.mas_equalTo(18);
        make.width.height.mas_equalTo(50);
    }];
    _titleNameLabel = [UILabel new];
    _titleNameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [self.contentView addSubview:_titleNameLabel];
    [_titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(20);
        make.top.equalTo(views.mas_bottom).offset(18);
        make.right.mas_equalTo(-40);
    }];
    _yetaiLabel = [UILabel new];
    _yetaiLabel.font= [UIFont systemFontOfSize:12];
    _yetaiLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_yetaiLabel];
    [_yetaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleNameLabel);
        make.left.equalTo(self.titleNameLabel.mas_right).offset(8);
    }];
    UIImageView * smallView = [UIImageView new];
    smallView.image = [UIImage imageNamed:@"icon_mall_location"];
    [self.contentView addSubview:smallView];
    [smallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleNameLabel.mas_bottom).offset(8);
        make.left.equalTo(self.titleNameLabel);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(14);
    }];
    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _addressLabel.textColor = [UIColor colorWithHexString:@"#A9B5C4"];
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(smallView.mas_right).offset(5);
        make.top.equalTo(self.titleNameLabel.mas_bottom).offset(6);
        make.right.mas_equalTo(-40);
    }];
    UIView *fengeView = [UIView new];
    fengeView.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    [self.contentView addSubview:fengeView];
    [fengeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(12);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    UILabel * dianpuLabel = [UILabel new];
    dianpuLabel.text = @"店铺简介";
    dianpuLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [self.contentView addSubview:dianpuLabel];
    [dianpuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengeView.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
    }];
    _introLabel = [UILabel new];
    _introLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    _introLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [self.contentView addSubview:_introLabel];
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dianpuLabel);
        make.top.equalTo(dianpuLabel.mas_bottom).offset(6);
        make.right.mas_equalTo(-15);
    }];
}
-(void)shopDetailMallModel:(WCLShopSwitchListModel *)models withShopModel:(WCLFindShopModel *)model
{
    _model1=models;
    _model2=model;
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:models.organizePicturePath]];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.shopLogo]];
    _titleNameLabel.text = model.shopName;
    _addressLabel.text = models.organizeAddress;
    _introLabel.text = model.shopIntro;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
