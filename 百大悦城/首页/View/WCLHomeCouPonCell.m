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
        make.right.mas_equalTo(-126);
    }];
    _couponSubLabel = [UILabel new];
    _couponSubLabel.font = [UIFont fontWithName:@"SFProText-Regular" size:16];
    [self.contentView addSubview:_couponSubLabel];
    [_couponSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.couponLabel);
        make.top.equalTo(self.couponLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-126);
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
    _receiveBtn.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_receiveBtn];
    [_receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.equalTo(self.backImageView);
        make.width.mas_equalTo(80);
    }];
    [_receiveBtn layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.receiveBtn.bounds   byRoundingCorners:UIRectCornerBottomRight|UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.receiveBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    self.receiveBtn.layer.mask = maskLayer;
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
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:models.couponImage] placeholderImage:HeadPlaceHolder];
    if(models.couponTypeCy ==9)
    {
        NSString *jifen ;
        if ([[WCLUserManageCenter shareInstance].userInfoModel.cardLevel isEqualToString:@"VIP积分卡"]) {
            float f = models.accessValue*0.015;
            jifen = [YBLMethodTools formatFloat:f];
              _couponLabel.text =[NSString stringWithFormat:@"%@元-%@",jifen,models.couponName];
        }
        else if ([[WCLUserManageCenter shareInstance].userInfoModel.cardLevel isEqualToString:@"三星贵宾卡"])
        {
           float f=models.accessValue *0.02;
            jifen = [YBLMethodTools formatFloat:f];
              _couponLabel.text =[NSString stringWithFormat:@"%@元-%@",jifen,models.couponName];
        }
        else if([[WCLUserManageCenter shareInstance].userInfoModel.cardLevel isEqualToString:@"五星贵宾卡"])//
        {
            float f = models.accessValue*0.03;
            jifen = [YBLMethodTools formatFloat:f];
              _couponLabel.text =[NSString stringWithFormat:@"%@元-%@",jifen,models.couponName];
        }
        else
        {
            float f = models.accessValue*0.015;
            jifen = [YBLMethodTools formatFloat:f];
            _couponLabel.text =[NSString stringWithFormat:@"%@元-%@",jifen,models.couponName];

        }
      

    }
    else
    {
        _couponLabel.text = [NSString stringWithFormat:@"%@元-%@",@(models.couponValue),models.couponName];
    }
    if ([models.couponTypeKind isEqualToString:@"VOUCHER"]) {
        _couponSubLabel.text = [NSString stringWithFormat:@"满%@元可用,限%@",models.serviceAmount.length>0?models.serviceAmount:@"0",[[models.listCouponShop firstObject] stringForKey:@"shopName"]];
    }
    else

    {
        _couponSubLabel.text = models.couponDesc;
    }
    _couponCountLabel.text = [NSString stringWithFormat:@"剩余%@",@(models.balanceNum)];
    if ([models.accessType isEqualToString:@"POINT"]) {
        if (models.balanceNum>0) {
            if(models.limitNum!=0)
            {
            if (models.memberBroughtNum ==models.limitNum) {
                self.receiveLabel.text =@"已领取";
                self.receiveBtn.backgroundColor =[UIColor colorWithHexString:@"#999999"];
                self.receiveBtn.enabled=YES;
                self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                    self.pointsBlock(models);
                    return [RACSignal empty];
                }];
            }
            else
            {
                if (models.couponTypeCy==9) {
                  
                    self.receiveLabel.text=[NSString stringWithFormat:@"%@积分领取",@(models.accessValue)];
                    self.receiveBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
                    self.receiveBtn.enabled=YES;
                    self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                        self.fanliBlock(models,[NSString stringWithFormat:@"%@",@(models.accessValue)]);
                        return [RACSignal empty];
                    }];
                }
                else
                {
                self.receiveLabel.text =[NSString stringWithFormat:@"%@积分领取",@(models.accessValue)];
                self.receiveBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
                self.receiveBtn.enabled=YES;
                self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                    self.pointsBlock(models);
                    return [RACSignal empty];
                }];
                }
            }
        }
            else
            {
                self.receiveLabel.text =[NSString stringWithFormat:@"%@积分领取",@(models.accessValue)];
                self.receiveBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
                self.receiveBtn.enabled=YES;
                self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                    self.pointsBlock(models);
                    return [RACSignal empty];
                }];
            }
        }
        else
        {
            self.receiveLabel.text = @"已抢光";
            self.receiveBtn.backgroundColor =[UIColor colorWithHexString:@"#E6E9F2"];
            self.receiveBtn.enabled=NO;
        }

    }
    else if ([models.accessType isEqualToString:@"BUY"])
    {

    }
    else if([models.accessType isEqualToString:@"FREE"])
    {
        if (models.balanceNum>0) {
            if (models.limitNum!=0) {
                if (models.memberBroughtNum ==models.limitNum) {
                self.receiveLabel.text =[NSString stringWithFormat:@"已领取"];
                self.receiveBtn.backgroundColor =[UIColor colorWithHexString:@"#999999"];
                    self.receiveBtn.enabled=YES;
                    self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                        self.freeBlock(models);
                        return [RACSignal empty];
                    }];
            }
            else
            {
                self.receiveLabel.text =@"免费领取";
                self.receiveBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
                self.receiveBtn.enabled=YES;
                self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                    self.freeBlock(models);
                    return [RACSignal empty];
                }];
            }
            }
            else
            {
                self.receiveLabel.text =@"免费领取";
                self.receiveBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
                self.receiveBtn.enabled=YES;
                self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                    self.freeBlock(models);
                    return [RACSignal empty];
                }];
            }
        }
        else
        {
            self.receiveLabel.text = @"已抢光";
            self.receiveBtn.backgroundColor =[UIColor colorWithHexString:@"#999999"];
            self.receiveBtn.enabled=YES;
            self.receiveBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                self.freeBlock(models);
                return [RACSignal empty];
            }];
        }
    }

}
@end
