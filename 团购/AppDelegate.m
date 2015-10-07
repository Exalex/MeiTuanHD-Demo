//
//  AppDelegate.m
//  团购
//
//  Created by Alex on 15/10/3.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "AppDelegate.h"
#import "MTHomeViewController.h"
#import "MTNavigationController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window =[[UIWindow alloc]init];//初始化窗口
    self.window.frame = [UIScreen mainScreen].bounds;//得到大小
    self.window.rootViewController = [[MTNavigationController alloc]initWithRootViewController:[[MTHomeViewController alloc]init]];//设置根控制器为以home为根控制器的导航器
                                      
    [self.window makeKeyAndVisible];//显示窗口
                                      
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  }

- (void)applicationDidEnterBackground:(UIApplication *)application {
    }

- (void)applicationWillEnterForeground:(UIApplication *)application {
   }

- (void)applicationDidBecomeActive:(UIApplication *)application {
    }

- (void)applicationWillTerminate:(UIApplication *)application {
   
}
@end
