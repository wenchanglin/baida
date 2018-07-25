//
//  WCLHomeUIService.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLHomeUIService.h"
#import "WCLHomeViewController.h"
#import "WCLHomeViewModel.h"
#import "WCLHomeBannerModel.h"
#import "WCLHomeFuncCell.h"
#import "WCLFindViewController.h"
#import "WCLHomeCouPonModel.h"
#import "WCLHomeCouPonCell.h"
#import "WCLHomeGiftCell.h"
#import "WCLHomeActivityModel.h"
#import "WCLHomeActivityCell.h"
#import "WCLHomeFuncModel.h"
#import "WCLFindShopVC.h"
#import "WCLMemberCodeVC.h"
#import <CoreLocation/CoreLocation.h>
#import "WCLShopSwitchViewController.h"
#import "WCLMainScanViewController.h"
#import "WCLJiFenViewController.h"
#import "WCLJiFenDetailViewController.h"
#import "WCLCouPonDetailVC.h"
#import "WCLCouPonViewController.h"
#import "WCLWebViewController.h"
#import "WCLHomeTopicModel.h"
#import "WCLBroadModel.h"
#import "WCLHomeTopicCell.h"
#import "WCLFuJiaFuncCell.h"
#import "WCLRegisetProtocolVC.h"
#import <CommonCrypto/CommonDigest.h>
#import "WCLMineActivityViewController.h"
#import "WCLSureSignUpVC.h"
#import "WCLIndoorNavigationVC.h"
#import "WCLShopSwitchModel.h"
#import "WCLStopCarViewController.h"
#import "WCLActivityH5VC.h"
#import "WCLHomeActvityCell.h"
#import "WCLHomeGameCell.h"
#import "WCLBannerActivityVC.h"
#import "WCLHomeMiaoShaCell.h"
#import "WCLTuanGouVC.h"
#import "WCLMiaoShaVC.h"
@interface WCLHomeUIService()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,HomeFuncDelegate,CLLocationManagerDelegate,HomeFuJiaFuncDelegate>
@property (nonatomic, weak) WCLHomeViewController *homeVC;
@property (nonatomic, assign) BOOL isAgree;
@property (nonatomic, weak) WCLHomeViewModel *viewModel;
@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//城市
@property (nonatomic,copy)    NSString *strLatitude;//经度
@property (nonatomic,copy)    NSString *strLongitude;//维度
@property(nonatomic,strong) YBLButton *backBtn;
@property(nonatomic,strong) NSString * string1;
@property(nonatomic,strong)NSString* bannerstate;
@property(nonatomic,strong)NSMutableArray*activityList;
@property(nonatomic,strong)NSMutableArray*gameList;
@property(nonatomic,assign)NSInteger cishu;
@end

