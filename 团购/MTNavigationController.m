//
//  MTNavigationController.m
//  
//
//  Created by Alex on 15/10/3.
//
//

#import "MTNavigationController.h"
#import "UIBarButtonItem+Extension.h"


@interface MTNavigationController ()

@end

@implementation MTNavigationController

+(void)initialize //类方法
{
    UINavigationBar *bar = [UINavigationBar appearance];
    //得到导航条
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
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
