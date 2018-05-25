//
//  SQFiltrateView.m
//  FiltrateView
//
//  Created by quanminqianbao on 2017/12/7.
//  Copyright © 2017年 yangshuquan. All rights reserved.
//

#import "SQFiltrateView.h"

@implementation SQFiltrateItem

- (NSMutableSet *)choseSet{
    if (_choseSet) {
        return _choseSet;
    }
    _choseSet = [NSMutableSet set];
    
    return _choseSet;
}

@end


@interface SQFiltrateView ()

@property (nonatomic, strong) UIButton *bg_button;
@property (nonatomic, assign) NSUInteger select_itemIndex;

@end;


@implementation SQFiltrateView

- (instancetype)initWithFrame:(CGRect)frame filtrateItems:(NSArray<SQFiltrateItem *> *)filtrateItems{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.filtrateItems = filtrateItems;
        [self setViews];
    }
    return self;
}

- (void)setViews{
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    [self addSubview:lineView];
    [self bringSubviewToFront:lineView];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *lineView_left = [NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *lineView_bottom = [NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *lineView_height = [NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0.5];
    NSLayoutConstraint *lineView_right = [NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self addConstraints:@[lineView_left,lineView_bottom,lineView_height,lineView_right]];
    CGRect selfRect = self.frame;
    
    
    _bg_button = [UIButton buttonWithType:UIButtonTypeCustom];
    _bg_button.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    _bg_button.hidden = YES;
    _bg_button.frame = CGRectMake(CGRectGetMinX(selfRect), CGRectGetMaxY(selfRect), CGRectGetWidth(selfRect), SCREEN_HEIGHT-CGRectGetHeight(selfRect));
    [[UIApplication sharedApplication].keyWindow addSubview:_bg_button];
    [_bg_button addTarget:self action:@selector(bg_button_Action:) forControlEvents:UIControlEventTouchUpInside];
  
    NSMutableArray *buttons = @[].mutableCopy;
    __block  UIView *lastView = nil;
    [self.filtrateItems enumerateObjectsUsingBlock:^(SQFiltrateItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SQCustomButton *button =  [[SQCustomButton alloc]initWithFrame:CGRectZero
                                                                  type:SQCustomButtonRightImageType
                                                             imageSize:CGSizeMake(11, 10)
                                                             midmargin:2];
        button.imageView.image = [UIImage imageNamed:@"borrow_down"];
        button.titleLabel.text = obj.title;
        button.titleLabel.textColor = [UIColor grayColor];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:button];
        [buttons addObject:button];
        obj.button = button;
        typeof(self) weakSelf = self;
        [button touchAction:^(SQCustomButton * _Nonnull button) {
            weakSelf.select_itemIndex = [buttons indexOfObject:button];
            [weakSelf click:obj];
        }];
    
        [self setListView:obj];
        NSLayoutConstraint *button_left;
        if (lastView) {
             button_left = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        }else{
            button_left = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        }
    
         NSLayoutConstraint *button_top = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        NSLayoutConstraint *button_bottom = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
          NSLayoutConstraint *lineView_width = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:SCREEN_WIDTH/self.filtrateItems.count];
        [self addConstraints:@[button_left,button_top,button_bottom,lineView_width]];
        
        lastView = button;
    }];

    
}

- (void)setListView:(SQFiltrateItem *)filtrateItem{
    
    
    UIView *tempView = [[UIView alloc]init];
    tempView.backgroundColor = [UIColor whiteColor];
    tempView.clipsToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:tempView];
    filtrateItem.bg_View = tempView;
    tempView.hidden = YES;
    if (filtrateItem.listType == OptionListType_Tag) {
        
        
        
        NSInteger eachNumber = 3;
        NSInteger tagHeight = 30;
        CGFloat width = (self.frame.size.width-15*2-10*(eachNumber-1))/eachNumber;
        NSMutableArray *tempArray = @[].mutableCopy;
        for (NSInteger i=0; i<filtrateItem.optionData.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:filtrateItem.optionData[i] forState:0];
            [button setTitleColor:[UIColor grayColor] forState:0];
            button.layer.cornerRadius = 2.f;
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.tag = i;
            NSInteger a = i/eachNumber;
            NSInteger b = i%eachNumber;
            
            button.frame = (CGRect){15+(width+10)*b,15+(tagHeight+10)*a,width,tagHeight};
            [tempView addSubview:button];
            if (i==filtrateItem.optionData.count-1) {
                tempView.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame),0);
                filtrateItem.bg_ViewHeight = CGRectGetMaxY(button.frame)+15;
            }
            [tempArray addObject:button];
            [button addTarget:self action:@selector(select_button_action:) forControlEvents:UIControlEventTouchUpInside];
          
        }
        
        filtrateItem.listCellViews = tempArray;
    }
    
    
    
    if (filtrateItem.listType == OptionListType_Cell) {
        CGFloat cellHeight = 45.f;
        NSMutableArray *tempArray = @[].mutableCopy;
        for (NSInteger i=0; i<filtrateItem.optionData.count; i++){
            UIView *labeltempView = [[UIView alloc]initWithFrame:CGRectMake(0, (cellHeight+0.5)*i, SCREEN_WIDTH, cellHeight)];
            [tempView addSubview:labeltempView];
            labeltempView.tag = i;
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:14];
            label.text = filtrateItem.optionData[i];
            [labeltempView addSubview:label];
            [tempArray addObject:label];
            label.frame = CGRectMake(15, 95, SCREEN_WIDTH-15, cellHeight);
         
            if (i<filtrateItem.optionData.count-1) {
                UIView *lineView = [UIView new];
                lineView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
                [labeltempView addSubview:lineView];
                lineView.frame = CGRectMake(15, cellHeight-0.5, SCREEN_WIDTH-15, 0.5);
            }
            
            if (i==filtrateItem.optionData.count-1) {
                tempView.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame),0);
                filtrateItem.bg_ViewHeight = CGRectGetMaxY(labeltempView.frame)+0.5;
            }
            labeltempView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)];
            [labeltempView addGestureRecognizer:tap];

     
            
        }
        filtrateItem.listCellViews = tempArray;
        
    }
    
}