@implementation WCLHomeUIService
{
    NSMutableArray *banerImgArray;
    NSString * biaoTiStr;
    NSMutableArray * gundongTitle;
    
}
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _homeVC = (WCLHomeViewController*)VC;
        gundongTitle = [NSMutableArray array];
        _viewModel = (WCLHomeViewModel*)viewModel;
        [_homeVC.view addSubview:self.homeTableView];
        _activityList = [NSMutableArray array];
        _gameList = [NSMutableArray array];
        self.cishu=0;
        _homeVC.view.backgroundColor = [UIColor whiteColor];
        [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"replyhash" object:nil]subscribeNext:^(NSNotification * _Nullable x) {
//            [self.viewModel.cell_data_dict removeAllObjects];
            [self requestHash];
        }];
        [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"baoming" object:nil]subscribeNext:^(NSNotification * _Nullable x) {
            [self.viewModel.cell_data_dict removeAllObjects];
            [self requestHomeData];
        }];
        
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [NSString new];
        [_locationManager requestWhenInUseAuthorization];
        //设置寻址精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
        if ([[[UIDevice currentDevice] systemVersion] floatValue]  >= 8.0) {
            [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
            //        获得授权认证
            [_locationManager requestAlwaysAuthorization];
        }
        
        [self leftandrightUI];
        [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"youhuiquanlistsucess" object:nil]subscribeNext:^(NSNotification * _Nullable x) {
            [self.viewModel.cell_data_dict removeAllObjects];
            [self requestHomeData];
        }];
        [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"changeCity" object:nil]throttle:1]subscribeNext:^(NSNotification * _Nullable x) {
            WCLShopSwitchListModel * model = (WCLShopSwitchListModel*)[x.userInfo objectForKey:@"key"];
            //                WCLLog(@"%@",@(model.organizeId));
            [self.backBtn setTitle:model.organizeName forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults]setObject:@(model.organizeId) forKey:@"organizeId"];
            [self.viewModel.cell_data_dict removeAllObjects];
            [self requestHomeData];
            
        }];
        
    }
    return self;
}
-(void)leftandrightUI
{
    _backBtn = [[YBLButton alloc] initWithFrame:CGRectMake(0, 20, 200, 44)];
    WEAK
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        WCLShopSwitchViewController * switchshop = [[WCLShopSwitchViewController alloc]init];
        switchshop.hidesBottomBarWhenPushed=YES;
        [self.homeVC.navigationController pushViewController:switchshop animated:YES];
    }];
    _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    [_backBtn setTitle:@"百大悦城" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [_backBtn setTitleColor:[UIColor colorWithHexString:@"#990000"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"home_icon_location"] forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    self.homeVC.navigationItem.leftBarButtonItem = barItem;
#pragma mark - 暂时不用
        UIButton * rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            STRONG
            if ([YBLMethodTools checkLoginWithVc:self.homeVC]) {
                WCLMainScanViewController * switchshop = [[WCLMainScanViewController alloc]init];
                switchshop.hidesBottomBarWhenPushed = YES;
                [self.homeVC.navigationController pushViewController:switchshop animated:YES];
            }
        }];
        [rightBtn setImage:[UIImage imageNamed:@"JDMainPage_icon_scan"] forState:UIControlStateNormal];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.homeVC.navigationItem.rightBarButtonItem = rightItem;
}
- (void)requestHomeData{
    WEAK;
    [self.viewModel.mainDataSignal subscribeNext:^(id  _Nullable x) {
        STRONG;
        if(self.homeTableView.mj_header.isRefreshing)
        {
            [self.homeTableView.mj_header endRefreshing];
        }
        [self->gundongTitle removeAllObjects];
        for(WCLBroadModel* model in [self.viewModel.cell_data_dict arrayForKey:@"BROAD"])
        {
            [self->gundongTitle addObject:model.content];
        }
        [self.activityList removeAllObjects];
        [self.gameList removeAllObjects];
        for (WCLHomeTopicModel*model2 in [self.viewModel.cell_data_dict arrayForKey:@"TOPIC"]) {
            self.activityList = model2.activityList.mutableCopy;
            self.gameList = model2.gameList.mutableCopy;
        }
//        WCLLog(@"%@",[self.viewModel.cell_data_dict  arrayForKey:@"SECKILL"]);

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
        [_homeTableView registerClass:[WCLHomeFuncCell class] forCellReuseIdentifier:@"funcCell"];
        [_homeTableView registerClass:[WCLHomeCouPonCell class] forCellReuseIdentifier:@"WCLHomeCouPonCell"];
        [_homeTableView registerClass:[WCLHomeGiftCell class] forCellReuseIdentifier:@"GiftCell"];
        [_homeTableView registerClass:[WCLHomeTopicCell class] forCellReuseIdentifier:@"WCLHomeTopicCell"];
        [_homeTableView registerClass:[WCLFuJiaFuncCell class] forCellReuseIdentifier:@"WCLFuJiaFuncCell"];
        [_homeTableView registerClass:[WCLHomeActvityCell class] forCellReuseIdentifier:@"WCLHomeActvityCell"];
        [_homeTableView registerClass:[WCLHomeGameCell class] forCellReuseIdentifier:@"WCLHomeGameCell"];
        [_homeTableView registerClass:[WCLHomeMiaoShaCell class] forCellReuseIdentifier:@"WCLHomeMiaoShaCell"];
        [_homeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_homeTableView setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED"]];
        WEAK
        [YBLMethodTools headerRefreshWithTableView:_homeTableView completion:^{
            STRONG
            [self.viewModel.cell_data_dict removeAllObjects];
            [self requestHomeData];
        }];
    }
    return _homeTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if(section==1||section==2||section==3||section==4)
    {
        return 1;
    }
    else if (section==5)
    {
        return 1;//[self.viewModel.cell_data_dict[@"SECKILL"]count];
    }
    else if(section==6)
    {
        return [self.viewModel.cell_data_dict[@"COUPON"] count];
    }
    else if(section==7)
    {
        return 1;//[self.viewModel.cell_data_dict[@"GIFT"] count];
    }
    else//第8行
        return [self.viewModel.cell_data_dict[@"ACTIVITY"]count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([[self.viewModel.cell_data_dict arrayForKey:@"MAIN"]count]>0) {
            return SCREEN_WIDTH/4;
        }
        return 0;
    }
    else if (indexPath.section==1)
    {
        if ([self.viewModel.cell_data_dict arrayForKey:@"EXTRA"].count>0) {
            return 50;
        }
        return  0;
    }
    else if(indexPath.section==2)
    {
        if ([self.viewModel.cell_data_dict arrayForKey:@"TOPIC"].count>0) {
            WCLHomeTopicModel* model = [self.viewModel.cell_data_dict arrayForKey:@"TOPIC"][indexPath.row];
            if (gundongTitle.count>0) {
                if (model.topicPic.length>0) {
                    return (SCREEN_WIDTH*6/25)+62;
                }
                else
                {
                    return SCREEN_WIDTH*6/25;
                }
            }
            else
            {
                if (model.topicPic.length>0) {
                    return (SCREEN_WIDTH*6/25);
                }
                else
                {
                return 0;
                }
            }
            
        }
        return 0;
    }
    else if (indexPath.section==3)
    {
        if (self.activityList.count>0) {
            return 90;
        }
        return 0;
    }
    else if (indexPath.section==4)
    {
        if (self.gameList.count>0) {
            return 90;
        }
        return 0;
    }
    else if (indexPath.section==5)
    {
        return 170;
    }
    else if(indexPath.section==6)
    {
        if([self.viewModel.cell_data_dict[@"COUPON"] count]>0)
        {
            return 115;
        }
        return 0;
    }
    else if (indexPath.section==7)
    {
        if ([self.viewModel.cell_data_dict arrayForKey:@"GIFT"].count>0) {
            NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"GIFT"];
            return array1.count==0?0:(array1.count<=2?240:(array1.count<=4 ? 2*240 : 3*240));
        }
        return 0;
    }
    else if(indexPath.section==8)//
    {
        if ([self.viewModel.cell_data_dict[@"ACTIVITY"]count]>0) {
            return 301;
        }
        return 0.001;
    }
    else
        return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==8) {
        return 65;
    }
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        banerImgArray = [NSMutableArray arrayWithArray:[self.viewModel.cell_data_dict arrayForKey:@"BANNER"]];
        if (banerImgArray.count>0) {
            return 187.5;
        }
        
    }
    else if (section==6)
    {
        
        return 65;
       
    }
    else if(section==7)
    {
        return 65;

    }
    else if(section==8)
    {
        return 65;

    }
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==8) {
        if ([self.viewModel.cell_data_dict[@"ACTIVITY"]count]>0) {
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
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        SDCycleScrollView * cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 187.5) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        cycle.currentPageDotImage =[UIImage createImageWithColor:[UIColor redColor] frame:CGRectMake(0, 0, 15, 2)];
        cycle.pageDotImage = [UIImage createImageWithColor:[UIColor whiteColor] frame:CGRectMake(0, 0, 15, 2)];
        
        NSMutableArray * array1 = [NSMutableArray array];
        for (WCLHomeBannerModel * model in banerImgArray) {
            [array1 addObject:model.advertPic];
        }
        cycle.imageURLStringsGroup = array1;
        return cycle;
    }
    else if (section==3||section==4)
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        return view;
    }
    else if (section==6)
    {
        
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
            view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
            UIButton * couponLabel = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 25, 100, 30)];
