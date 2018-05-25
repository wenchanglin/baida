//
//  WCLHomeGiftCollectionCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLHomeGiftCollectionCell.h"

@implementation WCLHomeGiftCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
    
}
-(void)createUI
{
    UIView *contentView = self.contentView;
    _bgView = [UIImageView new];
    [contentView addSubview:_bgView];
    
    _bgView.sd_layout
    .leftEqualToView(contentView)
    .rightEqualToView(contentView)
    .topEqualToView(contentView)
    .bottomEqualToView(contentView);
    
//    [_bgView setImage:[UIImage imageNamed:@"kapian"]];
    
    _imgView = [UIImageView new];
    [_bgView addSubview:_imgView];
    _imgView.sd_layout
    .leftSpaceToView(_bgView,5)
    .topSpaceToView(_bgView, 15)
    .rightSpaceToView(_bgView, 5)
    .bottomSpaceToView(_bgView, 60);
    [_imgView setContentMode:UIViewContentModeScaleAspectFill];
    [_imgView.layer setMasksToBounds:YES];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont fontWithName:@"SFProText-Regular" size:14];
    _titleLabel.textAlignment= NSTextAlignmentCenter;
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgView.mas_centerX);
        make.width.equalTo(self.imgView);
        make.top.equalTo(self.imgView.mas_bottom).offset(12);
    }];
    
    
    _tagLabel = [UILabel new];
    [_tagLabel setFont:[UIFont fontWithName:@"SFProText-Medium" size:13]];
    [_tagLabel setTextColor:[UIColor colorWithHexString:@"#957E5E"]];
    [_bgView addSubview:_tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.titleLabel.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0.1);
    }];
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [_bgView addSubview:view];
    _fengeView = view;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(2);
    }];
}
-(void)setModels:(WCLHomeGiftModel *)models
{
    _models = models;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:models.giftPicturePath] placeholderImage:[UIImage imageNamed:@"logoImage"]];
    _titleLabel.text = models.relateName;
    _tagLabel.text = [NSString stringWithFormat:@"%@积分",@(models.needScore)];
}
@end
