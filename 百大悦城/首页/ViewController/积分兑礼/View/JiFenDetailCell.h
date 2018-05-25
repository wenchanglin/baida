//
//  JiFenDetailCell.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiFenModel.h"
@interface JiFenDetailCell : UITableViewCell
@property(nonatomic,strong)UIImageView * headerView;
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UILabel * introLabel;
@property(nonatomic,strong)UILabel * shuliangLabel;
@property(nonatomic,strong)UILabel * countLabel;
@property(nonatomic,strong)UIButton *cutBtn;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,assign)NSInteger clothesCount;
@property(nonatomic,strong)UILabel * exchangeLabel;
@property(nonatomic,strong)UILabel *giftintroLabel;
@property(nonatomic,strong)JiFenModel * models;
@end
