//
//  AboutUsController.m
//  POPGame
//
//  Created by Kiven Wang on 14-7-12.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "AboutUsController.h"
#import "cocos2d.h"

#import <StoreKit/StoreKit.h>

@interface AboutUsController ()<SKStoreProductViewControllerDelegate>

@end

@implementation AboutUsController

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
    // Do any additional setup after loading the view from its nib.
    
    
    
    
}

- (IBAction) backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) updateBtnACtion:(id)sender
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
