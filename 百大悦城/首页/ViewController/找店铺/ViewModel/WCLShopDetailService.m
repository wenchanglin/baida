
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
        [self createBottomView];
        [self requestActivityData];
    }
    return self;
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
        
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-88-84:SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        self.detailTableView.estimatedSectionHeaderHeight = 0;
        self.detailTableView.estimatedSectionFooterHeight=0;
        [_detailTableView registerClass:[WCLShopDetailOneCell class] forCellReuseIdentifier:@"WCLShopDetailOneCell"];
//        [_detailTableView registerClass:[WCLNewGoodsCell class] forCellReuseIdentifier:@"WCLNewGoodsCell"];
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
-(void)createBottomView
{
    UIView * bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#E0BE8D"];
    [self.shopdetailVC.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.shopdetailVC.view.mas_bottom).offset(IsiPhoneX?-15:0);
        make.left.right.equalTo(self.shopdetailVC.view);
        make.height.mas_equalTo(50);
    }];
    UILabel * priceLabel = [UILabel new];
    priceLabel.font =[UIFont boldSystemFontOfSize:22];
    priceLabel.text = @"9.5折";
    priceLabel.textColor = [UIColor whiteColor];
    [bottomView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    UIButton * buyBtn = [UIButton new];
    buyBtn.layer.cornerRadius=18;
    [buyBtn setTitle:@"买单" forState:UIControlStateNormal];
    buyBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
    buyBtn.layer.masksToBounds= YES;
    [[buyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        WCLLog(@"你点击了店铺详情的买单");
    }];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(120);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
    }
    else if(section==1)
    {
        if ([self.viewModel.cell_data_dict[@"youhuiquan"]count]>0) {
            return [self.viewModel.cell_data_dict[@"youhuiquan"]count];
        }
        else
            return 0;
    }
    else
    {
        if ([self.viewModel.cell_data_dict[@"xinpin"]count]>0) {
            return [self.viewModel.cell_data_dict[@"xinpin"]count];
        }
        else
        return 0;
    }
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
    if (section==0||section==1) {
        return 0.0001;
    }
    return 35;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==2) {
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
    
    if(section==2)
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        UILabel * couponLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 25, 200, 30)];
        couponLabel.textAlignment = NSTextAlignmentCenter;
        couponLabel.text = [NSString stringWithFormat:@"新品速递》"];
        couponLabel.font = [UIFont boldSystemFontOfSize:22];
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
        WCLShopSwitchListModel * model1 = self.viewModel.cell_data_dict[@"mall"][indexPath.row];
        WCLFindShopModel* model2 =self.viewModel.cell_data_dict[@"shop"][indexPath.row];
        WCLShopDetailOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLShopDetailOneCell"];
        [cell shopDetailMallModel:model1 withShopModel:model2];
        cell.yetaiLabel.text = self.shopdetailVC.industryName;
        reCell = cell;
    }
    else if(section==1)
    {
        UITableViewCell  *cell = [UITableViewCell new];
        reCell = cell;
       
    }
    else
    {
       
        NSArray * array1 = self.viewModel.cell_data_dict[@"xinpin"][indexPath.row];
        NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array1];
        if (tuijianArr.count>0) {
            WCLGoodsModel * models = tuijianArr[row];
            WCLNewGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLNewGoodsCell"];
            cell.models = models;
            reCell = cell;
        }
        else
        {
            UITableViewCell  *cell = [UITableViewCell new];
            cell.textLabel.text =@"1";
            reCell = cell;
        }
        
       
    }
    reCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return reCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WCLFindShopModel* model2 =self.viewModel.cell_data_dict[@"shop"][indexPath.row];
        CGRect titleBounds = [model2.shopIntro boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14]} context:nil];
        
        return 325+titleBounds.size.height;;
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
    WCLLog(@"%@",@(indexPath.row));
}
@end
