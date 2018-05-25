//
//  WCLHomeFuncCollectionCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLHomeFuncCollectionCell.h"

@implementation WCLHomeFuncCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _positionImage = [UIImageView new];
        [self.contentView addSubview:_positionImage];
        [_positionImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(20);
            make.left.mas_equalTo(22);
            make.height.width.mas_equalTo(60);
        }];
        [_positionImage.layer setCornerRadius:30];
        [_positionImage.layer setMasksToBounds:YES];
        
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
        [_nameLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:13]];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.positionImage.mas_centerX);
            make.top.equalTo(self.positionImage.mas_bottom).offset(7);
            make.height.mas_equalTo(18);
        }];
        
        
    }
    
    return self;
}
@end
