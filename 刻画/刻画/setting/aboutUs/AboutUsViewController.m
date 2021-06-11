//
//  AboutUsViewController.m
//  刻画
//
//  Created by Kiven Wang on 14-3-18.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "AboutUsViewController.h"
#import <StoreKit/StoreKit.h>

@interface AboutUsViewController ()<SKStoreProductViewControllerDelegate>
{
    
    NSMutableData *_data;
}

@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (getDeviceVersion() >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStyleBordered target:self action:@selector(getNewVersionInfo)];
    
    [self.navigationItem setRightBarButtonItem:rightBarItem];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}


#pragma mark - 检测更新

- (void) getNewVersionInfo
{
    SKStoreProductViewController *storeCtr = [[SKStoreProductViewController alloc] init];
    
    storeCtr.delegate = self;
    
    [storeCtr loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"843036474"} completionBlock:^(BOOL result, NSError *error) {
        
    }];
    
    [self presentViewController:storeCtr animated:YES completion:^{
        
    }];
}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
