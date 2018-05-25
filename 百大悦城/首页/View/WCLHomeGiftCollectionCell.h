//
//  WCLHomeGiftCollectionCell.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLHomeGiftModel.h"
@interface WCLHomeGiftCollectionCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *bgView;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *tagLabel;
@property(nonatomic,strong)UIView * fengeView;
@property(nonatomic,strong)WCLHomeGiftModel* models;
@end
