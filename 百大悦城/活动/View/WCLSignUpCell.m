//
//  WCLSignUpCell.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLSignUpCell.h"

@implementation WCLSignUpCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _titleNameLabel = [UILabel new];
    _titleNameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    _titleNameLabel.numberOfLines=0;
    [self.contentView addSubview:_titleNameLabel];
    [_titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(12);
//        make.right.mas_equalTo(-12);
    }];
    _inputTextField = [UITextField new];
    _inputTextField.delegate = self;
    _inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_inputTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:15]];
    [_inputTextField setTextColor:[UIColor colorWithHexString:@"#CCCCCC"]];
    [_inputTextField setValue:[UIColor colorWithHexString:@"#CCCCCC"] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    [self.contentView addSubview:_inputTextField];
    [_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleNameLabel.mas_centerY);
        make.right.mas_equalTo(-12);
    }];
    [self.contentView addSubview:_inputTextField];
   
}
-(void)setModels:(WCLOptinListModel *)models
{
    _models =models;
    NSString * titles = [NSString stringWithFormat:@"*%@",models.title];
    _titleNameLabel.attributedText = [self heightLowTextWithString:titles];
    _inputTextField.placeholder = [NSString stringWithFormat:@"请输入您的%@",models.title];

}
-(NSMutableAttributedString*)heightLowTextWithString:(NSString*)string{
    NSMutableAttributedString *textColor1 = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange rangel = [[textColor1 string] rangeOfString:[string substringWithRange:NSMakeRange(0, 1)]];
    NSRange rangel2 = [[textColor1 string] rangeOfString:[string substringWithRange:NSMakeRange(1, string.length-1)]];
    [textColor1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:rangel];
    [textColor1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#D0021B"] range:rangel];
    [textColor1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:rangel2];
    [textColor1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:rangel2];
    return textColor1;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([_delegate respondsToSelector:@selector(textDetail:key:tag:)]) {
        [_delegate textDetail:textField.text key:_models.title tag:self.tag];
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
    if ([_delegate respondsToSelector:@selector(textDetail:key:tag:)]) {
        [_delegate textDetail:textField.text key:_models.title tag:self.tag];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_delegate respondsToSelector:@selector(textDetail:key:tag:)]) {
        [_delegate textDetail:textField.text key:_models.title tag:self.tag];
    }
    return YES;
}

@end
