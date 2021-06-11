//
//  IntroViewController.m
//  刻画
//
//  Created by Kiven Wang on 14-4-3.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()
{
    IBOutlet UIImageView *imageView;
    
    NSInteger number;
    
    
}

@end

@implementation IntroViewController

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
    
    
    self.images = @[[UIImage imageNamed:@"intro1"], [UIImage imageNamed:@"intro4"]];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    number = 0;
    [getWindow() beginFadeAnimation];
    imageView.image = [self.images objectAtIndex:number];
}

//- (void) showOfController:(UIViewController *)ctr InView:(UIView *)view
//{
//    [self.view beginFadeAnimation];
//    self.view.frame = CGRectMake(0, 0, getScreenSize().width, getScreenSize().height);
//    [view addSubview:self.view];
//    [ctr addChildViewController:self];
//}


- (IBAction) tapAction:(UITapGestureRecognizer *)sender {
    if (number + 1 >= self.images.count) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setFloat:getAppVersion() forKey:Version];
        
        [getWindow() beginFadeAnimation];
        [self.navigationController popViewControllerAnimated:NO];
        
    }else{
        number ++;
        [getWindow() beginFadeAnimation];
        imageView.image = [self.images objectAtIndex:number];
    }
    
}

- (IBAction) swapRightAction:(UISwipeGestureRecognizer *)sender {
    
    if (number > 0) {
        number --;
        
        [getWindow() beginFadeAnimation];
        imageView.image = [self.images objectAtIndex:number];
    }
}

- (IBAction) swapLeftAction:(UISwipeGestureRecognizer *)sender {
    
    [self tapAction:nil];
}
@end
