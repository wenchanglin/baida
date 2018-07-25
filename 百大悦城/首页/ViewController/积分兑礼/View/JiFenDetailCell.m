//
//  JiFenDetailCell.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "JiFenDetailCell.h"

@implementation JiFenDetailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _clothesCount =1;
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _headerView =[UIImageView new];
    _headerView.contentMode = UIViewContentModeScaleAspectFill;
    _headerView.clipsToBounds=YES;
    [self.contentView addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(375);
    }];
    UIView * view1 =[UIView new];
    view1.backgroundColor = [UIColor colorWithHexString:@"#990000"];
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    _leftLabel = [UILabel new];
    _leftLabel.textColor = [UIColor whiteColor];
    _leftLabel.font = [UIFont fontWithName:@"SFProText-Medium" size:22];
    [view1 addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.equalTo(view1.mas_centerY);
    }];
    _rightLabel = [UILabel new];
    _rightLabel.textColor = [UIColor whiteColor];
    _rightLabel.font = [UIFont fontWithName:@"SFProText-Regular" size:14];
    [view1 addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.equalTo(view1.mas_centerY);
    }];
    _introLabel = [UILabel new];
    _introLabel.textColor = [UIColor blackColor];
    _introLabel.font = [UIFont fontWithName:@"SFProDisplay-Medium" size:16];
    [self.contentView addSubview:_introLabel];
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.left.mas_equalTo(12);
        make.top.equalTo(view1.mas_bottom).offset(10);
    }];
    UIView * view2 = [UIView new];
    view2.backgroundColor =[UIColor colorWithHexString:@"#EDEDED"];
    [self.contentView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introLabel.mas_bottom).offset(13);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    _shuliangLabel = [UILabel new];
    _shuliangLabel.text = @"兑换数量";
    _shuliangLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    _shuliangLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.contentView addSubview:_shuliangLabel];
    [_shuliangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom).offset(22);
        make.left.equalTo(self.introLabel);
    }];
    UIButton *buttonCut = [UIButton new];
    [buttonCut setTitle:@"-" forState:UIControlStateNormal];
    [buttonCut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonCut.layer setBorderWidth:1];
    [buttonCut.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.contentView addSubview:buttonCut];
    [buttonCut setTag:55];
    [buttonCut addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [buttonCut.layer setCornerRadius:3];
    [buttonCut.layer setMasksToBounds:YES];
    _cutBtn = buttonCut;
    [buttonCut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shuliangLabel.mas_centerY);
        make.left.equalTo(self.shuliangLabel.mas_right).offset(IsiPhoneX?SCREEN_SCALE_Iphone6*140: SCREEN_SCALE_Iphone6*110);
        make.height.mas_equalTo(36);
    }];
    _countLabel = [UILabel new];
    [_countLabel.layer setBorderWidth:1];
    [_countLabel.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_countLabel setTextAlignment:NSTextAlignmentCenter];
    [_countLabel setFont:[UIFont systemFontOfSize:12]];
    _countLabel.textColor = [UIColor blackColor];
    _countLabel.text = [NSString stringWithFormat:@"%ld",_clothesCount];
    [self.contentView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttonCut.mas_right);
        make.width.mas_equalTo(150-72);
        make.centerY.equalTo(buttonCut.mas_centerY);
        make.height.mas_equalTo(36);
    }];
