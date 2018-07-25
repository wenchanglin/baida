
//
//  WCLShopDetailService.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/24.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopDetailService.h"
#import "WCLShopDetailVC.h"
#import "WCLShopDetailViewModel.h"
#import "WCLShopSwitchListModel.h"
#import "WCLShopDetailOneCell.h"
#import "WCLNewGoodsCell.h"
#import "WCLGoodsModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface WCLShopDetailService()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)WCLShopDetailViewModel * viewModel;
@property(nonatomic,weak)WCLShopDetailVC * shopdetailVC;
@end
@implementation WCLShopDetailService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _viewModel = (WCLShopDetailViewModel*)viewModel;
        _shopdetailVC = (WCLShopDetailVC*)VC;
        [_shopdetailVC.view addSubview:self.detailTableView];
     //   [self createBottomView];
        [self requestActivityData];
        [self requestXinPinData];
    }
    return self;
}
-(void)requestXinPinData
{
    WEAK
    [[self.viewModel ShopDetailWithXinPinId:self.shopdetailVC.shopid]subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.detailTableView.mj_header endRefreshing];
        [self.detailTableView reloadData];
    }];
}
-(void)requestActivityData
{
    WEAK
    [[self.viewModel ShopDetailWithShopId:self.shopdetailVC.shopid]subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.detailTableView.mj_header endRefreshing];
        [self.detailTableView reloadData];
    }];
}
-(UITableView *)detailTableView
{
    if (!_detailTableView) {
        
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-88-20:SCREEN_HEIGHT-64-20) style:UITableViewStyleGrouped];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        self.detailTableView.estimatedSectionHeaderHeight = 0;
        self.detailTableView.estimatedSectionFooterHeight=0;
        [_detailTableView registerClass:[WCLShopDetailOneCell class] forCellReuseIdentifier:@"WCLShopDetailOneCell"];
        [_detailTableView registerClass:[WCLNewGoodsCell class] forCellReuseIdentifier:@"WCLNewGoodsCell"];
//        [_homeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        [_homeTableView setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED"]];
        WEAK
        //        [YBLMethodTools footerAutoRefreshWithTableView:_homeTableView completion:^{
        //            STRONG
        //            [self loadCommandMore];
        //        }];
        [YBLMethodTools headerRefreshWithTableView:_detailTableView completion:^{
            STRONG
            [self requestActivityData];
        }];
    }
    return _detailTableView;
}
//-(void)createBottomView
//{
//    UIView * bottomView = [UIView new];
//    bottomView.backgroundColor = [UIColor colorWithHexString:@"#E0BE8D"];
//    [self.shopdetailVC.view addSubview:bottomView];
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.shopdetailVC.view.mas_bottom).offset(IsiPhoneX?-15:0);
//        make.left.right.equalTo(self.shopdetailVC.view);
//        make.height.mas_equalTo(50);
//    }];
//    UILabel * priceLabel = [UILabel new];
//    priceLabel.font =[UIFont boldSystemFontOfSize:22];
//    priceLabel.text = @"9.5折";
//    priceLabel.textColor = [UIColor whiteColor];
//    [bottomView addSubview:priceLabel];
//    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20);
//        make.centerY.equalTo(bottomView.mas_centerY);
//    }];
//    UIButton * buyBtn = [UIButton new];
//    buyBtn.layer.cornerRadius=18;
//    [buyBtn setTitle:@"买单" forState:UIControlStateNormal];
//    buyBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
//    buyBtn.layer.masksToBounds= YES;
//    [[buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//        WCLLog(@"你点击了店铺详情的买单");
//    }];
//    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [bottomView addSubview:buyBtn];
//    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-20);
//        make.width.mas_equalTo(120);
//        make.centerY.equalTo(bottomView.mas_centerY);
//    }];
//}
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
    else if(section==1){
        if ([self.viewModel.cell_data_dict[@"xinpin"]count]>0) {
            return [self.viewModel.cell_data_dict[@"xinpin"]count];
        }
        else
            return 0;
    }
    else
        return 0;
    
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
    if (section==0) {
        return 0.0001;
    }
    else if(section==1)
    {
    return 65;
    }
    return 35;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        UILabel * couponLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 25, 200, 30)];
        couponLabel.textAlignment = NSTextAlignmentCenter;
