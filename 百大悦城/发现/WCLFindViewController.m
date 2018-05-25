
//
//  WCLFindViewController.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/15.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLFindViewController.h"
#import "WCLGoodsViewController.h"
#import "WCLFoodViewController.h"
#import "WCLMovieViewController.h"
#import "PagerView.h"
@interface WCLFindViewController ()
@property(nonatomic,strong) PagerView *pagerView;

@end

@implementation WCLFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupAllChildCotroller];
    _pagerView = [[PagerView alloc]initWithFrame:CGRectMake(0,IsiPhoneX?34:14,SCREEN_WIDTH,SCREEN_HEIGHT-49)
                               SegmentViewHeight:50
                                      titleArray:@[@"好物",@"美食",@"电影"]
                                      Controller:self
                                       lineWidth:20
                                      lineHeight:3];
    
    [self.view addSubview:_pagerView];
}
// 添加子控制器
- (void)setupAllChildCotroller {
    //全部
    WCLGoodsViewController *oneVC = [[WCLGoodsViewController alloc] init];
    [self addChildViewController:oneVC];
    
    //购买
    WCLFoodViewController *twoVC = [[WCLFoodViewController alloc] init];
    [self addChildViewController:twoVC];
    
    //提现
    WCLMovieViewController *threeVC = [[WCLMovieViewController alloc] init];
    [self addChildViewController:threeVC];
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
