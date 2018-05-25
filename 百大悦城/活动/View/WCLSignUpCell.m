//
//  WCLSignUpCell.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLSignUpCell.h"

@implementation WCLSignUpCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    UIImageView * leftView = [UIImageView new];
    leftView.image = [UIImage imageNamed:@"img_detail_leftline"];
    [self.contentView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22);
        make.left.mas_equalTo(91);
        make.height.mas_equalTo(3);
    }];
    UILabel * huodongLabel = [UILabel new];
    huodongLabel.textAlignment = NSTextAlignmentCenter;
    huodongLabel.text = @"报名须知";
    huodongLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [self.contentView addSubview:huodongLabel];
    [huodongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.equalTo(leftView.mas_right).offset(10);
    }];
    UIImageView * rightView = [UIImageView new];
    rightView.image = [UIImage imageNamed:@"img_detail_rightline"];
    [self.contentView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView);
        make.left.equalTo(huodongLabel.mas_right).offset(10);
        make.height.mas_equalTo(3);
    }];
    UILabel * baomingLabel = [UILabel new];
    baomingLabel.text = @"报名条件：";
    [self.contentView addSubview:baomingLabel];
    [baomingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView.mas_bottom).offset(34);
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(18);
    }];
    UIView * view1 = [UIView new];
    view1.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baomingLabel.mas_bottom).offset(13);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}
-(void)setModels:(WCLActivityMemberModel *)models
{
    _models = models;
}
@end
