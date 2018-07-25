//
//  WCLSpecialCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLSpecialCell.h"
#import "WCLFindSpecCollectionCellCell.h"
@implementation WCLSpecialCell
{
    UICollectionView *specCollection;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _specModelArray = [NSMutableArray array];
    }
    return self;
}
-(void)setSpecArr:(NSMutableArray *)specArr
{
    _specArr = specArr;
    [_specModelArray removeAllObjects];
    _specModelArray = specArr;
    if (specCollection) {
        [specCollection reloadData];
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
    specCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    //设置代理
    specCollection.scrollEnabled=NO;
    specCollection.delegate = self;
    specCollection.dataSource = self;
    [self.contentView addSubview:specCollection];
    specCollection.sd_layout
    .centerXEqualToView(self.contentView)
    .widthIs(SCREEN_WIDTH-16)
    .topSpaceToView(self.contentView,-2)
    .leftSpaceToView(self.contentView, 8)
    .rightSpaceToView(self.contentView, 8)
    .bottomSpaceToView(self.contentView,5);
    
    [specCollection registerClass:[WCLFindSpecCollectionCellCell class] forCellWithReuseIdentifier:@"WCLFindSpecCollectionCellCell"];
    //    [giftCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    [specCollection setBackgroundColor:[UIColor whiteColor]];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_specModelArray count];
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WCLGoodsModel *deModel = _specModelArray[indexPath.item];
    WCLFindSpecCollectionCellCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLFindSpecCollectionCellCell" forIndexPath:indexPath];
    cell.models = deModel;
    if (indexPath.item==_specModelArray.count-2||indexPath.item==_specModelArray.count-1) {
        cell.fengeView.hidden =YES;
    }
    else
    {
        cell.fengeView.hidden = NO;
    }
        [cell sizeToFit];
    
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake(SCREEN_WIDTH / 2 - 8, 240);//CGSizeMake(169.5+16, 105+28);
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
    WCLGoodsModel *deModel = _specModelArray[indexPath.item];
//    self.specdidselect(deModel.nowPrice, deModel.commodityId);
    self.specdidselect(deModel);
}
@end
