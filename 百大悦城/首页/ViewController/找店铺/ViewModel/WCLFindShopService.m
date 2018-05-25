//
//  WCLFindShopService.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/21.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLFindShopService.h"
#import "WCLFindShopVC.h"
#import "WCLFindShopViewModel.h"
#import "WCLFindShopModel.h"
#import "StoresSearchVC.h"
#import "WCLShopListCell.h"
#import "DropDownMenuList.h"
#import "WCLShopDetailVC.h"
@interface WCLFindShopService()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,DropDownMenuListDelegate,DropDownMenuListDataSouce>
@property(nonatomic,weak)WCLFindShopVC * findShopVC;
@property(nonatomic,weak)WCLFindShopViewModel *viewModel;
@property(nonatomic,weak)UISearchBar *searchbar;
@property(nonatomic,strong)DropDownMenuList* dropMenu;
@end
@implementation WCLFindShopService
{
    NSMutableArray * floorArrs;
    NSMutableArray * industryArrs;
}
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _findShopVC = (WCLFindShopVC*)VC;
        _viewModel = (WCLFindShopViewModel*)viewModel;
       floorArrs = [NSMutableArray array];
        industryArrs = [NSMutableArray array];

        UISearchBar *searchbar=[[UISearchBar alloc]init];
        self.searchbar=searchbar;
        searchbar.delegate=self;
        searchbar.tintColor=[UIColor colorWithHexString:@"#A6A6A6"];// 设置搜索框内按钮文字颜色，以及搜索光标颜色。
//        searchbar.searchBarStyle = UISearchBarStyleMinimal;
        searchbar.placeholder=@"输入店铺名称搜索";
        searchbar.frame=CGRectMake(0, 10, SCREEN_WIDTH, 44);
        [searchbar setImage:[UIImage imageNamed:@"icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        [searchbar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#F5F5F5"] frame:searchbar.frame]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self.findShopVC.view addSubview:searchbar];
        [searchbar setReturnKeyType:UIReturnKeyDone];
        UIButton * button = [[UIButton alloc]initWithFrame:searchbar.frame];
        [self.findShopVC.view addSubview:button];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.findShopVC.view addSubview:self.findShopTableView];
        self.dropMenu = [DropDownMenuList show:CGPointMake(0,50) andHeight:44];
        self.dropMenu.delegate = self;
        self.dropMenu.dataSource = self;
        [self.findShopVC.view addSubview:self.dropMenu];
        [self requestHomeData];
       
    }
    return self;
}
-(void)btnClick:(UIButton *)button
{
    StoresSearchVC * svc = [[StoresSearchVC alloc]init];
    [self.findShopVC.navigationController pushViewController:svc animated:YES];
}
- (void)requestHomeData{
    [[self.viewModel findShopSignalShopName:@"" withindustryId:@"" withfloorId:@""]subscribeNext:^(id  _Nullable x) {
      [self.findShopTableView.mj_header endRefreshing];
        [self.findShopTableView reloadData];
    }];
}
-(UITableView *)findShopTableView
{
    if (!_findShopTableView) {
        _findShopTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-88-84:SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
        _findShopTableView.delegate = self;
        _findShopTableView.dataSource = self;
        self.findShopTableView.estimatedSectionHeaderHeight = 0;
        self.findShopTableView.estimatedSectionFooterHeight=0;
        [_findShopTableView registerClass:[WCLShopListCell class] forCellReuseIdentifier:@"WCLShopListCell"];
        [_findShopTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        WEAK
        //        [YBLMethodTools footerAutoRefreshWithTableView:_homeTableView completion:^{
        //            STRONG
        //            [self loadCommandMore];
        //        }];
        [YBLMethodTools headerRefreshWithTableView:_findShopTableView completion:^{
            STRONG
            [self requestHomeData];
        }];
    }
    return _findShopTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [self.viewModel.cell_data_dict[@"店铺列表"]count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCLFindShopModel*model =self.viewModel.cell_data_dict[@"店铺列表"][indexPath.row];
    WCLShopListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLShopListCell"];
    cell.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model=model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCLFindShopModel*model =self.viewModel.cell_data_dict[@"店铺列表"][indexPath.row];
    
    WCLShopDetailVC * dvc = [[WCLShopDetailVC alloc]init];
    dvc.shopid = model.shopId;
    dvc.industryName = model.industryName;
    [self.findShopVC.navigationController pushViewController:dvc animated:YES];
}
#pragma mark - WSDropMenuView Delegate -
-(NSMutableArray *)menuNumberOfRowInColumn {
    return @[@"全部分类",@"全部楼层"].mutableCopy;
}
-(NSInteger)menu:(DropDownMenuList *)menu numberOfRowsInColum:(NSInteger)column {
    if (column == 0) {
        return [self.viewModel.cell_data_dict[@"全部分类"]count];
    }else {
        return  [self.viewModel.cell_data_dict[@"全部楼层"]count];
    }
}
-(NSString *)menu:(DropDownMenuList *)menu titleForRowAtIndexPath:(HZIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        WCLShopIndustryModel* model =self.viewModel.cell_data_dict[@"全部分类"][indexPath.row];
        return model.industryName;
    }else {
        WCLFindShopFloorModel *models = self.viewModel.cell_data_dict[@"全部楼层"][indexPath.row];
        return models.floorName;
    }
}
-(void)menu:(DropDownMenuList *)segment didSelectRowAtIndexPath:(HZIndexPath *)indexPath {
//    NSLog(@"------%ld----->>>%ld",indexPath.column,indexPath.row);
    switch (indexPath.column) {
        case 0://左边
        {
            WCLShopIndustryModel *models = self.viewModel.cell_data_dict[@"全部分类"][indexPath.row];
            [self requestHomeDataWithColumn:0 withID:[NSString stringWithFormat:@"%@",@(models.industryId)]];
        }
            break;
        case 1://右边
        {
            WCLFindShopFloorModel *models = self.viewModel.cell_data_dict[@"全部楼层"][indexPath.row];
            [self requestHomeDataWithColumn:1 withID:[NSString stringWithFormat:@"%@",@(models.floorId)]];
            
        }break;
        default:
            break;
    }
}

- (void)requestHomeDataWithColumn:(NSInteger)colunmn withID:(NSString*)ID{
    if (colunmn==0) {
        [[self.viewModel findShopSignalShopName:@"" withindustryId:ID withfloorId:@""]subscribeNext:^(id  _Nullable x) {
            [self.findShopTableView.mj_header endRefreshing];
            [self.findShopTableView reloadData];
        }];
    }
    else if (colunmn==1)
    {
        [[self.viewModel findShopSignalShopName:@"" withindustryId:@"" withfloorId:ID]subscribeNext:^(id  _Nullable x) {
            [self.findShopTableView.mj_header endRefreshing];
            [self.findShopTableView reloadData];
        }];
    }
   
}
@end
