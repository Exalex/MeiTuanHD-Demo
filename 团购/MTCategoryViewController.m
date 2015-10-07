//
//  MTCategoryViewController.m
//  
//
//  Created by Alex on 15/10/4.
//
//

#import "MTCategoryViewController.h"
#import "MTHomeDropdown.h"
#import "MTCategory.h"
#import "MJExtension.h"
#import "UIView+Extension.h"

@interface MTCategoryViewController ()

@end

@implementation MTCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //调用dropDown类方法获得dropDown的xib对象
    MTHomeDropdown *dropdown = [MTHomeDropdown dropDown];
   
    //取消自动缩放，popover出的view不随父视图缩放。
    dropdown.autoresizingMask = UIViewAutoresizingNone;
  
    
    //用第三方解析库从plist中加载分类数据(1.取路径 2.用数组接收数据。或直文件名读取)例如：NSArray *categories = [MTCategory objectArrayWithFilename:@"categories.plist"];
   
    dropdown.categories = [MTCategory objectArrayWithFilename:@"categories.plist"];;//直接把模型传给dropDown
    [self.view addSubview:dropdown];
    
    //设置控制器view在popover中的尺寸
    self.preferredContentSize = dropdown.size;
    
}


@end
