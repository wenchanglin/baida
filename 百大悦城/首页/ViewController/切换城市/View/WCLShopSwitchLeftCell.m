//
//  WCLShopSwitchLeftCell.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopSwitchLeftCell.h"

@implementation WCLShopSwitchLeftCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
   
    self.yellowView = [UIView new];
    self.yellowView.layer.cornerRadius=8;
    self.yellowView.layer.masksToBounds = YES;
    self.yellowView.backgroundColor = [UIColor colorWithHexString:@"#990000"];
    [self.contentView addSubview:self.yellowView];
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(11);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(29);
    }];
    _leftBtn = [UILabel new];
    self.leftBtn.highlightedTextColor = [UIColor whiteColor];
    self.leftBtn.textColor = [UIColor colorWithHexString:@"#101010"];
    [self.contentView addSubview:_leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.top.mas_equalTo(14);
        make.height.mas_equalTo(22);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
//    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.leftBtn.highlighted = selected;
    self.yellowView.hidden = !selected;
}
@end
