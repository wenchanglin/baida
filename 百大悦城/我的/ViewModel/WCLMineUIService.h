//
//  WCLMineUIService.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLBaseService.h"
typedef void(^sixBtnBlock)(NSInteger index);

@interface WCLMineUIService : WCLBaseService
@property (nonatomic, strong) UICollectionView *mineCollectionView;
@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UIImageView * userHeaderView;
@property(nonatomic,strong)UIButton * settingBtn;
@property(nonatomic,strong)UIButton * messageBtn;
@property(nonatomic,strong)UIImageView* userBackImageView;
@property(nonatomic,strong)UIButton * loginBtn;
@property(nonatomic,strong)UILabel* userDescLabel;
@property(nonatomic,strong)UILabel* balanceLabel;//余额
@property(nonatomic,strong)UILabel * moneyLabel;//余额
@property(nonatomic,strong)UIView * yueView;//余额分割线
@property(nonatomic,strong)UILabel * integralLabel;//积分
@property(nonatomic,strong)UILabel * jifenLabel;//积分
@property(nonatomic,strong)UIView * jifenView;//余额分割线
@property(nonatomic,strong)UILabel * lvLabel;//等级
@property(nonatomic,strong)UIButton * gradeLabel;//等级
@property(nonatomic,copy)sixBtnBlock sixBtnBlock;
- (void)requestUserInfoData;
@end
