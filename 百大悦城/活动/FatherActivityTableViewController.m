//
//  TableViewController.m
//  SlidePageScrollView
//
//  Created by tanyang on 15/7/16.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "FatherActivityTableViewController.h"
#import "MJRefresh.h"
#import "WCLActivityModel.h"
#import "WCLActivityCell.h"
#import "WCLActivityDetailVC.h"
@interface FatherActivityTableViewController ()
@property(nonatomic,assign)BOOL didEndDecelerating;
@end

@implementation FatherActivityTableViewController
{
    NSMutableArray * bannerArr;
    UIView *bgNoDingView;   //没有订单界面底层

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.tableView.mj_header beginRefreshing];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"gundong" object:nil] map:^id(NSNotification *value) {
        return value.userInfo;
    }] distinctUntilChanged] subscribeNext:^(id x) {
       self.ID =[[x stringForKey:@"gundongId"]integerValue];
    }];
    [self reqestDataForID:_ID];
   NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY/MM/dd - HH:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    if (![locationString isEqualToString:[ud objectForKey:@"tabbarDate"]]) {
        //说明是第一次启动
        [self reqestDataForID:_ID];
    }
    [ud setValue:locationString forKey:@"tabbarDate"];
    [ud synchronize];
    self.tableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight=0;
    self.tableView.tableFooterView = [[UIView alloc]init];
    __typeof (self) __weak weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakSelf delayInSeconds:1.0 block:^{
            [self reqestDataForID:weakSelf.ID];
            [weakSelf.tableView.header endRefreshing];
            [weakSelf.tableView reloadData];
         }];
    }];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakSelf delayInSeconds:1.0 block:^{
            weakSelf.itemNum += 4;
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf.tableView reloadData];
        }];
    }];
}
-(void)reqestDataForID:(NSInteger)ID
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"加载中"];
    params[@"organizeId"] = @"2";//responseObject[@"data"][@"organizeId"];
    params[@"tagId"] = @(ID);
    [[wclNetTool sharedTools]request:GET urlString:URL_ActivityList parameters:params finished:^(id responseObject, NSError *error) {
        [SVProgressHUD dismissWithDelay:1];
//        WCLLog(@"%@",responseObject);
        if ([responseObject[@"data"] count]>0) {
            bannerArr = [WCLActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
        }
        else
        {
            [self createViewNoDD];
        }
        
    }];
}
-(void)createViewNoDD    // 创建没有订单界面
{
    bgNoDingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - 41 - 64)];
    [bgNoDingView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgNoDingView];
    
    UIImageView *NoDD = [UIImageView new];
    [bgNoDingView addSubview:NoDD];
    NoDD.sd_layout
    .centerXEqualToView(bgNoDingView)
    .topSpaceToView(bgNoDingView, 120)
    .widthIs(211)
    .heightIs(220);
    [NoDD setImage:[UIImage imageNamed:@"HaveNoOrder"]];
    
    
    UIButton *clickToLookOther = [UIButton new];
    [bgNoDingView addSubview:clickToLookOther];
    
    clickToLookOther.sd_layout
    .centerXEqualToView(bgNoDingView)
    .topSpaceToView(NoDD, 20)
    .widthIs(80)
    .heightIs(35);
    [clickToLookOther.layer setCornerRadius:3];
    [clickToLookOther.layer setMasksToBounds:YES];
    [clickToLookOther setBackgroundColor:[UIColor blackColor]];
    [clickToLookOther.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [clickToLookOther setTitle:@"去逛逛" forState:UIControlStateNormal];
//    [clickToLookOther addTarget:self action:@selector(goToLookClothes) forControlEvents:UIControlEventTouchUpInside];
}
- (void)delayInSeconds:(CGFloat)delayInSeconds block:(dispatch_block_t) block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC),  dispatch_get_main_queue(), block);
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return bannerArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 301;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==bannerArr.count-1) {
        return 65;
    }
    else
        return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==bannerArr.count-1) {
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCLActivityModel * models = bannerArr[indexPath.section];
    WCLActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"activitycellsf"];
    if (!cell) {
        cell = [[WCLActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activitycellsf"];
    }
    cell.models = models;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCLActivityModel * model = bannerArr[indexPath.section];
    WCLActivityDetailVC * devc = [[WCLActivityDetailVC alloc]init];
    devc.activityID = model.marketingActivitySignupId;
    [self.navigationController pushViewController:devc animated:YES];
//    NSLog(@"你点击了第%@行",@(indexPath.section));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