//            couponLabel.centerX = self.homeVC.view.centerX;
            couponLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            couponLabel.tag = 220+section;
            [couponLabel setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
            [couponLabel setTitle:@"优惠券" forState:UIControlStateNormal];
            [couponLabel setTitleColor:[UIColor colorWithHexString:@"#101010"] forState:UIControlStateNormal];
            [couponLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -couponLabel.imageView.bounds.size.width-30, 0, couponLabel.imageView.bounds.size.width)];
            [couponLabel setImageEdgeInsets:UIEdgeInsetsMake(0, couponLabel.titleLabel.bounds.size.width, 0, -couponLabel.titleLabel.bounds.size.width)];
            [[couponLabel rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
                WCLCouPonViewController * cvc = [[WCLCouPonViewController alloc]init];
                cvc.hidesBottomBarWhenPushed=YES;
                [self.homeVC.navigationController pushViewController:cvc animated:YES];
            }];
            couponLabel.titleLabel.font = [UIFont boldSystemFontOfSize:22];
            [view addSubview:couponLabel];
            return view;
       
    }
    else if (section==7)
    {
      
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
            view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
            UIButton * couponLabel = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-120)/2, 20, 120, 30)];
            couponLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            couponLabel.centerX = self.homeVC.view.centerX;
            couponLabel.tag = 220+section;
            [couponLabel setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
            [couponLabel setTitle:@"积分兑礼" forState:UIControlStateNormal];
            [couponLabel setTitleColor:[UIColor colorWithHexString:@"#101010"] forState:UIControlStateNormal];
            [couponLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -couponLabel.imageView.bounds.size.width-30, 0, couponLabel.imageView.bounds.size.width)];
            [couponLabel setImageEdgeInsets:UIEdgeInsetsMake(0, couponLabel.titleLabel.bounds.size.width, 0, -couponLabel.titleLabel.bounds.size.width)];
            [[couponLabel rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
                WCLJiFenViewController * jfVC = [[WCLJiFenViewController alloc]init];
                jfVC.hidesBottomBarWhenPushed=YES;
                [self.homeVC.navigationController pushViewController:jfVC animated:YES];
            }];
            couponLabel.titleLabel.font = [UIFont boldSystemFontOfSize:22];
            [view addSubview:couponLabel];
            return view;
       
    }
    else if (section==8)
    {
       
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
            view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
            UIButton * couponLabel = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-120)/2, 25, 120, 30)];
