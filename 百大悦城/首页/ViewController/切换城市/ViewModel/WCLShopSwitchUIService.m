//
//  WCLShopSwitchUIService.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/23.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLShopSwitchUIService.h"
#import "WCLShopSwitchViewModel.h"
#import "WCLShopSwitchModel.h"
#import "WCLShopSwitchViewController.h"
#import "WCLShopSwitchLeftCell.h"
#import "WCLShopSwitchRightCell.h"
@interface WCLShopSwitchUIService()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) WCLShopSwitchViewController *shopSwitchVC;
@property (nonatomic, weak) WCLShopSwitchViewModel *viewModel;
@property (nonatomic, strong) NSIndexPath *lastPath;  // 单选
@property (nonatomic, assign) BOOL isRepeatRolling;  // 是否重复滚动

@end
@implementation WCLShopSwitchUIService
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _viewModel =(WCLShopSwitchViewModel*) viewModel;
        _shopSwitchVC = (WCLShopSwitchViewController*)VC;
        _selectIndex = 0;
        _isScrollDown = YES;
        [self.shopSwitchVC.view addSubview:self.leftTableView];
        [self.shopSwitchVC.view addSubview:self.rightTableView];
        [self requestData];
    }
    return self;
}
-(void)requestData
{
    [self.viewModel.mainDataSignal subscribeNext:^(id  _Nullable x) {
      if([x isKindOfClass:[NSDictionary class]])
      {
          [self.leftTableView reloadData];
          [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
          [self.rightTableView reloadData];
      }
    }];
}
-(UITableView *)leftTableView
{
    if (!_leftTableView) {
        self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100,IsiPhoneX?SCREEN_HEIGHT-88:SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        self.leftTableView.dataSource = self;
        self.leftTableView.delegate = self;
        self.leftTableView.estimatedRowHeight = 0;
        self.leftTableView.estimatedSectionFooterHeight = 0;
        self.leftTableView.estimatedSectionHeaderHeight = 0;
        [self.leftTableView registerClass:[WCLShopSwitchLeftCell class] forCellReuseIdentifier:@"LeftCell"];
        self.leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        self.leftTableView.showsVerticalScrollIndicator = NO; // 隐藏滚动条
        
    }
    return _leftTableView;
}
- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.rightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_rightTableView registerClass:[WCLShopSwitchRightCell class] forCellReuseIdentifier:@"WCLShopSwitchRightCell"];
    }
    return _rightTableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.leftTableView == tableView) {
        return 1;//[self.viewModel.cell_data_dict[@"左表"]count];
    } else {
        return [self.viewModel.cell_data_dict[@"左表"]count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.leftTableView == tableView) {
        return [self.viewModel.cell_data_dict[@"左表"]count];
    } else {
        
        return [self.viewModel.cell_data_dict[@"右表"][section]count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return 40;
    } else {
        return 216;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 0;
    } else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return CGFLOAT_MIN;
    } else {
        return CGFLOAT_MIN;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return @"";
    } else {
         WCLShopSwitchModel *model = self.viewModel.cell_data_dict[@"左表"][section];
        return model.cityName;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.leftTableView == tableView) {
        WCLShopSwitchModel *model = self.viewModel.cell_data_dict[@"左表"][indexPath.row];
        WCLShopSwitchLeftCell * leftCell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
        leftCell.leftBtn.text = model.cityName;
        leftCell.yellowView.hidden =NO;
        leftCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return leftCell;
    } else {
        WCLShopSwitchListModel * models = self.viewModel.cell_data_dict[@"右表"][indexPath.section][indexPath.row];
        WCLShopSwitchRightCell * rightCell = [tableView dequeueReusableCellWithIdentifier:@"WCLShopSwitchRightCell"];
        rightCell.backgroundColor = YBLColor(242,244,245,1);
        rightCell.selectionStyle = UITableViewCellSelectionStyleNone;
        rightCell.models= models;
        return rightCell;
    }
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && !_isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && _isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section + 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
    else
    {
    WCLShopSwitchListModel * models = self.viewModel.cell_data_dict[@"右表"][indexPath.section][indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeCity" object:nil userInfo:@{@"key":models}];
    [self.shopSwitchVC.navigationController popViewControllerAnimated:YES];
    }
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}
@end
