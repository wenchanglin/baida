//
//  WCLHomeGiftCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/16.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLHomeGiftCell.h"
#import "WCLHomeGiftCollectionCell.h"
@implementation WCLHomeGiftCell
{
    UICollectionView *giftCollection;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _giftModelArray = [NSMutableArray array];
    }
    return self;
}
-(void)setGiftArr:(NSMutableArray *)giftArr
{
    _giftArr = giftArr;
    [_giftModelArray removeAllObjects];
    _giftModelArray = giftArr;
    if (giftCollection) {
        [giftCollection reloadData];
    } else {
        [self setUp];
    }
}
-(void)setUp
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0;
    //        flowLayout.headerReferenceSize = CGSizeMake(self.frame.size.width, 0);//头部
    giftCollection = [[UICollectionView alloc]initWithFrame:CGRectZero//CGRectMake(8, 0, SCREEN_WIDTH - 16,self.height)
        collectionViewLayout:flowLayout];
    //设置代理
    giftCollection.showsHorizontalScrollIndicator = NO;
    giftCollection.delegate = self;
    giftCollection.dataSource = self;
    [self.contentView addSubview:giftCollection];
    giftCollection.sd_layout
    .centerXEqualToView(self.contentView)
    .widthIs(SCREEN_WIDTH-16)
    .topSpaceToView(self.contentView,-2)
    .leftSpaceToView(self.contentView, 8)
    .rightSpaceToView(self.contentView, 8)
    .bottomSpaceToView(self.contentView,5);
    
    [giftCollection registerClass:[WCLHomeGiftCollectionCell class] forCellWithReuseIdentifier:@"WCLHomeGiftCollectionCell"];
//    [giftCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    [giftCollection setBackgroundColor:[UIColor whiteColor]];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_giftModelArray count];
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WCLHomeGiftModel *deModel = _giftModelArray[indexPath.item];
    WCLHomeGiftCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLHomeGiftCollectionCell" forIndexPath:indexPath];
    cell.models = deModel;
    if (indexPath.item==_giftModelArray.count-2||indexPath.item==_giftModelArray.count-1) {
        cell.fengeView.hidden =YES;
    }
    else
    {
        cell.fengeView.hidden = NO;
    }
//  
//    [cell.nameLabel setText:deModel.functionName];
//    [cell sizeToFit];
    
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake(SCREEN_WIDTH / 2 - 8, 230);//CGSizeMake(169.5+16, 105+28);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    WCLHomeFuncModel * demodels =_modelArray[indexPath.item];
    //    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    //    [dict setObject:demodels forKey:[NSString stringWithFormat:@"%@",@(indexPath.item)]];
    //    [_funcSubject sendNext:dict];
    //
//    [self.delegate homeFuncClick:indexPath.item];
}
@end
