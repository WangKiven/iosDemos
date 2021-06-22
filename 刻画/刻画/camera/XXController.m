//
//  XXController.m
//  刻画
//
//  Created by Kiven Wang on 14-3-26.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "XXController.h"

@interface XXController ()

@end

@implementation XXController

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
    
    //相机、蒙版
    stillCamera = [[GPUImageStillCamera alloc] init];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    filter = [[GPUImageSketchFilter alloc] init];
    [stillCamera addTarget:filter];
    
    GPUImageView *filterView = (GPUImageView *)self.view;
    filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    
    [filter addTarget:filterView];
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [stillCamera startCameraCapture];
    //    [stillCamera resumeCameraCapture];
    
    
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [stillCamera stopCameraCapture];
    //    [stillCamera pauseCameraCapture];
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)xxxxxx:(id)sender {
    
    [stillCamera capturePhotoAsPNGProcessedUpToFilter:filter withCompletionHandler:^(NSData *processedPNG, NSError *error) {
        UIImage *image = [UIImage imageWithData:processedPNG];
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }];
    
    
}

- (void) image:(UIImage *)image didFinishSavingWithError:(NSError *) error contextInfo:(void *) contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存图片失败,请确定已允许本软件访问相册。查看路径“设置 -> 隐私 -> 照片”" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }else{
        
    }
}

@end
