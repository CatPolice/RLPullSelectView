//
//  RLPullSelectView.m
//  RLPullSelectView
//
//  Created by runlin on 16/12/6.
//  Copyright © 2016年 unis. All rights reserved.
//

#import "RLPullSelectView.h"

#define MAIN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define MAIN_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define PULLVIEW_BUTTONVIEWBG_HEIGHT 39
#define PULLTABLEVIEW_CELL_HEIGHT 44

@implementation RLPullSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //headview
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, PULLVIEW_BUTTONVIEWBG_HEIGHT)];
        buttonView.backgroundColor = [UIColor yellowColor];
        self.frame = CGRectMake(0, frame.origin.y, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - frame.origin.y);
        
        //create button
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH/3, PULLVIEW_BUTTONVIEWBG_HEIGHT)];
        [button1 setTitle:@"button1" forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"button_1_no"] forState:UIControlStateNormal];
        button1.adjustsImageWhenHighlighted = NO;
        [buttonView addSubview:button1];
        button1.backgroundColor = [UIColor grayColor];
        [button1 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchDown];
        
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH/3, 0, MAIN_SCREEN_WIDTH/3, PULLVIEW_BUTTONVIEWBG_HEIGHT)];
        [button2 setTitle:@"button2" forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"button_2_no"] forState:UIControlStateNormal];
        button2.adjustsImageWhenHighlighted = NO;
        [buttonView addSubview:button2];
        button2.backgroundColor = [UIColor darkGrayColor];
        [button2 addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchDown];
        
        UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH/3*2, 0, MAIN_SCREEN_WIDTH/3, PULLVIEW_BUTTONVIEWBG_HEIGHT)];
        [button3 setTitle:@"button3" forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"button_3_no"] forState:UIControlStateNormal];
        button3.adjustsImageWhenHighlighted = NO;
        [buttonView addSubview:button3];
        button3.backgroundColor = [UIColor blueColor];
        [button3 addTarget:self action:@selector(button3:) forControlEvents:UIControlEventTouchDown];
        
        
        
        //pullview
        _pullView = [[UIView alloc] initWithFrame:CGRectZero];
        _pullView.backgroundColor = [UIColor redColor];
        
        //tableview
        _pullTableview = [[UITableView alloc] initWithFrame:CGRectZero];
        _pullTableview.delegate = self;
        _pullTableview.dataSource = self;
        
        //viewbg
        _viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - self.frame.origin.y)];
        _viewBG.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        //addsubview
        [_pullView addSubview:_pullTableview];
        [self addSubview:_viewBG];
        [_viewBG addSubview:buttonView];
        [_viewBG addSubview:_pullView];
        
        
        self.backgroundColor = [UIColor clearColor];
        
        [self showAnimationPopView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self setNeedsDisplay];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:_pullView];
    CGPoint viewBGtouchPoint = [touch locationInView:_viewBG];

    if (![_pullView pointInside:touchPoint withEvent:event] && [_viewBG pointInside:viewBGtouchPoint withEvent:event]) {
        
//        [self removeFromSuperview];
        [self hidenAnimationPopView];
    }
}

/**
 *
 */
- (void)setItems:(NSMutableArray *)items{
    _items = items;
    [self showAnimationPopView];
}

- (void)button1:(UIButton *)button{
    button.selected = !button.selected;
    [button setImage:[UIImage imageNamed:@"button_1_select"] forState:UIControlStateSelected];
    _items = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    [self showAnimationPopView];
}
- (void)button2:(UIButton *)button{
    button.selected = !button.selected;
    [button setImage:[UIImage imageNamed:@"button_2_select"] forState:UIControlStateSelected];
    _items = [[NSMutableArray alloc] initWithArray:@[@""]];
    [self showAnimationPopView];
}
- (void)button3:(UIButton *)button{
    button.selected = !button.selected;
    [button setImage:[UIImage imageNamed:@"button_3_select"] forState:UIControlStateSelected];
    _items = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@""]];
    [self showAnimationPopView];
}


#pragma mark -
#pragma -mark TableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _pullTableview) {
        static NSString *RLPullSelectViewCell = @"RLPullSelectViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RLPullSelectViewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RLPullSelectViewCell];
        }
        
        cell.textLabel.text = @"11111";
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        return cell;
    }
    
    return nil;
}


//show 动画
- (void)showAnimationPopView{
    
    _pullView.frame = CGRectMake(0,PULLVIEW_BUTTONVIEWBG_HEIGHT,MAIN_SCREEN_WIDTH,0);
    _pullTableview.frame = _pullView.bounds;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _pullView.frame = CGRectMake(0,PULLVIEW_BUTTONVIEWBG_HEIGHT,MAIN_SCREEN_WIDTH,PULLTABLEVIEW_CELL_HEIGHT*_items.count);
        _pullTableview.frame = _pullView.bounds;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [_pullTableview reloadData];
        }
    }];
}

- (void)hidenAnimationPopView{
    [UIView animateWithDuration:0.1 animations:^{
        
        _pullView.frame = CGRectMake(0,PULLVIEW_BUTTONVIEWBG_HEIGHT,MAIN_SCREEN_WIDTH,0);
        _pullTableview.frame = _pullView.bounds;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            [self removeFromSuperview];
        }
        
    }];
}


- (void)animationPushDown:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.15f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    
    [view.layer addAnimation:animation forKey:nil];
}


@end
