//
//  WCLSpecialCell.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCLSpecialCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *specModelArray;
@property (nonatomic,strong) NSMutableArray *specArr;
@end
