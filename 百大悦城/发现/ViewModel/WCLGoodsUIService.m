//
//  WCLGoodsUIService.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/18.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLGoodsUIService.h"
#import "WCLGoodsViewController.h"
#import "WCLGoodsViewModel.h"
#import "WCLSpecialCell.h"
#import "WCLNewGoodsCell.h"
#import "WCLGoodsDetailViewController.h"
#import "WCLShopSwitchModel.h"
@interface WCLGoodsUIService()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)WCLGoodsViewModel * viewModel;
@property(nonatomic,strong)WCLGoodsViewController * goodsVC;
@property(nonatomic,strong)NSString*string1;
@end
@implementation WCLGoodsUIService
{
    NSString * biaoTiStr;

}
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _viewModel = (WCLGoodsViewModel*)viewModel;
        _goodsVC = (WCLGoodsViewController*)VC;
        [_goodsVC.view addSubview:self.homeTableView];
        [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"changeCity" object:nil]throttle:1]subscribeNext:^(NSNotification * _Nullable x) {
            WCLShopSwitchListModel * model = (WCLShopSwitchListModel*)[x.userInfo objectForKey:@"key"];
            //                WCLLog(@"%@",@(model.organizeId));
            [[NSUserDefaults standardUserDefaults]setObject:@(model.organizeId) forKey:@"organizeId"];
            [self.viewModel.cell_data_dict removeAllObjects];
            [self.viewModel.goodsArr removeAllObjects];
            [self.viewModel.goodsNewArr removeAllObjects];
            [self requestData];
        }];
        [self requestData];
    }
    return self;
}
-(void)requestData
{
    WEAK
    [[self.viewModel goodsSpecialDataSignal]subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.homeTableView.mj_header endRefreshing];
        [self.homeTableView reloadData];
    }];
    [[self.viewModel goodsNewDataSignal]subscribeNext:^(id  _Nullable x) {
            STRONG
        [self.homeTableView.mj_header endRefreshing];
        [self.homeTableView reloadData];
    }];

    
   
}
-(UITableView *)homeTableView
{
    if (!_homeTableView) {
        
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-88-84:SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        self.homeTableView.estimatedSectionHeaderHeight = 0;
        self.homeTableView.estimatedSectionFooterHeight=0;
        [_homeTableView registerClass:[WCLSpecialCell class] forCellReuseIdentifier:@"WCLSpecialCell"];
        [_homeTableView registerClass:[WCLNewGoodsCell class] forCellReuseIdentifier:@"WCLNewGoodsCell"];
        [_homeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_homeTableView setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED"]];
        WEAK
        [YBLMethodTools headerRefreshWithTableView:_homeTableView completion:^{
            STRONG
            [self.viewModel.cell_data_dict removeAllObjects];
            [self.viewModel.goodsArr removeAllObjects];
            [self.viewModel.goodsNewArr removeAllObjects];
            [self requestData];
        }];
    }
    return _homeTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
    }
    else if(section==1)
    {
        return [self.viewModel.cell_data_dict[@"新品"]count];
    }
    else
        return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
        return 65;
    }
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        UILabel * couponLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 25, 200, 30)];
        couponLabel.textAlignment = NSTextAlignmentCenter;
        couponLabel.text = @"-我是有底线的-";
        couponLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        couponLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [view addSubview:couponLabel];
        return view;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0)
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        UIButton * couponLabel = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2+15, 25, 100, 30)];
        couponLabel.tag = 220+section;
        couponLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [couponLabel setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        [couponLabel setTitle:@"人气" forState:UIControlStateNormal];
        [couponLabel setTitleColor:[UIColor colorWithHexString:@"#101010"] forState:UIControlStateNormal];
        [couponLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -couponLabel.imageView.bounds.size.width-30, 0, couponLabel.imageView.bounds.size.width)];
        [couponLabel setImageEdgeInsets:UIEdgeInsetsMake(0, couponLabel.titleLabel.bounds.size.width, 0, -couponLabel.titleLabel.bounds.size.width)];
        [[couponLabel rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            WCLGoodsDetailViewController * dvc= [[WCLGoodsDetailViewController alloc]init];
            dvc.hidesBottomBarWhenPushed=YES;
            [self.goodsVC.navigationController pushViewController:dvc animated:YES];
        }];
        couponLabel.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        [view addSubview:couponLabel];
        return view;
    }
    else
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        UIButton * couponLabel = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2+15, 25, 100, 30)];
        couponLabel.tag = 220+section;
        couponLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [couponLabel setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        [couponLabel setTitle:@"新品" forState:UIControlStateNormal];
        [couponLabel setTitleColor:[UIColor colorWithHexString:@"#101010"] forState:UIControlStateNormal];
        [couponLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -couponLabel.imageView.bounds.size.width-30, 0, couponLabel.imageView.bounds.size.width)];
        [couponLabel setImageEdgeInsets:UIEdgeInsetsMake(0, couponLabel.titleLabel.bounds.size.width, 0, -couponLabel.titleLabel.bounds.size.width)];
        [[couponLabel rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//            WCLCouPonViewController * cvc = [[WCLCouPonViewController alloc]init];
//            cvc.hidesBottomBarWhenPushed=YES;
//            [self.homeVC.navigationController pushViewController:cvc animated:YES];
        }];
        couponLabel.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        [view addSubview:couponLabel];
        return view;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *reCell;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
   
     if (section==0)
    {
        NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"人气"];
        NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array1];
        WCLSpecialCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLSpecialCell"];
        cell.specArr =tuijianArr;
        WEAK
        [cell setSpecdidselect:^(WCLGoodsModel *model)
        {
            STRONG
            self.string1 = [NSString stringWithFormat:@"¥%@",model.nowPrice];
            NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
            
            [YBLMethodTools pushWebVcFrom:self.goodsVC URL:[NSString stringWithFormat:@"%@commodity/specialDetail?id=%@&hash=%@&appType=ios",URL_H5,@(model.commodityId),hash] title:model.commodityName string:self.string1 type:@"人气单品详情" buystate:@"" activityid:@""];
        }];
        reCell = cell;
    }
    else if(section==1)
    {
        NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"新品"];
        NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array1];
        WCLGoodsModel * models = tuijianArr[row];
        WCLNewGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLNewGoodsCell"];
        cell.models = models;
        reCell = cell;
        
    }
    reCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return reCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 480;
    }
    else if(indexPath.section==1)
    {
        return 130;
    }
    else
        return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString * organizeId =[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];

    WCLGoodsModel * model2 = [self.viewModel.cell_data_dict arrayForKey:@"新品"][indexPath.row];
    WCLRegisetProtocolVC * pvc = [[WCLRegisetProtocolVC alloc]init];
    pvc.url = [NSString stringWithFormat:@"%@commodity/newDetail?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model2.shopId),hash,organizeId];
    pvc.hidesBottomBarWhenPushed=YES;
    pvc.present =YES;
    WCLLog(@"%@",@(model2.shopId));
    [self.goodsVC presentViewController:pvc animated:NO completion:nil];
}
@end
