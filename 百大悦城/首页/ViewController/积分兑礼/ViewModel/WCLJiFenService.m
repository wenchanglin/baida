//
//  WCLJiFenService.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLJiFenService.h"
#import "WCLJiFenViewController.h"
#import "WCLJiFenViewModel.h"
#import "JiFenColletionCell.h"
#import "WCLJiFenDetailViewController.h"
static NSInteger btnclick =0;

@interface WCLJiFenService()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) WCLJiFenViewController *jiFenVC;
@property (nonatomic, weak) WCLJiFenViewModel *viewModel;
@property(nonatomic,strong) UIButton *backBtn;
@end
@implementation WCLJiFenService
{
    NSInteger page;
}
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _jiFenVC = (WCLJiFenViewController*)VC;
        page =1;
        _jiFenVC.view.backgroundColor =[UIColor whiteColor];
        _viewModel =(WCLJiFenViewModel*)viewModel;
        [self.jiFenVC.view addSubview:self.jiFenCollectionView];
        [self leftandrightUI];
        btnclick =0;
        [self requestDataWithPage:page];
        
    }
    return self;
}
-(void)leftandrightUI
{
    _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 120, 44)];
    
    WEAK
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        btnclick +=1;
        self->page=1;
        if (btnclick==3) {
            btnclick =0;
            [self.backBtn setImage:[UIImage imageNamed:@"icon_btn_normal"] forState:UIControlStateNormal];
            [self.viewModel.mainArr removeAllObjects];
            [self requestDataWithPage:self->page];

        }
        else if(btnclick==1)
        {
            [self.backBtn setImage:[UIImage imageNamed:@"icon_btn_up"] forState:UIControlStateNormal];
            [self.viewModel.mainArr removeAllObjects];
            [self requestDataWithClick:btnclick withPage:self->page];


        }
        else{
            [self.viewModel.mainArr removeAllObjects];
            [self.backBtn setImage:[UIImage imageNamed:@"icon_btn_down"] forState:UIControlStateNormal];
            [self requestDataWithClick:btnclick withPage:self->page];

        }//2次
    }];
    [_backBtn setTitle:@"积分数" forState:UIControlStateNormal];
    [_backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -_backBtn.imageView.bounds.size.width-3, 0, _backBtn.imageView.bounds.size.width)];
    [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _backBtn.titleLabel.bounds.size.width, 0, -_backBtn.titleLabel.bounds.size.width)];
    _backBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"icon_btn_normal"] forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    self.jiFenVC.navigationItem.rightBarButtonItem = barItem;
    
//    UIButton * rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
//    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//        STRONG
//        WCLMainScanViewController * switchshop = [[WCLMainScanViewController alloc]init];
//        [self.homeVC.navigationController pushViewController:switchshop animated:YES];
//    }];
//    [rightBtn setImage:[UIImage imageNamed:@"JDMainPage_icon_scan"] forState:UIControlStateNormal];
//    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.homeVC.navigationItem.rightBarButtonItem = rightItem;
}

