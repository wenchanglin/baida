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
#import "WCLShopDetailVC.h"
@interface WCLFindShopService()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,DropDownMenuListDelegate,DropDownMenuListDataSouce>
@property(nonatomic,weak)WCLFindShopVC * findShopVC;
@property(nonatomic,weak)WCLFindShopViewModel *viewModel;
@property(nonatomic,weak)UISearchBar *searchbar;
@property(nonatomic,strong)NSString* leftStr;
@property(nonatomic,strong)NSString*rightStr;
@end
@implementation WCLFindShopService
{
    NSMutableArray * floorArrs;
    NSMutableArray * industryArrs;
    NSInteger  page;
}
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _findShopVC = (WCLFindShopVC*)VC;
        _viewModel = (WCLFindShopViewModel*)viewModel;
       floorArrs = [NSMutableArray array];
        industryArrs = [NSMutableArray array];
        page=1;
        UISearchBar *searchbar=[[UISearchBar alloc]init];
        self.searchbar=searchbar;
        searchbar.delegate=self;
        searchbar.tintColor=[UIColor colorWithHexString:@"#A6A6A6"];// 设置搜索框内按钮文字颜色，以及搜索光标颜色。
//        searchbar.searchBarStyle = UISearchBarStyleMinimal;
        searchbar.placeholder=@"输入店铺名称搜索";
        searchbar.frame=CGRectMake(0, 0, SCREEN_WIDTH, 44);
        [searchbar setImage:[UIImage imageNamed:@"icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        [searchbar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#F5F5F5"] frame:searchbar.frame]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self.findShopVC.view addSubview:searchbar];
        [searchbar setReturnKeyType:UIReturnKeyDone];
        UIButton * button = [[UIButton alloc]initWithFrame:searchbar.frame];
        [self.findShopVC.view addSubview:button];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.findShopVC.view addSubview:self.findShopTableView];
        self.dropMenu = [DropDownMenuList show:CGPointMake(0,44) andHeight:44];
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
    WEAK
    [[self.viewModel findShopSignalShopName:@"" withindustryId:@"" withfloorId:@"" page:page]subscribeNext:^(id  _Nullable x) {
        NSInteger pages = [[x objectForKey:@"page"] integerValue];
        if (pages>self->page) {
            [YBLMethodTools footerRefreshWithTableView:self.findShopTableView completion:^{
                STRONG
                self->page +=1;
                [self requestHomeData];
            }];
            [self.findShopTableView.mj_header endRefreshing];
            [self.findShopTableView reloadData];
        }
        else if(pages<=self->page)
        {
            self.findShopTableView.mj_footer.hidden=YES;
            [self.findShopTableView.mj_header endRefreshing];

            [self.findShopTableView reloadData];
            
        }
    
    }];
}
-(UITableView *)findShopTableView
{
    if (!_findShopTableView) {
        _findShopTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-88-94:SCREEN_HEIGHT-64-94) style:UITableViewStyleGrouped];
        _findShopTableView.delegate = self;
        _findShopTableView.dataSource = self;
        self.findShopTableView.estimatedSectionHeaderHeight = 0;
        self.findShopTableView.estimatedSectionFooterHeight=0;
        [_findShopTableView registerClass:[WCLShopListCell class] forCellReuseIdentifier:@"WCLShopListCell"];
        [_findShopTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

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
    
    return 12;
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
    dvc.yetaiStr = [model.industryList[0] stringForKey:@"industryName"];
    dvc.shopid = model.shopId;
    dvc.floorName = model.floorName;
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
            page=1;
            [self.viewModel.shopListArr removeAllObjects];
            WCLShopIndustryModel *models = self.viewModel.cell_data_dict[@"全部分类"][indexPath.row];
            self.leftStr = models.industryId;
            [self requestHomeDataWithColumn:0 withID:models.industryId];
        }
            break;
        case 1://右边
        {
            page=1;
            [self.viewModel.shopListArr removeAllObjects];
            WCLFindShopFloorModel *models = self.viewModel.cell_data_dict[@"全部楼层"][indexPath.row];
            self.rightStr = models.floorId;
            [self requestHomeDataWithColumn:1 withID:models.floorId];
            
        }break;
        default:
            break;
    }
}
-(void)requestDataWithLeftColomn:(NSInteger)colunmn widthID:(NSString*)ID
{
    WEAK
    if (colunmn==0) {
        [[self.viewModel findShopSignalShopName:@"" withindustryId:ID withfloorId:self.rightStr page:page]subscribeNext:^(id  _Nullable x) {
            NSInteger pages = [[x objectForKey:@"page"] integerValue];
            if (pages>self->page) {
                [YBLMethodTools footerRefreshWithTableView:self.findShopTableView completion:^{
                    STRONG
                    self->page +=1;
                    [self requestDataWithLeftColomn:colunmn widthID:ID];
                }];
                [self.findShopTableView.mj_header endRefreshing];
                [self.findShopTableView reloadData];
            }
            else if(pages<=self->page)
            {
                self.findShopTableView.mj_footer.hidden=YES;
                [self.findShopTableView reloadData];
                
            }
        }];
    }
    else if (colunmn==1)
    {
        [[self.viewModel findShopSignalShopName:@"" withindustryId:self.leftStr withfloorId:ID page:page]subscribeNext:^(id  _Nullable x) {
            NSInteger pages = [[x objectForKey:@"page"] integerValue];
            if (pages>self->page) {
                [YBLMethodTools footerRefreshWithTableView:self.findShopTableView completion:^{
                    STRONG
                    self->page +=1;
                    [self requestDataWithLeftColomn:colunmn widthID:ID];
                }];
                [self.findShopTableView.mj_header endRefreshing];
                [self.findShopTableView reloadData];
            }
            else if(pages<=self->page)
            {
                self.findShopTableView.mj_footer.hidden=YES;
                [self.findShopTableView.mj_header endRefreshing];

                [self.findShopTableView reloadData];
                
            }
        }];
    }
}
- (void)requestHomeDataWithColumn:(NSInteger)colunmn withID:(NSString*)ID{
    
    [self requestDataWithLeftColomn:colunmn widthID:ID];
}
@end
