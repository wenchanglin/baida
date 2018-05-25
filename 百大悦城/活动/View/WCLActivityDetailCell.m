//
//  WCLActivityDetailCell.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityDetailCell.h"

@implementation WCLActivityDetailCell
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
    _titleNameLabel = [UILabel new];
    _titleNameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    _titleNameLabel.numberOfLines=0;
    [self.contentView addSubview:_titleNameLabel];
    [_titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(views.mas_bottom).offset(10);
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
    }];
    _tagView = [TJPTagVIew new];
    _tagView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview: _tagView];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleNameLabel);
        make.top.equalTo(self.titleNameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-24);
        make.height.mas_equalTo(30);
    }];
    _timeLabel = [UILabel new];
    _timeLabel.numberOfLines=0;
    _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagView.mas_bottom).offset(4);
        make.left.equalTo(self.titleNameLabel);
        make.height.mas_equalTo(17);
    }];
    _placeLabel = [UILabel new];
    _placeLabel.numberOfLines=0;
    _placeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    _placeLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [self.contentView addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.right.mas_equalTo(-12);
    }];
    UIView * view2 = [UIView new];
    view2.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    [self.contentView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(10);
    }];
    UIImageView * timeImgView = [UIImageView new];
    timeImgView.image = [UIImage imageNamed:@"icon_activity_time"];
    [self.contentView addSubview:timeImgView];
    [timeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.top.equalTo(view2.mas_bottom).offset(12);
    }];
    UILabel * activitytimeLabel = [UILabel new];
    activitytimeLabel.text = @"活动时间";
    activitytimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.contentView addSubview:activitytimeLabel];
    [activitytimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeImgView.mas_right).offset(8);
        make.centerY.equalTo(timeImgView.mas_centerY);
    }];
    _activityLabel = [UILabel new];
    _activityLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    _activityLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [self.contentView addSubview:_activityLabel];
    [_activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.equalTo(activitytimeLabel.mas_centerY);
    }];
    UIView * view3 = [UIView new];
    view3.backgroundColor= [UIColor colorWithHexString:@"#EDEDED"];
    [self.contentView addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeImgView.mas_bottom).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
    }];
    UIImageView * addressImgView = [UIImageView new];
    addressImgView.image = [UIImage imageNamed:@"home_icon_location"];
    [self.contentView addSubview:addressImgView];
    [addressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.top.equalTo(view3.mas_bottom).offset(12);
    }];
    UILabel * addresstimeLabel = [UILabel new];
    addresstimeLabel.text = @"活动地址";
    addresstimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.contentView addSubview:addresstimeLabel];
    [addresstimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressImgView.mas_right).offset(8);
        make.centerY.equalTo(addressImgView.mas_centerY);
    }];
    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    _addressLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.equalTo(addresstimeLabel.mas_centerY);
    }];
    UIView * view4 = [UIView new];
    view4.backgroundColor= [UIColor colorWithHexString:@"#EDEDED"];
    [self.contentView addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressImgView.mas_bottom).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(10);
    }];
    UIImageView * leftView = [UIImageView new];
    leftView.image = [UIImage imageNamed:@"img_detail_leftline"];
    [self.contentView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.mas_bottom).offset(22);
        make.left.mas_equalTo(91);
        make.height.mas_equalTo(3);
    }];
    UILabel * huodongLabel = [UILabel new];
    huodongLabel.textAlignment = NSTextAlignmentCenter;
    huodongLabel.text = @"活动介绍";
    huodongLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [self.contentView addSubview:huodongLabel];
    [huodongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.mas_bottom).offset(12);
        make.left.equalTo(leftView.mas_right).offset(10);
    }];
    UIImageView * rightView = [UIImageView new];
    rightView.image = [UIImage imageNamed:@"img_detail_rightline"];
    [self.contentView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.mas_bottom).offset(22);
        make.left.equalTo(huodongLabel.mas_right).offset(10);
        make.height.mas_equalTo(3);
    }];
    _introLabel = [UILabel new];
    _introLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.contentView addSubview:_introLabel];
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(huodongLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
    }];
    UIView * botomView = [UIView new];
    [self.contentView addSubview:botomView];
    [botomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
    }];
}
-(void)setModels:(WCLActivityModel *)models
{
    _models = models;
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:models.activityPicture]];
    _titleNameLabel.text = models.activityTitle;
    NSMutableArray * tagInfo = [NSMutableArray array];
    for (NSDictionary* dict in models.tags) {
        [tagInfo addObject:dict[@"tagName"]];
    }
    if (tagInfo.count>0) {
        _tagView.tagInfos = tagInfo;
    }
    _timeLabel.text = [NSString stringWithFormat:@"%@-%@",models.startTimeStr,models.endTimeStr];
    if (models.signupLimitNumber==0) {
        _placeLabel.text = @"";
    }else
    {
    _placeLabel.text = [NSString stringWithFormat:@"剩余名额：%@",@(models.signupLimitNumber-models.signupNumber)];
    }
   NSString * newtime =  [models.startTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    NSString * newtime2 = [NSString stringWithFormat:@"%@:%@",[newtime componentsSeparatedByString:@":"][0],[newtime componentsSeparatedByString:@":"][1]];
    NSString * newtime3 =  [models.endTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    NSString * newtime4 = [NSString stringWithFormat:@"%@:%@",[newtime3 componentsSeparatedByString:@":"][0],[newtime3 componentsSeparatedByString:@":"][1]];
    _activityLabel.text = [NSString stringWithFormat:@"%@-%@",newtime2,newtime4];
    _addressLabel.text = models.acivityAddress; //models.activityIntroduce;
    _introLabel.text = models.activityIntroduce;
}

@end
