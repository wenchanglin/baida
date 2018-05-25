//
//  WCLHomeCouPonCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLHomeCouPonCell.h"

@implementation WCLHomeCouPonCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self==[super initWithStyle:style reuseIdentifier:reuseIdentifier ])
    {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _backImageView = [UIImageView new];
    _backImageView.userInteractionEnabled = YES;
    _backImageView.backgroundColor = [UIColor whiteColor];
    _backImageView.layer.cornerRadius=8;
    _backImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(100);
    }];
    _iconImageView = [UIImageView new];
    CALayer *cellImageLayer = _iconImageView.layer;
    [cellImageLayer setCornerRadius:35];
    [cellImageLayer setMasksToBounds:YES];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.top.mas_equalTo(15);
        make.width.height.mas_equalTo(70);
    }];
    _couponLabel = [UILabel new];
    _couponLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    _couponLabel.font = [UIFont fontWithName:@"SFProText-Regular" size:13];
    [self.contentView addSubview:_couponLabel];
    [_couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(9);
        make.top.equalTo(@19);
        make.width.mas_equalTo(SCREEN_WIDTH-112);
    }];
    _couponSubLabel = [UILabel new];
    _couponSubLabel.font = [UIFont fontWithName:@"SFProText-Regular" size:16];
    [self.contentView addSubview:_couponSubLabel];
    [_couponSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.couponLabel);
        make.top.equalTo(self.couponLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-112);
    }];
    _couponCountLabel = [UILabel new];
    _couponCountLabel.textAlignment = NSTextAlignmentRight;
    _couponCountLabel.textColor = [UIColor colorWithHexString:@"#957E5E"];
    _couponCountLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [self.contentView addSubview:_couponCountLabel];
    [_couponCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-101);
        make.top.equalTo(self.couponSubLabel.mas_bottom).offset(4);
        make.height.mas_equalTo(18);
    }];
    _receiveBtn = [UIButton new];
    _receiveBtn.layer.cornerRadius=8;
    _receiveBtn.layer.masksToBounds=YES;
    _receiveBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
    [self.contentView addSubview:_receiveBtn];
    [_receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.equalTo(self.backImageView);
        make.width.mas_equalTo(80);
    }];
    _receiveLabel = [UILabel new];
    _receiveLabel.numberOfLines=3;
    _receiveLabel.textAlignment = NSTextAlignmentCenter;
    _receiveLabel.textColor = [UIColor colorWithHexString:@"#E0BE8D"];
    _receiveLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [self.contentView addSubview:_receiveLabel];
    [_receiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.receiveBtn);
    }];
}
-(void)setModels:(WCLHomeCouPonModel *)models
{
    _models = models;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:models.couponImage]];
    _couponLabel.text = models.couponName;
    _couponSubLabel.text = models.couponDesc;
    _couponCountLabel.text = [NSString stringWithFormat:@"剩余%@",models.stock];
   
    [RACObserve(models, state)subscribeNext:^(id  _Nullable x) {
        if ([x isEqualToString:@"ROB"]) {
            self.receiveLabel.text = @"已抢完";
            self.receiveBtn.backgroundColor =[UIColor colorWithHexString:@"#999999"];
            self.receiveBtn.enabled=NO;
        }
        else if ([x isEqualToString:@"UNDO"])
        {
            self.receiveLabel.text = @"未开始";
            self.receiveBtn.backgroundColor =[UIColor colorWithHexString:@"#999999"];
            self.receiveBtn.enabled=NO;
        }
        else if ([x isEqualToString:@"RECEIVE"])
        {
            self.receiveLabel.text = @"已领";
            self.receiveBtn.backgroundColor =[UIColor colorWithHexString:@"#999999"];
            self.receiveBtn.enabled=NO;
        }
        else if ([x isEqualToString:@"FREE"])
        {
            self.receiveLabel.text = @"免费抢";
            self.receiveBtn.backgroundColor =[UIColor colorWithHexString:@"#999999"];
            [RACObserve(models, stock) subscribeNext:^(id  _Nullable x) {
                if (x==0) {
                    self.receiveBtn.enabled=NO;
                }
                else
                {
                    self.receiveBtn.enabled =YES;
                    self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                        WCLLog(@"免费抢%@",input);
                        return [RACSignal empty];
                        
                    }];
                }
            }];
        }
        else if ([x isEqualToString:@"POINTS"])
        {
            self.receiveLabel.text = [NSString stringWithFormat:@"%@积分领取",@(models.needScore)];
            [RACObserve(models, stock) subscribeNext:^(id  _Nullable x) {
                if (x==0) {
                    self.receiveBtn.enabled=NO;
                    self.receiveBtn.backgroundColor =[UIColor colorWithHexString:@"#999999"];

                }
                else
                {
                    self.receiveBtn.enabled =YES;
                    self.receiveBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
                    self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                        WCLLog(@"%@",input);
                        return [RACSignal empty];

                    }];

                }
            }];
        }
    }];
}
@end
