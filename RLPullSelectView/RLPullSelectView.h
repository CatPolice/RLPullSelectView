//
//  RLPullSelectView.h
//  RLPullSelectView
//
//  Created by runlin on 16/12/6.
//  Copyright © 2016年 unis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLPullSelectView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_viewBG;
    
    UIView *_pullView;
    
    CGRect _drawFrame;
    
    UITableView *_pullTableview;
}

- (instancetype)initWithFrame:(CGRect)frame;

@property (strong, nonatomic) IBOutlet RLPullSelectView *pullSelectView;
@property (nonatomic , copy)NSMutableArray *items;


@end
