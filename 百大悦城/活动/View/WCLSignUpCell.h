//
//  WCLSignUpCell.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/22.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLOptinListModel.h"
@protocol measureLabelAndTextDelegate <NSObject>

-(void)textDetail:(NSString *)detail key:(NSString*)key tag:(NSInteger)index;
@end
@interface WCLSignUpCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleNameLabel;
@property(nonatomic,strong)UITextField *inputTextField;
@property(nonatomic,strong)WCLOptinListModel* models;
@property (nonatomic, weak) id<measureLabelAndTextDelegate>delegate;

@end