//        couponLabel.text = @"-我是有底线的-";
        couponLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        couponLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [view addSubview:couponLabel];
        return view;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(section==1)
    {
        if([self.viewModel.cell_data_dict[@"xinpin"]count]>0)
        {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        UIButton * couponLabel = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 25, 200, 30)];
        couponLabel.tag = 220+section;
        [couponLabel setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        [couponLabel setTitle:@"新品速递" forState:UIControlStateNormal];
        [couponLabel setTitleColor:[UIColor colorWithHexString:@"#101010"] forState:UIControlStateNormal];
        [couponLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -couponLabel.imageView.bounds.size.width-30, 0, couponLabel.imageView.bounds.size.width)];
        [couponLabel setImageEdgeInsets:UIEdgeInsetsMake(0, couponLabel.titleLabel.bounds.size.width, 0, -couponLabel.titleLabel.bounds.size.width)];
        couponLabel.titleLabel.font = [UIFont boldSystemFontOfSize:22];

        [view addSubview:couponLabel];
        return view;
        }
        return nil;
    }
    return nil;
}
- (void)configureCell:(WCLShopDetailOneCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    WCLShopSwitchListModel * model1 = self.viewModel.cell_data_dict[@"mall"][indexPath.row];
    WCLFindShopModel* model2 =self.viewModel.cell_data_dict[@"shop"][indexPath.row];
    [cell shopDetailMallModel:model1 withShopModel:model2];
    if (model2.berthNo.length>0) {
        cell.addressLabel.text = [NSString stringWithFormat:@"%@  %@-%@",model1.organizeName,self.shopdetailVC.floorName,model2.berthNo];
    }
    else
    {
        cell.addressLabel.text = [NSString stringWithFormat:@"%@  %@",model1.organizeName,self.shopdetailVC.floorName];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *reCell;
    if (indexPath.section==0)
    {
        WCLShopDetailOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLShopDetailOneCell"];
        [self configureCell:cell atIndexPath:indexPath];
        cell.yetaiLabel.text = self.shopdetailVC.yetaiStr;
        reCell = cell;
    }
    
    else if(indexPath.section==1)
    {
       
        WCLGoodsModel * models  = self.viewModel.cell_data_dict[@"xinpin"][indexPath.row];
        if (models) {
            WCLNewGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLNewGoodsCell"];
            cell.models = models;
            reCell = cell;
        }
        
       
    }
    reCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return reCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
      return [self.detailTableView fd_heightForCellWithIdentifier:@"WCLShopDetailOneCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
//        WCLFindShopModel* model2 =self.viewModel.cell_data_dict[@"shop"][indexPath.row];
//        CGRect titleBounds = [model2.shopIntro boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14]} context:nil];
//
//        return 325+titleBounds.size.height;;
    }
    else if(indexPath.section==1)
    {
        return 100;
    }
    else
        return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WCLLog(@"%@",@(indexPath.section));
    if(indexPath.section==1)
    {
        NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
        NSString * organizeId =[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
        WCLGoodsModel * model2  = self.viewModel.cell_data_dict[@"xinpin"][indexPath.row];
        WCLRegisetProtocolVC * pvc = [[WCLRegisetProtocolVC alloc]init];
        pvc.url = [NSString stringWithFormat:@"%@commodity/newDetail?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model2.shopId),hash,organizeId];
        pvc.hidesBottomBarWhenPushed=YES;
        pvc.present =YES;
//        WCLLog(@"%@",@(model2.shopId));
        [self.shopdetailVC presentViewController:pvc animated:NO completion:nil];
    }
}
@end
