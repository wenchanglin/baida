
//
//  WCLMineCollectionCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/17.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLMineCollectionCell.h"

@implementation WCLMineCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _backImageView = [UIImageView new];
    _backImageView.layer.cornerRadius=8;
    _backImageView.layer.masksToBounds=YES;
    [self.contentView addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.mas_equalTo(-20);
    }];
    _placeImageView = [UIImageView new];
    [self.contentView addSubview:_placeImageView];
    [_placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView.mas_top).offset(35);
        make.left.equalTo(self.backImageView.mas_left).offset(25);
//        make.height.width.mas_equalTo(30);
    }];
    _cnNameLabel = [UILabel new];
    _cnNameLabel.textColor = [UIColor colorWithHexString:@"#194F82"];
    _cnNameLabel.font = [UIFont fontWithName:@"SFProDisplay-Medium" size:15];
    [self.contentView addSubview:_cnNameLabel];
    [_cnNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.placeImageView.mas_right).offset(10);
        make.top.equalTo(self.backImageView.mas_top).offset(31);
        make.height.mas_equalTo(21);
    }];
    _engnameLabel = [UILabel new];
    _engnameLabel.textColor = [UIColor colorWithHexString:@"#194F82"];
    _engnameLabel.font = [UIFont fontWithName:@"SFProDisplay-Medium" size:12];
    [self.contentView addSubview:_engnameLabel];
    [_engnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cnNameLabel);
        make.top.equalTo(self.cnNameLabel.mas_bottom).offset(2);
        make.height.mas_equalTo(14);
    }];
    _decLabel = [UILabel new];
    _decLabel.textAlignment = NSTextAlignmentCenter;
    _decLabel.textColor = [UIColor colorWithHexString:@"#859BAB"];
    _decLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.contentView addSubview:_decLabel];
    [_decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImageView.mas_left).offset(25);
        make.top.equalTo(self.engnameLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(14);
    }];
}
-(void)setSixDic:(NSDictionary *)sixDic
{
    _sixDic = sixDic;
    //  @{@"icon":@"user_icon_apptool",@"cntitle":@"付款",@"entitle":@"Pay Code"},
    _placeImageView.image = [UIImage imageNamed:[sixDic stringForKey:@"icon"]];
    _cnNameLabel.text = [sixDic stringForKey:@"cntitle"];
    _engnameLabel.text = [sixDic stringForKey:@"entitle"];
    _decLabel.text = [sixDic stringForKey:@"desc"];
}
@end