-(void)requestDataWithPage:(NSInteger)pagenum
{
    WEAK
    [[self.viewModel mainDataSignalSortType:@"" pageNum:pagenum] subscribeNext:^(id  _Nullable x) {
        STRONG
        if(btnclick==1)
        {
            self->page=1;
            [self requestDataWithClick:btnclick withPage:self->page];
        }
        else if(btnclick==2)
        {
            self->page=1;
            [self requestDataWithClick:btnclick withPage:self->page];
        }
        else
        {
        NSInteger pages = [[x objectForKey:@"page"] integerValue];
        if (pages>self->page) {
            [YBLMethodTools footerRefreshWithTableView:self.jiFenCollectionView completion:^{
                STRONG
                self->page +=1;
                [self requestDataWithPage:self->page];
            }];
            
            [self.jiFenCollectionView.mj_header endRefreshing];
            [self.jiFenCollectionView reloadData];
            
        }
        else if(pages<=self->page)
        {
            self.jiFenCollectionView.mj_footer.hidden=YES;
            [self.jiFenCollectionView.mj_header endRefreshing];
            [self.jiFenCollectionView reloadData];
            
        }
        }
    }];
}
-(void)requestDataWithClick:(NSInteger)click withPage:(NSInteger)page
{
    WEAK
    if (click==1) {
        [[self.viewModel mainDataSignalSortType:@"ASC" pageNum:self->page] subscribeNext:^(id  _Nullable x) {
            NSInteger pages = [[x objectForKey:@"page"] integerValue];
            if (pages>self->page) {
                [YBLMethodTools footerRefreshWithTableView:self.jiFenCollectionView completion:^{
                    STRONG
                    self->page +=1;
                    [self requestDataWithClick:click withPage:self->page];
                }];
                
                [self.jiFenCollectionView.mj_header endRefreshing];
                [self.jiFenCollectionView reloadData];
                
            }
            else if(pages<=self->page)
            {
                self.jiFenCollectionView.mj_footer.hidden=YES;
                [self.jiFenCollectionView.mj_header endRefreshing];

                [self.jiFenCollectionView reloadData];
                
            }
        }];
  }
    else if (click==2)
    {
        [[self.viewModel mainDataSignalSortType:@"DESC" pageNum:self->page] subscribeNext:^(id  _Nullable x) {
            STRONG
            NSInteger pages = [[x objectForKey:@"page"] integerValue];
            if (pages>self->page) {
                [YBLMethodTools footerRefreshWithTableView:self.jiFenCollectionView completion:^{
                    STRONG
                    self->page +=1;
                    [self requestDataWithClick:click withPage:self->page];
                }];
                
                [self.jiFenCollectionView.mj_header endRefreshing];
                [self.jiFenCollectionView reloadData];
                
            }
            else if(pages<=self->page)
            {
                self.jiFenCollectionView.mj_footer.hidden=YES;
                [self.jiFenCollectionView.mj_header endRefreshing];

                [self.jiFenCollectionView reloadData];
                
            }
        }];
    }
}
-(UICollectionView *)jiFenCollectionView
{
    if (!_jiFenCollectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0;
        //        flowLayout.headerReferenceSize = CGSizeMake(self.frame.size.width, 0);//头部
        _jiFenCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16,IsiPhoneX?SCREEN_HEIGHT-88:SCREEN_HEIGHT-64)
                                           collectionViewLayout:flowLayout];
        //设置代理
        _jiFenCollectionView.showsVerticalScrollIndicator = NO;
        _jiFenCollectionView.delegate = self;
        _jiFenCollectionView.dataSource = self;
        [_jiFenCollectionView registerClass:[JiFenColletionCell class] forCellWithReuseIdentifier:@"JiFenColletionCell"];
        [_jiFenCollectionView setBackgroundColor:[UIColor whiteColor]];
        WEAK
        [YBLMethodTools headerRefreshWithTableView:_jiFenCollectionView completion:^{
            STRONG
           self->page=1;
            if(btnclick==1)
            {
                [self.viewModel.mainArr removeAllObjects];
                [[self.viewModel mainDataSignalSortType:@"ASC" pageNum:1] subscribeNext:^(id  _Nullable x) {
                    STRONG
                    [self.jiFenCollectionView.mj_header endRefreshing];
                    [self.jiFenCollectionView reloadData];
                }];
            }
            else if(btnclick==2)
            {
                [self.viewModel.mainArr removeAllObjects];
                [[self.viewModel mainDataSignalSortType:@"DESC" pageNum:1] subscribeNext:^(id  _Nullable x) {
                    STRONG
                    [self.jiFenCollectionView.mj_header endRefreshing];

                    [self.jiFenCollectionView reloadData];
                }];
            }
            else
            {
            [self.viewModel.mainArr removeAllObjects];
            [self requestDataWithPage:self->page];
            }
        }];
       
    }
    return _jiFenCollectionView;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel.cell_data_dict[@"jifen"]count];
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JiFenModel *deModel = self.viewModel.cell_data_dict[@"jifen"][indexPath.item];
    JiFenColletionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JiFenColletionCell" forIndexPath:indexPath];
    cell.models = deModel;
    if (indexPath.item==[self.viewModel.cell_data_dict[@"jifen"]count]-2||indexPath.item==[self.viewModel.cell_data_dict[@"jifen"]count]-1) {
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
    JiFenModel *deModel = self.viewModel.cell_data_dict[@"jifen"][indexPath.item];
    WCLJiFenDetailViewController *jvc = [[WCLJiFenDetailViewController alloc]init];
    jvc.jifenID = deModel.pointsRewardId;
    [self.jiFenVC.navigationController pushViewController:jvc animated:YES];
   
}
@end
