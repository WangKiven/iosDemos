//
//  AppDelegate.m
//  刻画
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UIButton+DrawType.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@ %g %@",getDeviceName(),getDeviceVersion(),NSStringFromCGSize(getScreenSize()));
    
    
//    [application setStatusBarHidden:NO];
    
//    [Frontia initWithApiKey:BAIDUID];
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    naviCtr = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    self.window.rootViewController = naviCtr;
    
    
    [self.window makeKeyAndVisible];
    
    //处理数据
    [self loadData];
    
    return YES;
}

- (void) loadData
{
    // 设置 导航栏背景。
//    UIColor *naviColor = [UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1];
//    // ios 7
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//        
//        [[UINavigationBar appearance] setBackgroundImage:[UIImage ImageWithColor:naviColor Rect:CGSizeMake(320, 64)] forBarMetrics:UIBarMetricsDefault];
//    }
//    else // ios 6
//    {
//        [[UINavigationBar appearance] setBackgroundImage:[UIImage ImageWithColor:naviColor Rect:CGSizeMake(320, 44)] forBarMetrics:UIBarMetricsDefault];
//        [[UINavigationBar appearance] setBackgroundColor:naviColor];
//        
//    }
    
    naviCtr.navigationBar.tintColor = [BackgroundData naviBarBgColor];
    naviCtr.navigationBar.backgroundColor = [BackgroundData naviBarBgColor];
    [WButton SetButtonColor:[BackgroundData naviBarTextColor]];
    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, [UIFont boldSystemFontOfSize:18], UITextAttributeFont, nil] forState:UIControlStateNormal];
    
    
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    FrontiaShare *share = [Frontia getShare];
//    return [share handleOpenURL:url];
//}

- (void) applicationWillEnterForeground:(UIApplication *)application
{
    NSArray *ctrs = naviCtr.viewControllers;
    if (ctrs.count < 1) {
        return;
    }
    
    UIViewController *ctr = [ctrs objectAtIndex:0];
    
    [ctr viewWillAppear:YES];
}

@end
