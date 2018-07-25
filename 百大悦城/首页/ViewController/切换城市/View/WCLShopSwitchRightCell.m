//
//  WCLShopSwitchRightCell.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopSwitchRightCell.h"

@implementation WCLShopSwitchRightCell

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
    view2.frame = CGRectMake(15, 15, 244, 122);
    view2.layer.shadowOpacity = 0.4;
    view2.layer.shadowOffset = CGSizeMake(0, 4);
    [self.contentView addSubview:view2];
    _backImgView = [UIImageView new];
    _backImgView.layer.cornerRadius=6;
    _backImgView.layer.masksToBounds=YES;
    [view2 addSubview:_backImgView];
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.mas_equalTo(IsiPhoneX?-16:-52);
        make.height.mas_equalTo(122);
    }];
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    _nameLabel.textColor = [UIColor colorWithHexString:@"#101010"];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImgView.mas_bottom).offset(10);
        make.left.right.equalTo(self.backImgView);
    }];
    _subNameLabel = [UILabel new];
    _subNameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    _subNameLabel.textColor = [UIColor colorWithHexString:@"#A9B5C4"];
    [self.contentView addSubview:_subNameLabel];
    [_subNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(2);
        make.left.right.equalTo(self.backImgView);
    }];
}
-(void)setModels:(WCLShopSwitchListModel *)models
{
    _models = models;
//    WCLLog(@"%@",models.organizePicturePath);
    [_backImgView sd_setImageWithURL:[NSURL URLWithString:models.organizePicturePath] placeholderImage:[UIImage imageNamed:@"icon_big_placeholder"] options:SDWebImageAllowInvalidSSLCertificates];
    _nameLabel.text = models.organizeName;
    _subNameLabel.text = models.organizeAddress;
}
@end
