//
//  AddFilterToLayerController.m
//  CIFilter Test
//
//  Created by Kiven Wang on 14-7-23.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "AddFilterToLayerController.h"



@implementation FilterView

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testImage"]];
        [self.layer addSublayer:imageView.layer];
        
        CIFilter *blurFilter = [CIFilter filterWithName:@"CICircleSplashDistortion"];
        [blurFilter setDefaults];
        [blurFilter setValue:[CIVector vectorWithX:0 Y:0] forKeyPath:@"inputCenter"];
        [blurFilter setValue:[NSNumber numberWithFloat:25] forKey:@"inputRadius"];
        [self.layer setFilters:[NSArray arrayWithObject:blurFilter]];
    }
    return self;
}


@end

@implementation FilterLayer

- (void) drawInContext:(CGContextRef)ctx
{
    [[UIImage imageNamed:@"testImage"] drawAtPoint:CGPointZero];
}

@end


@interface AddFilterToLayerController ()

@end

@implementation AddFilterToLayerController

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
    
    
    CIFilter *blurFilter = [CIFilter filterWithName:@"CICircleSplashDistortion"];
    [blurFilter setDefaults];
    [blurFilter setValue:[NSNumber numberWithFloat:130] forKey:@"inputRadius"];
    [_imageView.layer setFilters:[NSArray arrayWithObject:blurFilter]];
    
//    UITextField
//    UITextView
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximitySensorChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];//
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;//开启距离感应
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;//不自动锁屏
}
- (void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];//
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;//
    [UIApplication sharedApplication].idleTimerDisabled = NO;//自动锁屏
}
//状态变化后调用的函数
-(void)proximitySensorChange:(NSNotificationCenter *)notification;
{
    if ([[UIDevice currentDevice] proximityState] == YES) {
        NSLog(@"Device is close to user");
        //在此写接近时，要做的操作逻辑代码
    }else{
        NSLog(@"Device is not close to user");
    }
}

@end
