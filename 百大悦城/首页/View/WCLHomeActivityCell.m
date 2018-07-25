//
//  WCLHomeActivityCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLHomeActivityCell.h"
@implementation WCLHomeActivityCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _sfbackImgeView = [UIImageView new];
    _sfbackImgeView.layer.cornerRadius = 8;
    _sfbackImgeView.layer.masksToBounds=YES;
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
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.mas_equalTo(30);
    }];
    _timeLabel = [UILabel new];
    _timeLabel.numberOfLines=0;
    _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagView.mas_bottom).offset(10);
        make.left.equalTo(self.nameLabel);
    }];
    _applyBtn = [UIButton new];
    [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _applyBtn.backgroundColor = [UIColor colorWithHexString:@"##E60000"];
    _applyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _applyBtn.layer.cornerRadius=15;
    _applyBtn.layer.masksToBounds =YES;
    [self.contentView addSubview:_applyBtn];
    [_applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.timeLabel.mas_bottom);
        make.right.mas_equalTo(-12);
        make.width.mas_equalTo(102);
        make.height.mas_equalTo(30);
    }];
}




-(void)setModels:(WCLHomeActivityModel *)models
{
    _models = models;
    [_sfbackImgeView sd_setImageWithURL:[NSURL URLWithString:models.activityPic] placeholderImage:[UIImage imageNamed:@"icon_big_placeholder"]];
    _nameLabel.text = models.activityName;
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
    WEAK
    [RACObserve(models, memberSignupState)subscribeNext:^(id  _Nullable x) {
        STRONG
        if ([x isEqualToString:@"已结束"]||[x isEqualToString:@"待报名"]||[x isEqualToString:@"已失效"]) {
            if ([models.acivityType isEqualToString:@"NONEED"]) {
                self.string1 = @"无需报名";
            }
            if ([self.string1 isEqualToString:@"无需报名"]) {
                //                [self.applyBtn setTitle:self.string1 forState:UIControlStateNormal];
                self.applyBtn.backgroundColor = [UIColor whiteColor];
                self.applyBtn.enabled = NO;
            }
            else
            {
            [self.applyBtn setTitle:x forState:UIControlStateNormal];
            self.applyBtn.backgroundColor = [UIColor grayColor];
            self.applyBtn.enabled = NO;
            }
        }
        else if ([x isEqualToString:@"去报名"])
        {
            [RACObserve(models, acivityType)subscribeNext:^(id  _Nullable x) {
                STRONG
                if ([x isEqualToString:@"NONEED"]) {
                    self.string1 = @"无需报名";
                }
                else if ([x isEqualToString:@"FREE"])
                {
                    self.string1 = @"免费报名";
                }
                else if ([x isEqualToString:@"SCORE"])
                {
                    WCLLog(@"%@",models.needScore);
                    self.string1 =[NSString stringWithFormat:@"%@积分报名",models.needScore.length>0?models.needScore:@"0"];
                }
                else if ([x isEqualToString:@"CASH"])
                {
                    self.string1 = [NSString stringWithFormat:@"¥%@报名",models.accessValue];
                }
            }];
            CGRect rect = [YBLMethodTools jisuanTextHeightForString:self.string1 withWidth:SCREEN_WIDTH-100 withFont:self.applyBtn.titleLabel.font];
            [self.applyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.timeLabel.mas_bottom);
                make.right.mas_equalTo(-12);
                make.width.mas_equalTo(rect.size.width+40);
                make.height.mas_equalTo(30);
            }];
            if ([self.string1 isEqualToString:@"无需报名"]) {
//                [self.applyBtn setTitle:self.string1 forState:UIControlStateNormal];
                self.applyBtn.backgroundColor = [UIColor whiteColor];
                self.applyBtn.enabled = NO;
            }
            else
            {
                [self.applyBtn setTitle:self.string1 forState:UIControlStateNormal];
                self.applyBtn.backgroundColor = [UIColor colorWithHexString:@"#E60000"];
                self.applyBtn.enabled = YES;
                self.applyBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                    self.signblocks(models.objectId);
                    return [RACSignal empty];
                }];
            }
           
        }
        else if ([x isEqualToString:@"去参加"]||[x isEqualToString:@"已报名"])
        {
            [self.applyBtn setTitle:@"已报名" forState:UIControlStateNormal];
            self.applyBtn.backgroundColor = [UIColor colorWithHexString:@"#E60000"];
            self.applyBtn.enabled = YES;
            self.applyBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                self.blocks(models.objectId);
                return [RACSignal empty];
            }];
        }
    }];
}
@end