//
    UIButton *buttonAdd = [UIButton new];
    [buttonAdd setTitle:@"+" forState:UIControlStateNormal];
    [buttonAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonAdd.layer setBorderWidth:1];
    [buttonAdd setTag:56];
    [buttonAdd.layer setCornerRadius:3];
    [buttonAdd.layer setMasksToBounds:YES];
    [buttonAdd.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [buttonAdd addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn = buttonAdd;
    [self.contentView addSubview:buttonAdd];
    [buttonAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countLabel.mas_right);
        make.centerY.equalTo(self.shuliangLabel.mas_centerY);
        make.height.mas_equalTo(36);
    }];
    UIView * view3 = [UIView new];
    view3.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    [self.contentView addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonCut.mas_bottom).offset(12);
        make.height.mas_equalTo(10);
        make.left.right.equalTo(self.contentView);
    }];
   
    UILabel * huodongLabel = [UILabel new];
    huodongLabel.textAlignment = NSTextAlignmentCenter;
    huodongLabel.text = @"兑换说明";
    huodongLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [self.contentView addSubview:huodongLabel];
    [huodongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom).offset(12);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    UIImageView * leftView = [UIImageView new];
    leftView.image = [UIImage imageNamed:@"img_detail_leftline"];
    [self.contentView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom).offset(22);
        make.right.equalTo(huodongLabel.mas_left).offset(-10);
        make.height.mas_equalTo(3);
    }];
    UIImageView * rightView = [UIImageView new];
    rightView.image = [UIImage imageNamed:@"img_detail_rightline"];
    [self.contentView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom).offset(22);
        make.left.equalTo(huodongLabel.mas_right).offset(10);
        make.height.mas_equalTo(3);
    }];
    _exchangeLabel = [UILabel new];
    _exchangeLabel.numberOfLines=0;
    _exchangeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _exchangeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.contentView addSubview:_exchangeLabel];
    [_exchangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(huodongLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
    }];
    UIView * view4 = [UIView new];
    view4.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    [self.contentView addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.exchangeLabel.mas_bottom).offset(20);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    UILabel * huodongLabel2 = [UILabel new];
    huodongLabel2.textAlignment = NSTextAlignmentCenter;
    huodongLabel2.text = @"礼品介绍";
    huodongLabel2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [self.contentView addSubview:huodongLabel2];
    [huodongLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.mas_bottom).offset(12);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    UIImageView * leftView2 = [UIImageView new];
    leftView2.image = [UIImage imageNamed:@"img_detail_leftline"];
    [self.contentView addSubview:leftView2];
    [leftView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.mas_bottom).offset(22);
        make.right.equalTo(huodongLabel2.mas_left).offset(-10);
        make.height.mas_equalTo(3);
    }];
   
    UIImageView * rightView2 = [UIImageView new];
    rightView2.image = [UIImage imageNamed:@"img_detail_rightline"];
    [self.contentView addSubview:rightView2];
    [rightView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.mas_bottom).offset(22);
        make.left.equalTo(huodongLabel2.mas_right).offset(10);
        make.height.mas_equalTo(3);
    }];
    _giftintroLabel = [UILabel new];
    _giftintroLabel.numberOfLines=0;
    _giftintroLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _giftintroLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.contentView addSubview:_giftintroLabel];
    [_giftintroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(huodongLabel2.mas_bottom).offset(12);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-10);
    }];
//    UIView* line = [UIView new];
//    [self.contentView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.giftintroLabel.mas_bottom).offset(20);
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(0.5);
//        make.bottom.mas_equalTo(0); // 这句很重要！！！
//
//    }];
}
-(void)click:(UIButton*)btn
{
    switch (btn.tag) {
        case 55:
            {
                if (_clothesCount>1) {
                    _clothesCount -=1;
                }
            }
            break;
          case 56:
        {
            if (_clothesCount<_models.limitGetNum&&_models.limitGetNum<_models.balanceNum) {
                _clothesCount +=1;
            }
            else if (_models.limitGetNum>=_models.balanceNum)
            {
                if(_clothesCount<_models.balanceNum)
                {
                    _clothesCount +=1;
                }
            }
            else if (_models.limitGetNum==0)
            {
                if (_clothesCount<_models.balanceNum) {
                    _clothesCount +=1;
                }
            }
            else
            {
                [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"每人限制兑换%@个哦～",@(_models.limitGetNum)]];
                [SVProgressHUD dismissWithDelay:1];
            }
        }break;
        default:
            break;
    }
    [_countLabel setText:[NSString stringWithFormat:@"%ld",_clothesCount]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changecount" object:nil userInfo:@{@"shuliang":@(_clothesCount),@"jifen":@(_models.needScore)}];
}
-(void)setModels:(JiFenModel *)models
{
    _models = models;
    [_headerView sd_setImageWithURL:[NSURL URLWithString:models.picUrl]];
    _leftLabel.text = [NSString stringWithFormat:@"%@积分",@(models.needScore)];
    _rightLabel.text = [NSString stringWithFormat:@"还剩%@件",@(models.balanceNum)];
    _introLabel.text = models.relateName;
    _exchangeLabel.text = models.exchangeIntro;
    _giftintroLabel.text = models.giftIntro;
//    _giftintroLabel.text = @"ajfsjalkfjlkjsalfjalkfjlakjflajf;lajfl;kjsdfj uqworiuooitlkdsjfljalkfjoiqdfiudojkldjafoijaf";
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
