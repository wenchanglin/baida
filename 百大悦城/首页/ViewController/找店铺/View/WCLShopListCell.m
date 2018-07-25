//
//  WCLShopListCell.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopListCell.h"

@implementation WCLShopListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _backImageView = [UIImageView new];
    _backImageView.layer.cornerRadius=4;
    _backImageView.layer.masksToBounds=YES;
    _backImageView.backgroundColor =[UIColor whiteColor];
    [self.contentView addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(110);
    }];
    _iconImageView = [UIImageView new];
    _iconImageView.layer.cornerRadius=4;
    _iconImageView.layer.masksToBounds=YES;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView.mas_top).offset(10);
        make.left.equalTo(self.backImageView.mas_left).offset(10);
        make.width.height.mas_equalTo(90);
    }];
    _nameLabel = [UILabel new];
    _nameLabel.numberOfLines=2;
    _nameLabel.font = [UIFont fontWithName:@"SFProText-Medium" size:17];
    _nameLabel.textColor =[UIColor colorWithHexString:@"#1A1A1A"];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView.mas_top).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(8);
        make.right.equalTo(self.backImageView.mas_right).offset(-10);
    }];
    _subLabel = [UILabel new];
    _subLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _subLabel.textColor =[UIColor colorWithHexString:@"#999999"];
    [self.contentView addSubview:_subLabel];
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.nameLabel);
    }];
    UIView * view1 = [UIView new];
    view1.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subLabel.mas_right).offset(5);
        make.top.equalTo(self.subLabel);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(17);
    }];
    _floorLabel = [UILabel new];
    _floorLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _floorLabel.textColor =[UIColor colorWithHexString:@"#999999"];
    [self.contentView addSubview:_floorLabel];
    [_floorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subLabel);
        make.left.equalTo(view1.mas_right).offset(5);
    }];
    _smallIcon = [UIImageView new];
    _smallIcon.image =[UIImage imageNamed:@"icon_mall_card"];
    [self.contentView addSubview:_smallIcon];
    [_smallIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subLabel);
        make.top.equalTo(self.subLabel.mas_bottom).offset(8);
    }];
    _teQuanLabel = [UILabel new];
    _teQuanLabel.text = @"支持会员卡特权及优惠";
    _teQuanLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _teQuanLabel.textColor= [UIColor colorWithHexString:@"#101010"];
    [self.contentView addSubview:_teQuanLabel];
    [_teQuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smallIcon.mas_right).offset(5);
        make.top.equalTo(self.subLabel.mas_bottom).offset(8);
    }];
}
-(void)setModel:(WCLFindShopModel *)model
{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.shopLogo] placeholderImage:HeadPlaceHolder];
    _nameLabel.text = model.shopName;
    for (NSDictionary * dict in model.industryList) {
        _subLabel.text = [dict stringForKey:@"industryName"];
    }
    if (model.berthNo.length>0) {
        _floorLabel.text =[NSString stringWithFormat:@"%@-%@",model.floorName,model.berthNo];
    }
    else
    {
        _floorLabel.text =model.floorName;
    }
    if ([model.isScoreShop isEqualToString:@"N"]) {
//        WCLLog(@"不支持会员卡");
        _smallIcon.hidden=YES;
        _teQuanLabel.hidden=YES;
    }
    else
    {
//        WCLLog(@"支持会员卡");
        _smallIcon.hidden=NO;
        _teQuanLabel.hidden=NO;
    }
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