- (void)hideAllItemView{
    for (SQFiltrateItem *item in self.filtrateItems) {
        item.isShow = YES;
    }
    [self click:self.filtrateItems[0]];
}

- (void)click:(SQFiltrateItem *)filtrateItem{
    for (SQFiltrateItem *item in self.filtrateItems) {
        
        if ([item.title isEqualToString:filtrateItem.title]) {
            item.isShow = !item.isShow;
            if (item.isShow) {
                item.bg_View.hidden = NO;
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect fram = item.bg_View.frame;
                    fram.size.height = item.bg_ViewHeight;
                    item.bg_View.frame = fram;
                    _bg_button.hidden = NO;
                    item.button.imageView.image = [UIImage imageNamed:@"borrow_up"];
                    item.button.titleLabel.textColor = [UIColor redColor];
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                item.bg_View.hidden = YES;
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect fram = item.bg_View.frame;
                    fram.size.height = 0;
                    item.bg_View.frame = fram;
                    _bg_button.hidden = YES;
                    item.button.imageView.image = [UIImage imageNamed:@"borrow_down"];
                    item.button.titleLabel.textColor = [UIColor grayColor];
                } completion:^(BOOL finished) {
                    
                }];
            }
            
        }else{
            item.isShow = NO;
            item.bg_View.hidden = YES;
            CGRect fram = item.bg_View.frame;
            fram.size.height = 0;
            item.bg_View.frame = fram;
            item.button.imageView.image = [UIImage imageNamed:@"borrow_down"];
            item.button.titleLabel.textColor = [UIColor grayColor];
        }
    }
}


- (void)refreshListTag:(NSInteger)tag filtrateItem:(SQFiltrateItem *)filtrateItem{
    if ([filtrateItem.choseSet containsObject:@(tag)]) {
        [filtrateItem.choseSet removeObject:@(tag)];
    }else{
        if (filtrateItem.numberType == OptionNumberType_Single) {
            //单选
            [filtrateItem.choseSet removeAllObjects];
            [filtrateItem.choseSet addObject:@(tag)];
        }else{
            //多选
            [filtrateItem.choseSet addObject:@(tag)];
        }
    }
    for (NSInteger i=0; i<filtrateItem.listCellViews.count; i++) {
        
        if ([filtrateItem.listCellViews[i] isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)filtrateItem.listCellViews[i];
            [button setTitleColor:[filtrateItem.choseSet containsObject:@(i)]?[UIColor redColor]:[UIColor grayColor] forState:0];
            button.layer.borderColor = ([filtrateItem.choseSet containsObject:@(i)]?[UIColor redColor]:[UIColor grayColor]).CGColor;
            filtrateItem.button.titleLabel.text = filtrateItem.optionData[tag];
        }
        
        if ([filtrateItem.listCellViews[i] isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)filtrateItem.listCellViews[i];
            [label setTextColor:([filtrateItem.choseSet containsObject:@(i)]?[UIColor redColor]:[UIColor grayColor])];
            filtrateItem.button.titleLabel.text = filtrateItem.optionData[tag];
        }
    }
    
    if (!filtrateItem.choseSet.count) {
        filtrateItem.button.titleLabel.text = filtrateItem.title;
    }
    
    if (self.touchBlock) {
        self.touchBlock(self, filtrateItem);
    }
    
    if (filtrateItem.numberType == OptionNumberType_Single) {
        [self hideAllItemView];
    }
    
}

- (void)setFiltrateItems:(NSArray *)filtrateItems{
    _filtrateItems = filtrateItems;
    [self setViews];
    
}

- (void)touchBlock:(void (^)(SQFiltrateView *, SQFiltrateItem *))block{
    self.touchBlock = block;
}
- (void)bg_button_Action:(UIButton *)button{
    [self hideAllItemView];
}
- (void)select_button_action:(UIButton *)button{
    SQFiltrateItem *item = self.filtrateItems[self.select_itemIndex];
    [self refreshListTag:button.tag filtrateItem:item];
}
- (void)labelTap:(UITapGestureRecognizer *)tap{
    SQFiltrateItem *item = self.filtrateItems[self.select_itemIndex];
    [self refreshListTag:tap.view.tag filtrateItem:item];

}
@end
