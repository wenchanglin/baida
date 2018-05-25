//
//  JiFenColletionCell.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiFenModel.h"
@interface JiFenColletionCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *bgView;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *tagLabel;
@property(nonatomic,strong)UIView * fengeView;
@property(nonatomic,strong)JiFenModel* models;
@end
