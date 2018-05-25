//
//  WCLJiFenDetailService.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/25.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLJiFenDetailService.h"
#import "WCLJiFenDetailViewModel.h"
#import "WCLJiFenDetailViewController.h"
#import "JiFenDetailCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TDAlertView.h"
@interface WCLJiFenDetailService()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) WCLJiFenDetailViewController *jiFenVC;
@property (nonatomic, weak) WCLJiFenDetailViewModel *viewModel;
@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong)UILabel * jifenLabel;
@property(nonatomic,strong)UIButton * exchangeBtn;
@property(nonatomic,strong)TDAlertView * alertViews;
@end
@implementation WCLJiFenDetailService
{
    NSInteger count;
    NSInteger score;
}
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _jiFenVC = (WCLJiFenDetailViewController*)VC;
        _jiFenVC.view.backgroundColor =[UIColor whiteColor];
        _viewModel =(WCLJiFenDetailViewModel*)viewModel;
        [self.jiFenVC.view addSubview:self.jifenDetailTableView];
        count=1;
        [self createBottomView];
        [self requestData];
        [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"changecount" object:nil]subscribeNext:^(NSNotification * _Nullable x) {
            
            self->count = [[x.userInfo objectForKey:@"shuliang"] integerValue];
            self->score = [[x.userInfo objectForKey:@"jifen"]integerValue];
            self.jifenLabel.text = [NSString stringWithFormat:@"%@积分",@(self->count *self->score)];
        }];
    }
    return self;
}
- (void)requestData{
    WEAK;
    [[self.viewModel mainDataSignalWithID:self.jiFenVC.jifenID] subscribeNext:^(id  _Nullable x) {
        STRONG;
        //        WCLLog(@"%@",x);
        [self.jifenDetailTableView.mj_header endRefreshing];
        [self.jifenDetailTableView reloadData];
        
    }];
}

-(void)createBottomView
{
    UIView * bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#E0BE8D"];
    [self.jiFenVC.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jiFenVC.view.mas_bottom).offset(IsiPhoneX?-30:0);
        make.left.right.equalTo(self.jiFenVC.view);
        make.height.mas_equalTo(50);
    }];
    UILabel * leftLabel = [UILabel new];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.font = [UIFont fontWithName:@"SFProDisplay-Semibold" size:22];
    [bottomView addSubview:leftLabel];
    _jifenLabel = leftLabel;
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    UIButton * duihuanBtn = [UIButton new];
    _exchangeBtn =duihuanBtn;
    duihuanBtn.layer.cornerRadius=16.5;
    [duihuanBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    WEAK
    [[duihuanBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[self.viewModel exchangeGiftSignalWithNum:self->count WithID:self.jiFenVC.jifenID]subscribeNext:^(JiFenModel* x) {
            if ([x.state isEqualToString:@"EXCHANGED"]) {
                [duihuanBtn setTitle:@"已兑换" forState:UIControlStateNormal];
                duihuanBtn.enabled =NO;
            }
            else if([x.state isEqualToString:@"NOHAVE"])
            {
                [SVProgressHUD showErrorWithStatus:@"已兑完"];
            }
            else if([x.state isEqualToString:@"NOPOINTS"])
            {
                [SVProgressHUD showErrorWithStatus:@"积分不足"];
            }
            else
            {
                WCLLog(@"%@",x.state);
               

            }
        }];
    }];
    duihuanBtn.backgroundColor = [UIColor colorWithHexString:@"#990000"];
    duihuanBtn.layer.masksToBounds= YES;
    [bottomView addSubview:duihuanBtn];
    [duihuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(150);
    }];
}
-(UITableView *)jifenDetailTableView
{
    if (!_jifenDetailTableView) {
        
        _jifenDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,IsiPhoneX?SCREEN_HEIGHT-88-84:SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
        _jifenDetailTableView.delegate = self;
        _jifenDetailTableView.dataSource = self;
        self.jifenDetailTableView.estimatedSectionHeaderHeight = 0;
        self.jifenDetailTableView.estimatedSectionFooterHeight=0;
        [_jifenDetailTableView registerClass:[JiFenDetailCell class] forCellReuseIdentifier:@"JiFenDetailCell"];

        [_jifenDetailTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_jifenDetailTableView setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED"]];
        WEAK
        //        [YBLMethodTools footerAutoRefreshWithTableView:_homeTableView completion:^{
        //            STRONG
        //            [self loadCommandMore];
        //        }];
        [YBLMethodTools headerRefreshWithTableView:_jifenDetailTableView completion:^{
            STRONG
            [self requestData];
        }];
    }
    return _jifenDetailTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.viewModel.cell_data_dict[@"jifenDetail"]count];
    }
    else if(section==1)
    {
        return 1;
    }
    else
    {
        return 1;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.jifenDetailTableView fd_heightForCellWithIdentifier:@"JiFenDetailCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}
#pragma mark - 给cell赋值
- (void)configureCell:(JiFenDetailCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    cell.models = self.viewModel.cell_data_dict[@"jifenDetail"][indexPath.row];
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
    JiFenDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JiFenDetailCell"];
    [self configureCell:cell atIndexPath:indexPath];
    _jifenLabel.text = [NSString stringWithFormat:@"%@积分",@(cell.clothesCount *cell.models.needScore)];
    return cell;
}
@end
