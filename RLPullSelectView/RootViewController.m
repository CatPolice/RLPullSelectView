//
//  RootViewController.m
//  RLPullSelectView
//
//  Created by runlin on 16/12/6.
//  Copyright © 2016年 unis. All rights reserved.
//

#import "RootViewController.h"
#import "RLPullSelectView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showButtonAction:(UIButton *)sender {
    RLPullSelectView *pullView = [[RLPullSelectView alloc] initWithFrame:CGRectMake(0, 131+54, 375, 200)];
    [self.view addSubview:pullView];
    
    
    [pullView setItems:[[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@""]]];
}


@end
