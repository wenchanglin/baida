//
//  StoresSearchVC.m
//  CategaryShow
//
//  Created by 文长林 on 2018/3/14.
//  Copyright © 2018年 Mr.huang. All rights reserved.
//

#import "StoresSearchVC.h"
#import"WCLFindShopModel.h"
#import "WCLShopListCell.h"
#import "WCLShopDetailVC.h"
#import <UIScrollView+EmptyDataSet.h>
@interface StoresSearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)NSMutableArray * storeArray;
@property(nonatomic,strong)UITableView * storeTableView;
@property (strong,nonatomic) NSMutableArray  *searchList;//保存搜索结果
@property (assign,nonatomic) BOOL active;
@property(nonatomic,strong)UIImageView *nodataView;
@property(nonatomic,strong)UILabel *nodataLabel;

@property(nonatomic,weak)UISearchBar *searchbar;
@end

@implementation StoresSearchVC
{
    NSInteger page;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchDataWithKeyWord:) name:@"mandiancollect" object:nil];
   
    self.title = @"找店铺";
    _searchList =[NSMutableArray array];
    page =1;
    //[self settabTitle:@"门店搜索"];
    [self createUI];
}
-(void)searchDataWithKeyWord:(NSString *)keyword
{
        WEAK
        [SVProgressHUD showWithStatus:@"加载中"];
        NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
        parameter[@"shopName"] = keyword;
        parameter[@"pageNum"] = @(page);
        parameter[@"industryId"] = @"";
        [[wclNetTool sharedTools]request:POST urlString:@"shop/getShopList.json" parameters:parameter finished:^(id responseObject, NSError *error) {
            [SVProgressHUD dismiss];
            WCLLog(@"%@",responseObject);
            if([[responseObject arrayForKey:@"shopList"]count]>0)
            {
                NSMutableArray * stroyArr = [WCLFindShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"shopList"]];
                for (WCLFindShopModel*models in stroyArr) {
                    [self.searchList addObject:models];
                }
                NSInteger pages = [responseObject[@"page"][@"pages"] integerValue];
                if (pages>self->page) {
                    [YBLMethodTools footerRefreshWithTableView:self.storeTableView completion:^{
                    STRONG
                    self->page +=1;
                    [self searchDataWithKeyWord:keyword];
                    }];
                [self.storeTableView.mj_header endRefreshing];
                }
                else if(pages<=self->page)
                {
                self.storeTableView.mj_footer.hidden=YES;
                [self.storeTableView.mj_header endRefreshing];

                
                }
            }
            else
            {
                [self.storeTableView.mj_header endRefreshing];
            }
            [self.storeTableView reloadData];

        }];

}
#pragma mark - 占位图
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"icon_nostore"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#A4C9EE"]
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}


-(void)createUI
{
    if (@available(iOS 11.0, *)) {
        self.storeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _storeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-88-54: SCREEN_HEIGHT-64-38) style:UITableViewStyleGrouped];
    _storeTableView.dataSource = self;
    _storeTableView.delegate = self;
    _storeTableView.emptyDataSetDelegate = self;
    _storeTableView.emptyDataSetSource = self;
    _storeTableView.estimatedSectionFooterHeight =0;
    _storeTableView.estimatedSectionHeaderHeight=0;
    _storeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_storeTableView registerClass:[WCLShopListCell class] forCellReuseIdentifier:@"WCLShopListCells"];
    [self.view addSubview:_storeTableView];
    UISearchBar *searchbar=[[UISearchBar alloc]init];
    self.searchbar=searchbar;
    searchbar.delegate=self;
    searchbar.tintColor=[UIColor colorWithHexString:@"#A6A6A6"];// 设置搜索框内按钮文字颜色，以及搜索光标颜色。
    
    searchbar.placeholder=@"输入店铺名称搜索";
    searchbar.frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
    [searchbar setImage:[UIImage imageNamed:@"icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
   [searchbar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#F5F5F5"] frame:searchbar.frame]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.view addSubview:searchbar];
    [searchbar setReturnKeyType:UIReturnKeyDone];
//    [self updown];
}
- (void)updown {
    __weak StoresSearchVC *weakSelf = self;
    _storeTableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
       self->page += 1;
        [weakSelf searchDataWithKeyWord:self.searchbar.text];
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchList count];
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
    WCLFindShopModel* model = self.searchList[indexPath.row];
    WCLShopListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WCLShopListCells"];
    cell.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model=model;
    return cell;
}
//点击了取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchbar resignFirstResponder];
    [self.searchbar setShowsCancelButton:NO animated:YES];
    self.searchbar.text=@"";
    page =1;
    self.active=NO;
}
//点击了搜索按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchbar resignFirstResponder];
    [self.searchbar setShowsCancelButton:NO animated:YES];
    self.active=NO;
    page = 1;
    [self.searchList removeAllObjects];
    [self searchDataWithKeyWord:searchBar.text];
    
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.active=YES;
    [self searchBar:searchBar textDidChange:@""];
    [self.searchbar setShowsCancelButton:YES animated:YES];
    for (id obj in [searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                }
            }
        }
    }
    return YES;
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
//    NSString *searchString = searchText;
//    page = 1;
    //[self searchDataWithKeyWord:searchString];
//    //刷新表格
//
//    [self.storeTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WCLFindShopModel* model = self.searchList[indexPath.row];
    WCLShopDetailVC * dvc = [[WCLShopDetailVC alloc]init];
    dvc.shopid = model.shopId;
    dvc.yetaiStr = [model.industryList[0] stringForKey:@"industryName"];
    dvc.floorName = model.floorName;
    [self.navigationController pushViewController:dvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
