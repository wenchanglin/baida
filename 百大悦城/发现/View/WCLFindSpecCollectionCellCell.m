//
//  WCLFindSpecCollectionCellCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLFindSpecCollectionCellCell.h"

@implementation WCLFindSpecCollectionCellCell
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
    
    _imgView = [UIImageView new];
    _imgView.backgroundColor= [UIColor lightGrayColor];
    [_bgView addSubview:_imgView];
    _imgView.sd_layout
    .leftSpaceToView(_bgView,6)
    .topSpaceToView(_bgView, 15)
    .rightSpaceToView(_bgView, 6)
    .bottomSpaceToView(_bgView, 60);
    [_imgView setContentMode:UIViewContentModeScaleAspectFill];
    [_imgView.layer setMasksToBounds:YES];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    _titleLabel.textAlignment= NSTextAlignmentCenter;
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgView.mas_centerX);
        make.width.equalTo(self.imgView);
        make.top.equalTo(self.imgView.mas_bottom).offset(12);
    }];
    
    _tagLabel = [UILabel new];
    _tagLabel.textAlignment= NSTextAlignmentCenter;
    _tagLabel.font =[UIFont systemFontOfSize:13];
    [_tagLabel setTextColor:[UIColor colorWithHexString:@"#990000"]];
    [_bgView addSubview:_tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(65);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0.1);
        make.height.mas_equalTo(15);
    }];
    _oldTagLabel = [UILabel new];
    _oldTagLabel.textAlignment= NSTextAlignmentCenter;
    _oldTagLabel.font = [UIFont systemFontOfSize:10];
    [_oldTagLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [_bgView addSubview:_oldTagLabel];
    [_oldTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagLabel.mas_right).offset(2);
        make.centerY.equalTo(self.tagLabel.mas_centerY);
        make.height.mas_equalTo(12);
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
-(void)setModels:(WCLGoodsModel *)models
{
    _models = models;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:models.picturePath] placeholderImage:[UIImage imageNamed:@"logoImage"]];
    _titleLabel.text = models.commodityName;
    _tagLabel.text =[NSString stringWithFormat:@"¥%@",models.nowPrice];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:models.oldPrice attributes:attribtDic];
    _oldTagLabel.attributedText = attribtStr;
}
@end
