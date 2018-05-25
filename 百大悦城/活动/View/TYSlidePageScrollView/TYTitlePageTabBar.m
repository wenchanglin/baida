//
//  TYTitlePageTabBar.m
//  TYSlidePageScrollViewDemo
//
//  Created by SunYong on 15/7/16.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYTitlePageTabBar.h"

@interface TYTitlePageTabBar ()
@property (nonatomic, strong) NSArray *btnArray;
@property (nonatomic, strong) UIButton *selectBtn;
@property(nonatomic,strong)UIScrollView * tyScrollView;
@property (nonatomic, weak) UIView *horIndicator;
@end

@implementation TYTitlePageTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _textFont = [UIFont systemFontOfSize:16];
        _selectedTextFont = [UIFont systemFontOfSize:16];
        _textColor = [UIColor colorWithHexString:@"#E0BE8D"];
        _selectedTextColor =[UIColor colorWithHexString:@"#990000"];
        _horIndicatorColor = [UIColor colorWithHexString:@"#990000"];
        _horIndicatorHeight = 3;
        [self addHorIndicatorView];
    }
    return self;
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray
{
    if (self = [super init]) {
        _titleArray = titleArray;
        [self addTitleBtnArray];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    [self addTitleBtnArray];
}

#pragma mark - add subView

- (void)addHorIndicatorView
{
    UIView *horIndicator = [[UIView alloc]init];
    horIndicator.backgroundColor = _horIndicatorColor;
    [self.tyScrollView addSubview:horIndicator];
    _horIndicator = horIndicator;
}
-(UIScrollView *)tyScrollView
{
    if (!_tyScrollView) {
        UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        titleScrollView.scrollsToTop = NO;
        titleScrollView.showsHorizontalScrollIndicator=NO;
        [self addSubview:titleScrollView];
        _tyScrollView =titleScrollView;
    }
    return _tyScrollView;
}
- (void)addTitleBtnArray
{
    if (_btnArray) {
        [self removeTitleBtnArray];
    }
    
    NSMutableArray *btnArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
    for (NSInteger index = 0; index < _titleArray.count; ++index) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        button.titleLabel.font = _textFont;
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button setTitle:_titleArray[index] forState:UIControlStateNormal];
        [button setTitleColor:_textColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(tabButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.tyScrollView addSubview:button];
        [btnArray addObject:button];
        if (index == 0) {
            [self selectButton:button];
        }
    }
    _btnArray = [btnArray copy];
}

#pragma mark - private menthod

- (void)removeTitleBtnArray
{
    for (UIButton *button in _btnArray) {
        [button removeFromSuperview];
    }
    _btnArray = nil;
}

- (void)selectButton:(UIButton *)button
{
    if (_selectBtn) {
        _selectBtn.selected = NO;
        if (_selectedTextFont) {
            _selectBtn.titleLabel.font = _textFont;
        }
    }
    _selectBtn = button;
    
    CGRect frame = _horIndicator.frame;
    frame.origin.x = CGRectGetMinX(_selectBtn.frame);
    [UIView animateWithDuration:0.2 animations:^{
        _horIndicator.frame = frame;
        
    }];
    
    _selectBtn.selected = YES;
    if (_selectedTextFont) {
        _selectBtn.titleLabel.font = _selectedTextFont;
    }
}

#pragma mark - action method
// clicked
- (void)tabButtonClicked:(UIButton *)button
{
    [self selectButton:button];
    
    // need ourself call this method
    [self clickedPageTabBarAtIndex:button.tag];
}

#pragma mark - override method
// override
- (void)switchToPageIndex:(NSInteger)index
{
    if (index >= 0 && index < _btnArray.count) {
        [self selectButton:_btnArray[index]];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnWidth = (CGRectGetWidth(self.frame)-_edgeInset.left-_edgeInset.right + _titleSpacing)/_btnArray.count - _titleSpacing;
    CGFloat viewHeight = CGRectGetHeight(self.frame)-_edgeInset.top-_edgeInset.bottom;
    
    [_btnArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.frame = CGRectMake(idx*(btnWidth+40+_titleSpacing)+_edgeInset.left, _edgeInset.top, btnWidth+40, viewHeight);
        self.tyScrollView.frame =CGRectMake(0, _edgeInset.top, SCREEN_WIDTH, viewHeight);
    }];
    self.tyScrollView.contentSize = CGSizeMake(_edgeInset.left+(btnWidth+40+_titleSpacing)*_btnArray.count,0);

    NSInteger curIndex = 0;
    if (_selectBtn) {
        curIndex = [_btnArray indexOfObject:_selectBtn];
    }
    _horIndicator.frame = CGRectMake(curIndex*(btnWidth+40+_titleSpacing)+_edgeInset.left, CGRectGetHeight(self.frame) - _horIndicatorHeight-15, btnWidth+40, _horIndicatorHeight);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