//            couponLabel.centerX = self.homeVC.view.centerX;
            couponLabel.tag = 220+section;
            [couponLabel setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
            [couponLabel setTitle:@"精彩活动" forState:UIControlStateNormal];
            couponLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [couponLabel setTitleColor:[UIColor colorWithHexString:@"#101010"] forState:UIControlStateNormal];
            [couponLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -couponLabel.imageView.bounds.size.width-30, 0, couponLabel.imageView.bounds.size.width)];
            [couponLabel setImageEdgeInsets:UIEdgeInsetsMake(0, couponLabel.titleLabel.bounds.size.width, 0, -couponLabel.titleLabel.bounds.size.width)];
            [[couponLabel rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"clickHomeActivity" object:nil ];
                self.homeVC.tabBarController.selectedIndex =1;
                
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
    NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString * organizeId =[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
    NSArray * array = [self.viewModel.cell_data_dict arrayForKey:@"MAIN"];
    if (section==0) {
        NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array];
        WCLHomeFuncCell *cell = [tableView dequeueReusableCellWithIdentifier:@"funcCell"];
        cell.funcArr = tuijianArr;
        cell.delegate = self;
        reCell = cell;
    }
    else if (section==1)
    {
        NSArray * array = [self.viewModel.cell_data_dict arrayForKey:@"EXTRA"];
        
        WCLFuJiaFuncCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLFuJiaFuncCell"];
        cell.funcArr = array.mutableCopy;
        cell.delegate =self;
        reCell =cell;
    }
    else if (section==2)
    {
        if ([self.viewModel.cell_data_dict arrayForKey:@"TOPIC"].count>0) {
            WCLHomeTopicModel* model = [self.viewModel.cell_data_dict arrayForKey:@"TOPIC"][indexPath.row];
            WCLHomeTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLHomeTopicCell"];
            if (gundongTitle.count>0) {
                cell.expressNewsViews.hidden=NO;
                cell.rolTitles = gundongTitle;
                cell.backImageView.hidden=model.topicPic.length>0?NO:YES;
            }
            else
            {
            if (model.topicPic.length>0) {
                [cell.backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.height.mas_equalTo(SCREEN_WIDTH*6/25);
                    make.left.right.equalTo(cell.contentView);
                }];
                cell.backImageView.hidden=NO;
            }
            }
            [cell setExpressNewsCellScrollClickBlock:^(NSInteger index) {
//                WCLBroadModel* model = [self.viewModel.cell_data_dict arrayForKey:@"BROAD"][index];
//                WCLLog(@"%@",@(model.ID));

            }];
            [[SDImageCache sharedImageCache]removeImageForKey:model.topicPic withCompletion:nil];
            [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:model.topicPic] placeholderImage:[UIImage imageNamed:@"icon_big_placeholder"]];
            cell.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
            reCell = cell;
        }
        else
        {
            WCLHomeTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLHomeTopicCell"];
            cell.expressNewsViews.hidden=YES;
            cell.backImageView.hidden=YES;
            cell.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
            reCell = cell;
        }
    }
    else if (section==3)
    {
        WCLHomeActvityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLHomeActvityCell"];
        cell.activityList = self.activityList;
        [cell setActivitySelct:^(activityListModel*model,NSInteger tag) {
            if([YBLMethodTools checkLoginWithVc:self.homeVC])
            {
                if ([model.memberSignupState isEqualToString:@"去参加"]||[model.memberSignupState isEqualToString:@"已报名"]||[model.memberSignupState isEqualToString:@"已结束"]||[model.memberSignupState isEqualToString:@"待报名"]||[model.memberSignupState isEqualToString:@"已失效"]) {
                    WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
                    pivc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.activityId),hash,organizeId];
                    pivc.navTitle = model.name;
                    pivc.hidesBottomBarWhenPushed =YES;
                    [self.homeVC.navigationController pushViewController:pivc animated:YES];
                }
                else if ([model.memberSignupState isEqualToString:@"去报名"])
                {
                    if ([YBLMethodTools checkLoginWithVc:self.homeVC]) {
                        for (WCLHomeActivityModel* modelsaf in  [self.viewModel.cell_data_dict arrayForKey:@"ACTIVITY"]) {
                            if ([modelsaf.activityName isEqualToString:model.name]) {
                                id x=modelsaf.acivityType;
                                if ([x isEqualToString:@"NONEED"]) {
                                    self.string1 = @"无需报名";
                                }
                                else if ([x isEqualToString:@"FREE"])
                                {
                                    self.string1 = @"免费";
                                }
                                else if ([x isEqualToString:@"SCORE"])
                                {
                                    self.string1 =[NSString stringWithFormat:@"%@积分报名",modelsaf.needScore.length>0?modelsaf.needScore:@"0"];
                                }
                                else if ([x isEqualToString:@"CASH"])
                                {
                                    self.string1 = [NSString stringWithFormat:@"¥%@报名",modelsaf.accessValue];
                                }
                            }
                        }
                        [YBLMethodTools pushWebVcFrom:self.homeVC URL:[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.activityId),hash,organizeId] title:model.name string:self.string1 type:@"活动详情" buystate:model.memberSignupState activityid:@(model.activityId)];
                    }
                }
                
            }
        }];
        reCell =  cell;
    }
    else if (section==4)
    {
        WCLHomeGameCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLHomeGameCell"];
        cell.gameList = self.gameList;
        [cell setGameselect:^(gameListModel *model) {
            if([YBLMethodTools checkLoginWithVc:self.homeVC])
            {
            NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
            WCLRegisetProtocolVC * pvc = [[WCLRegisetProtocolVC alloc]init];
            pvc.navTitle = model.name;
            NSString *gameid = [[model.url componentsSeparatedByString:@"/"]lastObject];
            NSString * string1 = [NSString stringWithFormat:@"%@%@%@,%@%@",@(model.appId),gameid,hash,organizeId,model.privateToken];
//            WCLLog(@"%@",string1);
            pvc.url = [NSString stringWithFormat:@"%@?appid=%@&uid=%@,%@&token=%@",model.url,@(model.appId),hash,organizeId,[self md5:string1]];
            pvc.hidesBottomBarWhenPushed =YES;
            [self.homeVC.navigationController pushViewController:pvc animated:YES];
            }
        }];
        reCell = cell;
    }else if(section==5)
    {
            WCLHomeMiaoShaCell* cell = [tableView dequeueReusableCellWithIdentifier:@"WCLHomeMiaoShaCell" forIndexPath:indexPath];
            [cell update:self.viewModel.cell_data_dict[@"SECKILL"] withGroup:self.viewModel.cell_data_dict[@"GROUPON"]];
            [cell setMiaoShaBlock:^(NSInteger index) {
                WCLMiaoShaVC *mvc = [[WCLMiaoShaVC alloc]init];
                mvc.hidesBottomBarWhenPushed=YES;
                [self.homeVC.navigationController pushViewController:mvc animated:YES];
            }];
            [cell setTuanGouBlock:^(NSInteger index) {
                WCLTuanGouVC *tvc = [[WCLTuanGouVC alloc]init];
                tvc.hidesBottomBarWhenPushed=YES;
                [self.homeVC.navigationController pushViewController:tvc animated:YES];
            }];
            reCell=cell;
        
    }
    else if(section==6)
    {
        if ([self.viewModel.cell_data_dict arrayForKey:@"COUPON"].count>0) {
            
            WCLHomeCouPonModel* model = [self.viewModel.cell_data_dict arrayForKey:@"COUPON"][indexPath.row];
            WCLHomeCouPonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WCLHomeCouPonCell"];
            cell.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
            cell.models = model;
            cell.receiveBtn.selected = self.isAgree;
            [cell setFanliBlock:^(WCLHomeCouPonModel *model, NSString *jifen) {
                if ([YBLMethodTools checkLoginWithVc:self.homeVC]) {
                    [[self.viewModel siganlForexchangeByPointsWithCouponId:model.objectId withcyCouponId:model.couponTypeCy withExchangeValue:jifen]subscribeNext:^(id  _Nullable x) {
                        if ([x isKindOfClass:[NSDictionary class]]) {
                            model.balanceNum = [[x stringForKey:@"shengyu"] integerValue];
                            model.memberBroughtNum +=1;
                            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
                            [self.homeTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        }
                    }];
                }
            }];
            WEAK
            [cell setFreeBlock:^(WCLHomeCouPonModel *model) {
                STRONG
                if([YBLMethodTools checkLoginWithVc:self.homeVC])
                {
                    [[self.viewModel siganlForexchangeByPointsWithCouponId:model.objectId  withcyCouponId:model.couponTypeCy withExchangeValue:@"0"]subscribeNext:^(id x) {
                        if ([x isKindOfClass:[NSDictionary class]]) {
                            model.balanceNum = [[x stringForKey:@"shengyu"] integerValue];
                            model.memberBroughtNum +=1;
                            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
                            [self.homeTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        }
                    }];
                }
            }];
            [cell setPointsBlock:^(WCLHomeCouPonModel *model) {
                STRONG
                if([YBLMethodTools checkLoginWithVc:self.homeVC])
                {
                    [[self.viewModel siganlForexchangeByPointsWithCouponId:model.objectId  withcyCouponId:model.couponTypeCy withExchangeValue:[NSString stringWithFormat:@"%@",@(model.accessValue)]]subscribeNext:^(id  x) {
                        if ([x isKindOfClass:[NSDictionary class]]) {
                            model.balanceNum = [[x stringForKey:@"shengyu"] integerValue];
                            model.memberBroughtNum +=1;
                            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
                            [self.homeTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        }
                    }];
                }
            }];
            reCell= cell;
        }
        else
        {
            WCLHomeCouPonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WCLHomeCouPonCell"];
            reCell=cell;
        }
        
    }
    else if (section==7)
    {
        NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"GIFT"];
        NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array1];
        WCLHomeGiftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GiftCell"];
        cell.giftArr =tuijianArr;
        WEAK
        [cell setGiftSelectBlock:^(NSInteger index) {
            STRONG
            WCLJiFenDetailViewController *jvc = [[WCLJiFenDetailViewController alloc]init];
            jvc.jifenID = index;
            jvc.hidesBottomBarWhenPushed=YES;
            [self.homeVC.navigationController pushViewController:jvc animated:YES];
        }];
        reCell = cell;
    }
    else if(section==8)
    {
        NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
        NSString * organizeId =[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
        NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"ACTIVITY"];
        if (array1.count>0) {
            
            NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array1];
            WCLHomeActivityModel * models = tuijianArr[row];
            WCLHomeActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"activitycells"];
            if (!cell) {
                cell = [[WCLHomeActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activitycells"];
            }
            cell.models = models;
            [cell setSignblocks:^(NSInteger activityId) {
                if ([YBLMethodTools checkLoginWithVc:self.homeVC]) {
                    [YBLMethodTools pushWebVcFrom:self.homeVC URL:[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.objectId),hash,organizeId] title:models.activityName string:self.string1 type:@"活动详情" buystate:models.memberSignupState activityid:@(models.objectId)];
                }
            }];
            [cell setBlocks:^(NSInteger activityId) {
                if ([YBLMethodTools checkLoginWithVc:self.homeVC]) {
                    WCLActivityH5VC *vc = [[WCLActivityH5VC alloc]init];
                    vc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.objectId),hash,organizeId];
                    vc.navTitle = models.activityName;
                    vc.activityid = models.objectId;
                    vc.buyStates =models.memberSignupState;
                    vc.hidesBottomBarWhenPushed=YES;
                    [self.homeVC.navigationController pushViewController:vc animated:YES];
                }
            }];
            reCell = cell;
        }
        else
        {
            WCLHomeActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"activitycells"];
            reCell=cell;
        }
    }
    reCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return reCell;
}
//MD5加密方式
- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==6) {
        WCLHomeCouPonModel* model = [self.viewModel.cell_data_dict arrayForKey:@"COUPON"][indexPath.row];
        WCLCouPonDetailVC * dvc = [[WCLCouPonDetailVC alloc]init];
        dvc.couponId = model.objectId;
        dvc.hidesBottomBarWhenPushed =YES;
        [self.homeVC.navigationController pushViewController:dvc animated:YES];
    }
    else if (indexPath.section==8)
    {
        WCLHomeActivityModel * models  = [self.viewModel.cell_data_dict arrayForKey:@"ACTIVITY"][indexPath.row];
        WEAK
        [RACObserve(models, acivityType)subscribeNext:^(id  _Nullable x) {
            //            WCLLog(@"%@",x);
            STRONG
            if ([x isEqualToString:@"NONEED"]) {
                self.string1 = @"无需报名";
            }
            else if ([x isEqualToString:@"FREE"])
            {
                self.string1 = @"免费";
            }
            else if ([x isEqualToString:@"SCORE"])
            {
                self.string1 =[NSString stringWithFormat:@"%@积分报名",models.needScore.length>0?models.needScore:@"0"];
            }
            else if ([x isEqualToString:@"CASH"])
            {
                self.string1 = [NSString stringWithFormat:@"%@报名",models.accessValue];
            }
        }];
        NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
        NSString * organizeId =[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
        
        if ([models.memberSignupState isEqualToString:@"已失效"]) {
            WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
            pivc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.objectId),hash,organizeId];
            pivc.navTitle = models.activityName;
            pivc.hidesBottomBarWhenPushed =YES;
            [self.homeVC.navigationController pushViewController:pivc animated:YES];
        }
        else if ([models.memberSignupState isEqualToString:@"去报名"])
        {
            if ([self.string1 isEqualToString:@"无需报名"]) {
                WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
                pivc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.objectId),hash,organizeId];
                pivc.navTitle = models.activityName;
                pivc.hidesBottomBarWhenPushed =YES;
                [self.homeVC.navigationController pushViewController:pivc animated:YES];
            }
            else
            {
                [YBLMethodTools pushWebVcFrom:self.homeVC URL:[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.objectId),hash,organizeId] title:models.activityName string:self.string1 type:@"活动详情" buystate:models.memberSignupState activityid:@(models.objectId)];
            }
            
        }
        else if ([models.memberSignupState isEqualToString:@"去参加"]||[models.memberSignupState isEqualToString:@"已结束"]||[models.memberSignupState isEqualToString:@"待报名"])
        {
            WCLActivityH5VC *vc = [[WCLActivityH5VC alloc]init];
            vc.url =[NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(models.objectId),hash,organizeId];
            vc.navTitle = models.activityName;
            vc.activityid = models.objectId;
            vc.buyStates =models.memberSignupState;
            vc.hidesBottomBarWhenPushed=YES;
            [self.homeVC.navigationController pushViewController:vc animated:YES];
        }
        
    }
}
-(void)homeFuJiaFuncWithIndex:(NSInteger)index
{
    //    WCLLog(@"%@",@(index));
}
-(void)homeFuncClick:(NSInteger)index
{
    NSArray * array = [self.viewModel.cell_data_dict arrayForKey:@"MAIN"];
    if(array.count>0)
    {
        WCLHomeFuncModel * model = array[index];
        if ([model.functionName isEqualToString:@"找店铺"]) {
            WCLFindShopVC * vc = [[WCLFindShopVC alloc]init];
            vc.hidesBottomBarWhenPushed =YES;
            [self.homeVC.navigationController pushViewController:vc animated:YES];
        }
        else if ([model.functionName isEqualToString:@"我要买"]) {
            
        }
        else if ([model.functionName isEqualToString:@"停车缴费"]) {
            WCLStopCarViewController *vc = [[WCLStopCarViewController alloc]init];
            vc.hidesBottomBarWhenPushed=YES;
            [self.homeVC.navigationController pushViewController:vc animated:YES];
        }
        else if ([model.functionName isEqualToString:@"室内导航"]) {
            WCLIndoorNavigationVC *nvc = [[WCLIndoorNavigationVC alloc]init];
            nvc.hidesBottomBarWhenPushed=YES;
            [self.homeVC.navigationController pushViewController:nvc animated:YES];
        }
        else if ([model.functionName isEqualToString:@"会员码"]) {
            if ([YBLMethodTools checkLoginWithVc:self.homeVC] ) {
                [[WCLLoginViewModel signalForGetUserInfo]subscribeNext:^(NSNumber* x) {
                    if (x.boolValue) {
                        WCLMemberCodeVC * cvc = [[WCLMemberCodeVC alloc]init];
                        cvc.hidesBottomBarWhenPushed =YES;
                        [self.homeVC.navigationController pushViewController:cvc animated:YES];
                    }
                }];
            }
            
        }
    }
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    WCLHomeBannerModel*model = banerImgArray[index];
    NSString * hash =[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString * organizeId =[[NSUserDefaults standardUserDefaults]objectForKey:@"organizeId"];
    if ([model.moduleCode isEqualToString:@"ACTIVITY"]) {//新品和活动
        WCLBannerActivityVC* pivc = [[WCLBannerActivityVC alloc]init];
        pivc.activityid = model.objectId;
        pivc.url = [NSString stringWithFormat:@"%@activity?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.objectId),hash,organizeId];
        pivc.hidesBottomBarWhenPushed =YES;
        [self.homeVC.navigationController pushViewController:pivc animated:YES];
    }
    else if([model.moduleCode isEqualToString:@"GIFT"])
    {
        WCLJiFenDetailViewController * jifen = [[WCLJiFenDetailViewController alloc]init];
        jifen.jifenID = model.objectId;
        jifen.hidesBottomBarWhenPushed=YES;
        [self.homeVC.navigationController pushViewController:jifen animated:YES];
    }
    else if ([model.moduleCode isEqualToString:@"COUPON"])
    {
        WCLCouPonDetailVC * dvc = [[WCLCouPonDetailVC alloc]init];
        dvc.couponId = model.objectId;
        dvc.hidesBottomBarWhenPushed=YES;
        [self.homeVC.navigationController pushViewController:dvc animated:YES];
    }
    else if ([model.moduleCode isEqualToString:@"FIRSTLOOK"])
    {
        WCLRegisetProtocolVC * pvc = [[WCLRegisetProtocolVC alloc]init];
        pvc.url = [NSString stringWithFormat:@"%@commodity/newDetail?id=%@&hash=%@&appType=ios&organizeId=%@",URL_H5,@(model.objectId),hash,organizeId];
        pvc.hidesBottomBarWhenPushed=YES;
//        pvc.present =YES;
        [self.homeVC.navigationController pushViewController:pvc animated:YES];
    }
    else if ([model.moduleCode isEqualToString:@"GROUP"])//优惠团购
    {
//        WCLLog(@"优惠团购");
        [SVProgressHUD showErrorWithStatus:@"优惠团购还没铺界面。"];
    }
    else
    {
        WCLRegisetProtocolVC * pivc = [[WCLRegisetProtocolVC alloc]init];
        pivc.url =model.advertUrl;
        pivc.navTitle = model.objectName;
        pivc.hidesBottomBarWhenPushed =YES;
        [self.homeVC.navigationController pushViewController:pivc animated:YES];
    }
}


#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    [self requestHash];
    
}
-(void)dingweiwith:(NSInteger)jingdu with:(NSInteger)weidu{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@(jingdu) forKey:@"lng"];
    [parameter setObject:@(weidu) forKey:@"lat"];
    AFHTTPSessionManager *managers =[AFHTTPSessionManager manager];
    managers = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:URL_Server_String]];
    managers.securityPolicy.allowInvalidCertificates = YES;
    managers.securityPolicy.validatesDomainName = NO;
    managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",                                                         @"image/jpeg",@"image/png",@"text/plain",@"application/json", nil];
    [managers.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    managers.requestSerializer.timeoutInterval = 8.f;
    [managers.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    managers.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults] ;
    if ([[userd stringForKey:@"hash"]length] > 0 ) {
        NSString * str1 = [userd stringForKey:@"hash"];
        [parameter setObject:str1 forKey:@"hash"];
    }
    if ([WCLUserManageCenter shareInstance].isLoginStatus) {
        
        [managers POST:@"appRequest/nearestMall.json" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //            WCLLog(@"%@",responseObject);
            if([responseObject[@"code"]integerValue]==500)
            {
                [SVProgressHUD showErrorWithStatus:@"定位失败"];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"organizeId"] forKey:@"organizeId"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self.viewModel.cell_data_dict removeAllObjects];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self requestHomeData];
                });
                [self.backBtn setTitle:responseObject[@"data"][@"organizeName"] forState:UIControlStateNormal];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //            WCLLog(@"%@",error);
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"获取附近商城失败"];
            }
        }];
    }
    else
    {
        [managers POST:@"appRequest/nearestMall.json" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            WCLLog(@"%@",responseObject);
            if([responseObject[@"code"]integerValue]==500)
            {
                [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"hash"] forKey:@"hash"];
                [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"organizeId"] forKey:@"organizeId"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self.viewModel.cell_data_dict removeAllObjects];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self requestHomeData];
                });
                [self.backBtn setTitle:responseObject[@"data"][@"organizeName"] forState:UIControlStateNormal];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            WCLLog(@"%@",error);
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"获取附近商城失败"];
            }
        }];
    }
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];

    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks[0];
            NSDictionary *dic = [placemark addressDictionary];
            NSLog(@"dic %@",dic);//根据你的需要选取所需要的地址
            
            //城市要注意
            
            NSString *city = placemark.locality;
            if (!city) {
                // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city :%@",city);
            [manager stopUpdatingLocation];
            self.cishu +=1;
        }
        else if (error == nil && [placemarks count] == 0)
        {
            NSLog(@"No results were returned.");
            [self requestHash];
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
            [self requestHash];
        }
        if (self.cishu==1) {
            [self dingweiwith:currentLocation.coordinate.longitude with:currentLocation.coordinate.latitude];
        }
        else if (self.cishu>1)
        {
//            WCLLog(@"%@",@(self.cishu));
        }
    }];
}
-(void)requestHash
{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    [[wclNetTool sharedTools]request:POST urlString:@"appRequest/nearestMall.json" parameters:parameter finished:^(id responseObject, NSError *error) {
        WCLLog(@"%@--%@",responseObject,error);
        if([responseObject[@"code"]integerValue]==500)
        {
            [SVProgressHUD showErrorWithStatus:@"定位失败"];
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"organizeId"] forKey:@"organizeId"];
            if ([WCLUserManageCenter shareInstance].isLoginStatus){
                
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"hash"] forKey:@"hash"];
            }
            [self.backBtn setTitle:responseObject[@"data"][@"organizeName"] forState:UIControlStateNormal];
            [self.viewModel.cell_data_dict removeAllObjects];
            [self requestHomeData];
        }
        
    }];
}

@end
