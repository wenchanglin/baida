//
//  WCLHomeGiftCell.h
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLHomeGiftModel.h"
typedef void(^giftdidSelctBlock)(NSInteger index);

@interface WCLHomeGiftCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *giftModelArray;
@property (nonatomic,strong) NSMutableArray *giftArr;
@property(nonatomic,copy)giftdidSelctBlock giftSelectBlock;

@end
