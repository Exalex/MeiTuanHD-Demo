//
//  MTNavigationController.m
//  美团HD
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "MTNavigationController.h"
#import "MTConst.h"

@interface MTNavigationController ()

@end

@implementation MTNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : MTColor(21, 188, 173)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
