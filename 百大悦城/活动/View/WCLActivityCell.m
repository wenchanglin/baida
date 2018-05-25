//
//  WCLActivityCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLActivityCell.h"

@implementation WCLActivityCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _sfbackImgeView = [UIImageView new];
    [self.contentView addSubview:_sfbackImgeView];
    [_sfbackImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(175.7);
    }];
    _nameLabel = [UILabel new];
    _nameLabel.numberOfLines=0;
    _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sfbackImgeView.mas_bottom).offset(11.5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(21);
    }];
    _tagView = [TJPTagVIew new];
    _tagView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview: _tagView];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-145);
        make.height.mas_equalTo(30);
    }];
    _timeLabel = [UILabel new];
    _timeLabel.numberOfLines=0;
    _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(31);
        make.left.equalTo(self.nameLabel);
    }];
    _applyBtn = [UIButton new];
    [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _applyBtn.backgroundColor = [UIColor colorWithHexString:@"##E60000"];
    _applyBtn.layer.cornerRadius=15;
    _applyBtn.layer.masksToBounds =YES;
    [self.contentView addSubview:_applyBtn];
    [_applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(14);
        make.right.mas_equalTo(-12);
        make.width.mas_equalTo(102);
        make.height.mas_equalTo(30);
    }];
}




-(void)setModels:(WCLActivityModel *)models
{
    _models = models;
    [_sfbackImgeView sd_setImageWithURL:[NSURL URLWithString:models.activityPicture] placeholderImage:[UIImage imageNamed:@"banner_placehoder"]];
    _nameLabel.text = models.activityTitle;
    _timeLabel.text =[NSString stringWithFormat:@"%@-%@",models.startTimeStr,models.endTimeStr];
    NSMutableArray * tagInfo = [NSMutableArray array];
    for (NSDictionary* dict in models.tags) {
        [tagInfo addObject:dict[@"tagName"]];
    }
    if (tagInfo.count>0) {
        _tagView.tagInfos = tagInfo;
    }
    else{
        _tagView.tagInfos = @[@"暂无说明"];
    }
    [RACObserve(models, acivityType)subscribeNext:^(id  _Nullable x) {
//        WCLLog(@"%@",x);
        if ([x isEqualToString:@"NONEED"]) {
            [self.applyBtn setTitle:@"无需报名" forState:UIControlStateNormal];
            self.applyBtn.enabled = NO;
        }
        else if ([x isEqualToString:@"FREE"])
        {
            [self.applyBtn setTitle:@"免费报名" forState:UIControlStateNormal];
            self.applyBtn.enabled = YES;
            self.applyBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                [SVProgressHUD showWithStatus:@"你点击了免费报名"];
                [SVProgressHUD dismissWithDelay:1];
                return [RACSignal empty];
            }];
        }
        else if ([x isEqualToString:@"SCORE"])
        {
            
            [self.applyBtn setTitle:[NSString stringWithFormat:@"%@积分报名",models.enrollScore.length>0?models.enrollScore:@"0"] forState:UIControlStateNormal];
            self.applyBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                [SVProgressHUD showWithStatus:@"你点击了积分报名"];
                [SVProgressHUD dismissWithDelay:1];
                return [RACSignal empty];
            }];
        }
        else if ([x isEqualToString:@"CASH"])
        {
            [self.applyBtn setTitle:[NSString stringWithFormat:@"¥%@报名",models.enrollFee.length>0?models.enrollFee:@"0"] forState:UIControlStateNormal];
            self.applyBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                [SVProgressHUD showWithStatus:@"你点击了现金报名"];
                [SVProgressHUD dismissWithDelay:1];
                return [RACSignal empty];
            }];
        }
    }];
}

@end
