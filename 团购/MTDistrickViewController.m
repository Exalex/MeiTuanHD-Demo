//
//  MTDistrickViewController.m
//  
//
//  Created by Alex on 15/10/5.
//
//

#import "MTDistrickViewController.h"
#import "MTHomeDropdown.h"
#import "UIView+Extension.h"
#import "MTCityViewController.h"
#import "MTNavigationController.h"


@interface MTDistrickViewController ()

- (IBAction)changeCity:(id)sender;
@end

@implementation MTDistrickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *title = [self.view.subviews firstObject];
    
    MTHomeDropdown *dropDown = [MTHomeDropdown dropDown];
    dropDown.backgroundColor = [UIColor redColor];
    dropDown.y = title.height;
    [self.view addSubview:dropDown];
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

//切换城市的代码（弹出模态窗口）
- (IBAction)changeCity:(id)sender {
    MTCityViewController *city = [[MTCityViewController alloc]init];
    MTNavigationController *nav = [[UINavigationController alloc]initWithRootViewController:city];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
}
@end
