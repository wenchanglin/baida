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
@interface WCLHomeUIService()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,HomeFuncDelegate,CLLocationManagerDelegate>
@property (nonatomic, weak) WCLHomeViewController *homeVC;
@property (nonatomic, assign) BOOL isAgree;
@property (nonatomic, weak) WCLHomeViewModel *viewModel;
@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//城市
@property (nonatomic,copy)    NSString *strLatitude;//经度
@property (nonatomic,copy)    NSString *strLongitude;//维度
@property(nonatomic,strong) YBLButton *backBtn;

@end

@implementation WCLHomeUIService
{
    NSMutableArray *banerImgArray;
    NSString * biaoTiStr;
    
}
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _homeVC = (WCLHomeViewController*)VC;
        _viewModel = (WCLHomeViewModel*)viewModel;
        [_homeVC.view addSubview:self.homeTableView];
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [NSString new];
        [_locationManager requestWhenInUseAuthorization];
        //设置寻址精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
        [self leftandrightUI];
        [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"changeCity" object:nil]throttle:1]subscribeNext:^(NSNotification * _Nullable x) {
            WCLShopSwitchListModel * model = (WCLShopSwitchListModel*)[x.userInfo objectForKey:@"key"];
                WCLLog(@"%@",@(model.organizeId));
                [self.backBtn setTitle:model.organizeName forState:UIControlStateNormal];
                //models.organizeId
                [self.viewModel.mainDataSignal subscribeNext:^(id  _Nullable x) {
                    [self.homeTableView.mj_header endRefreshing];
                    [self.homeTableView reloadData];
                }];
           
        }];
    }
    return self;
}
-(void)leftandrightUI
{
    _backBtn = [[YBLButton alloc] initWithFrame:CGRectMake(0, 20, 120, 44)];
    WEAK
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        WCLShopSwitchViewController * switchshop = [[WCLShopSwitchViewController alloc]init];
        [self.homeVC.navigationController pushViewController:switchshop animated:YES];
    }];
    [_backBtn setTitle:@"百大悦城" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [_backBtn setTitleColor:[UIColor colorWithHexString:@"#990000"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"home_icon_location"] forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    self.homeVC.navigationItem.leftBarButtonItem = barItem;
    
    UIButton * rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        WCLMainScanViewController * switchshop = [[WCLMainScanViewController alloc]init];
        [self.homeVC.navigationController pushViewController:switchshop animated:YES];
    }];
    [rightBtn setImage:[UIImage imageNamed:@"JDMainPage_icon_scan"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.homeVC.navigationItem.rightBarButtonItem = rightItem;
}
- (void)requestHomeData{
    WEAK;
    [self.viewModel.mainDataSignal subscribeNext:^(id  _Nullable x) {
        STRONG;
        //        WCLLog(@"%@",x);
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
        [_homeTableView registerClass:[WCLHomeFuncCell class] forCellReuseIdentifier:@"funcCell"];
        [_homeTableView registerClass:[WCLHomeCouPonCell class] forCellReuseIdentifier:@"WCLHomeCouPonCell"];
        [_homeTableView registerClass:[WCLHomeGiftCell class] forCellReuseIdentifier:@"GiftCell"];
//        [_homeTableView registerClass:[WCLHomeActivityCell class] forCellReuseIdentifier:@"activitycells"];
        [_homeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_homeTableView setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED"]];
        WEAK
        //        [YBLMethodTools footerAutoRefreshWithTableView:_homeTableView completion:^{
        //            STRONG
        //            [self loadCommandMore];
        //        }];
        [YBLMethodTools headerRefreshWithTableView:_homeTableView completion:^{
            STRONG
            [self requestHomeData];
        }];
    }
    return _homeTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if(section==1)
    {
        return 1;
    }
    else if(section==2)
    {
        return [self.viewModel.cell_data_dict[@"优惠券"] count];
    }
    else if(section==3)
    {
        return 1;
    }
    else//第4行
        return [self.viewModel.cell_data_dict[@"活动"]count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return SCREEN_WIDTH/4+40;
    }
    else if(indexPath.section==1)
    {
        return 408;
    }
    else if(indexPath.section==2)
    {
        return 125;
    }
    else if (indexPath.section==3)
    {
//         NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"积分兑礼"];
        return 470;
    }
    else if(indexPath.section==4)//4
    {
        return 301;
    }
    else
        return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==4) {
        return 65;
    }
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        banerImgArray = [NSMutableArray arrayWithArray:[self.viewModel.cell_data_dict arrayForKey:@"轮播图"]];
        if (banerImgArray.count>0) {
            //            NSDictionary * dict = banerImgArray[0];
            return 187.5;
            
        }
        
    }
    else if (section==2||section==3||section==4)
    {
        return 65;
    }
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==4) {
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
    else if (section==1)
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        return view;
    }
    else if (section==2||section==3||section==4)
    {
        if ([[self.viewModel.cell_data_dict allKeys] count]>=section) {
            biaoTiStr  =[self.viewModel.cell_data_dict allKeys][section];
        }
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        UIButton * couponLabel = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 25, 200, 30)];
        couponLabel.tag = 220+section;
        [couponLabel setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        [couponLabel setTitle:biaoTiStr forState:UIControlStateNormal];
        [couponLabel setTitleColor:[UIColor colorWithHexString:@"#101010"] forState:UIControlStateNormal];
        [couponLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -couponLabel.imageView.bounds.size.width-30, 0, couponLabel.imageView.bounds.size.width)];
        [couponLabel setImageEdgeInsets:UIEdgeInsetsMake(0, couponLabel.titleLabel.bounds.size.width, 0, -couponLabel.titleLabel.bounds.size.width)];
        [[couponLabel rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            switch (x.tag) {
                case 222://优惠券
                {
                    
                }
                    break;
                 case 223://积分兑礼
                {
                    WCLJiFenViewController * jfVC = [[WCLJiFenViewController alloc]init];
                    [self.homeVC.navigationController pushViewController:jfVC animated:YES];    
                }break;
                    case 224://活动
                {
                    
                }break;
                default:
                    break;
            }
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
    NSArray * array = [self.viewModel.cell_data_dict arrayForKey:@"功能菜单"];
    if (section==0) {
        NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array];
        WCLHomeFuncCell *cell = [tableView dequeueReusableCellWithIdentifier:@"funcCell"];
        cell.funcArr = tuijianArr;
        cell.delegate = self;
        reCell = cell;
    }
    else if (section==1)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellone"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellone"];
        }
        cell.textLabel.text= @"1";
        reCell = cell;
    }
    else if(section==2)
    {
        NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"优惠券"];
        NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array1];
        WCLHomeCouPonModel* model = tuijianArr[row];
        WCLHomeCouPonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WCLHomeCouPonCell"];
        cell.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        cell.models = model;
        cell.receiveBtn.selected = self.isAgree;
        reCell= cell;
        
        
    }
    else if (section==3)
    {
        NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"积分兑礼"];
        NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array1];
        WCLHomeGiftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GiftCell"];
        cell.giftArr =tuijianArr;
        reCell = cell;
    }
    else if(section==4)
    {
        NSArray * array1 = [self.viewModel.cell_data_dict arrayForKey:@"活动"];
        NSMutableArray* tuijianArr = [NSMutableArray arrayWithArray:array1];
        WCLHomeActivityModel * models = tuijianArr[row];
        WCLHomeActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"activitycells"];
        if (!cell) {
            cell = [[WCLHomeActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activitycells"];
        }
        cell.models = models;
        reCell = cell;
    }
    reCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return reCell;
}
-(void)homeFuncClick:(NSInteger)index
{
    //    WCLLog(@"%d",index);
    NSArray * array = [self.viewModel.cell_data_dict arrayForKey:@"功能菜单"];
    WCLHomeFuncModel * model = array[index];
//    WCLLog(@"%@--%@",model.functionName,model.functionType);
    if ([model.functionName isEqualToString:@"找店铺"]) {
        WCLFindShopVC * vc = [[WCLFindShopVC alloc]init];
        [self.homeVC.navigationController pushViewController:vc animated:YES];
    }
    else if ([model.functionName isEqualToString:@"我要买"]) {
        
    }
    else if ([model.functionName isEqualToString:@"室内导航"]) {
        
    }
    else if ([model.functionName isEqualToString:@"会员码"]) {
        WCLMemberCodeVC * cvc = [[WCLMemberCodeVC alloc]init];
        [self.homeVC.navigationController pushViewController:cvc animated:YES];
    }
//    WCLFindViewController* find = [[WCLFindViewController alloc]init];
//    [self.homeVC.navigationController pushViewController:find animated:YES];
}
#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"请在设置中打开定位,确定附近商城"];
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    //        [[UIApplication sharedApplication]openURL:settingURL];
    //    }];
    //    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    [alert addAction:cancel];
    //    [alert addAction:ok];
    
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@(currentLocation.coordinate.latitude) forKey:@"lng"];
    [parameter setObject:@(currentLocation.coordinate.longitude) forKey:@"lat"];
    [[wclNetTool sharedTools]request:POST urlString:@"appRequest/nearestMall.json" parameters:parameter finished:^(id responseObject, NSError *error) {
        WCLLog(@"%@",responseObject);
        [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"hash"] forKey:@"hash"];
        [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"organizeId"] forKey:@"organizeId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self requestHomeData];
        [self.backBtn setTitle:responseObject[@"data"][@"organizeName"] forState:UIControlStateNormal];
    }];
    //当前的经纬度
    //    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        return;
    }
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            _currentCity = placeMark.locality;
            if (!_currentCity) {
                _currentCity = @"无法定位当前城市";
            }
    
        }else if (error == nil && placemarks.count){
            [self requestHash];
            //            NSLog(@"NO location and error return");
        }else if (error){
            [self requestHash];
            //            NSLog(@"loction error:%@",error);
        }
    }];
}
-(void)requestHash
{
    [[wclNetTool sharedTools]request:POST urlString:@"appRequest/nearestMall.json" parameters:nil finished:^(id responseObject, NSError *error) {
        //        WCLLog(@"%@",responseObject);
        [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"hash"] forKey:@"hash"];
        [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"organizeId"] forKey:@"organizeId"];
    }];
}
@end
