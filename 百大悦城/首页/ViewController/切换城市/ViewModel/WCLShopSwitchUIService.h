//
//  WCLShopSwitchUIService.h
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLBaseService.h"
#import "WCLShopSwitchListModel.h"
@interface WCLShopSwitchUIService : WCLBaseService
@property(nonatomic,strong)UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@end
