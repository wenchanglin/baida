//
//  WCLHomeFuncCell.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeFuncDelegate <NSObject>

-(void)homeFuncClick:(NSInteger)index;

@end
@interface WCLHomeFuncCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *modelArray;
@property (nonatomic,strong) NSMutableArray *funcArr;
@property(nonatomic,weak)id<HomeFuncDelegate>delegate;
@end
