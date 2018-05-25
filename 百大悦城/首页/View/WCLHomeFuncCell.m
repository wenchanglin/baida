//
//  WCLHomeFuncCell.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLHomeFuncCell.h"
#import "WCLHomeFuncCollectionCell.h"
#import "WCLHomeFuncModel.h"
@implementation WCLHomeFuncCell
{
    UICollectionView *noThreeCollection;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _modelArray = [NSMutableArray array];
        _funcSubject = [RACSubject subject];
    }
    
    return self;
}
-(void)setFuncArr:(NSMutableArray *)funcArr
{
    _funcArr = funcArr;
    _modelArray = funcArr;
    if (noThreeCollection) {
        [noThreeCollection reloadData];
    } else {
        [self setUp];
    }
}
-(void)setUp
{
    UIView *contentView = self.contentView;
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing = 0;
    //        flowLayout.headerReferenceSize = CGSizeMake(self.frame.size.width, 0);//头部
    noThreeCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    //设置代理
    noThreeCollection.showsHorizontalScrollIndicator = NO;
    noThreeCollection.delegate = self;
    noThreeCollection.dataSource = self;
    [self.contentView addSubview:noThreeCollection];
    noThreeCollection.sd_layout
    .centerXEqualToView(contentView)
    .widthIs(SCREEN_WIDTH)
    .topSpaceToView(contentView,0)
    .bottomSpaceToView(contentView,0);

    [noThreeCollection registerClass:[WCLHomeFuncCollectionCell class] forCellWithReuseIdentifier:@"WCLHomeFuncCollectionCell"];
    [noThreeCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    [noThreeCollection setBackgroundColor:[UIColor whiteColor]];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_modelArray count];
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WCLHomeFuncModel *deModel = _modelArray[indexPath.item];
    WCLHomeFuncCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLHomeFuncCollectionCell" forIndexPath:indexPath];
    [cell.positionImage sd_setImageWithURL:[NSURL URLWithString:deModel.functionIco] placeholderImage:[UIImage imageNamed:@"logoImage"]];
        [cell.nameLabel setText:deModel.functionName];
    [cell sizeToFit];
    
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake(SCREEN_WIDTH/4, (SCREEN_WIDTH)/4+30);//CGSizeMake(169.5+16, 105+28);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 6, 0, 6);
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
    [self.delegate homeFuncClick:indexPath.item];
}
@end
