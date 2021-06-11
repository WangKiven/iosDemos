//
//  CammraController.m
//  刻画
//
//  Created by Kiven Wang on 14-3-21.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "CammraController.h"
#import "NewController.h"
#import "CammraCell.h"
#import <AssetsLibrary/ALAssetsLibrary.h>

#define CellIden @"cammraCell"

@interface CammraController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    CGPoint startPoint;
    IBOutlet UIProgressView *progressView;
    
    
    //可改变的手势
    IBOutlet UIPanGestureRecognizer *pan;
    IBOutlet UIPinchGestureRecognizer *pinch;
    
    //button
    IBOutlet UIButton *rotateBtn;
    IBOutlet UIButton *flashBtn;
    IBOutlet UIButton *torchBtn;
    
    
    ALAssetsLibrary *library;
    
}

@end

@implementation CammraController

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
    
    
    GPUImagePinchDistortionFilter *pinchDistortionFilter = [[GPUImagePinchDistortionFilter alloc] init];
    pinchDistortionFilter.radius = 0.3;
    pinchDistortionFilter.scale = 0.15;
    
    // [[GPUImageColorPackingFilter alloc] init],
    filterAr = @[[[GPUImageFilter alloc] init], [[GPUImageEmbossFilter alloc] init], [[GPUImageSketchFilter alloc] init], pinchDistortionFilter, [[GPUImageBulgeDistortionFilter alloc] init], [[GPUImageStretchDistortionFilter alloc] init], [[GPUImageSwirlFilter alloc] init], [[GPUImagePolarPixellateFilter alloc] init], [[GPUImageGlassSphereFilter alloc] init], [[GPUImageSphereRefractionFilter alloc] init], [[GPUImagePolkaDotFilter alloc] init], [[GPUImagePixellateFilter alloc] init]];
    
    
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIden];
    
    [collectionView registerNib:[UINib nibWithNibName:@"CammraCell" bundle:nil] forCellWithReuseIdentifier:CellIden];
    
    collectionView.allowsSelection = YES;
    
    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
    //相机、蒙版
    stillCamera = [[GPUImageStillCamera alloc] init];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    filter = [[GPUImageFilter alloc] init];
    [stillCamera addTarget:filter];
    
    GPUImageView *filterView = (GPUImageView *)self.view;
    filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    
    [filter addTarget:filterView];
    
    
    //检测Camera,设置rotateBtn
    if ([GPUImageVideoCamera isBackFacingCameraPresent] && [GPUImageVideoCamera isFrontFacingCameraPresent]) {
        rotateBtn.hidden = NO;
    }else{
        rotateBtn.hidden = YES;
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //检测torch(电筒),设置torchBtn
    if ([stillCamera inputCamera].hasTorch) {
        torchBtn.hidden = NO;
        //设置灯光为自动
        [self changeTorchMode:AVCaptureTorchModeOff];
        [torchBtn setTitle:@"关" forState:UIControlStateNormal];
        [torchBtn setImage:[UIImage imageNamed:@"torchBtnOff"] forState:UIControlStateNormal];
    }else{
        torchBtn.hidden = YES;
    }
    //检测flash(闪光灯),设置flashBtn
    if ([stillCamera inputCamera].hasFlash) {
        flashBtn.hidden = NO;
        //设置闪光灯为自动
        [self changeFlashMode:AVCaptureFlashModeAuto];
        [flashBtn setTitle:@"自动" forState:UIControlStateNormal];
        [flashBtn setImage:[UIImage imageNamed:@"rotateBtn"] forState:UIControlStateNormal];
        
    }else{
        flashBtn.hidden = YES;
    }
    
    
    
    
    [stillCamera startCameraCapture];
//    [stillCamera resumeCameraCapture];
    
    [coverView beginFadeAnimation];
    coverView.hidden = YES;
    
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [stillCamera stopCameraCapture];
//    [stillCamera pauseCameraCapture];
    
    coverView.hidden = NO;
    [coverView beginFadeAnimation];
}
#pragma mark -手势调值

- (IBAction)panAction:(UIPanGestureRecognizer *) sender {
    NSArray *paths = [collectionView indexPathsForSelectedItems];
    
    if (paths.count < 1) {
        
        return ;
    }
    
    NSIndexPath *path = [paths objectAtIndex:0];
    
    NSArray *filters = stillCamera.targets;
    
    if (filters.count < 1) {
        
        return ;
    }
    
    
    CGPoint tPoint = [sender translationInView:self.view];
    
    [sender setTranslation:CGPointZero inView:self.view];
    
    
    
    
    switch (path.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
//        case 2:
//        {
//            
//        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            GPUImagePinchDistortionFilter *distortionFilter = [filters objectAtIndex:0];
            
            CGPoint center = distortionFilter.center;
            
            center.x += tPoint.x / getScreenSize().width;
            center.y += tPoint.y / getScreenSize().height;
            
//            if (center.x < 0) {
//                center.x = 0;
//            }else if(center.x > 1){
//                center.x = 1;
//            }
//            
//            if (center.y < 0) {
//                center.y = 0;
//            }else if(center.y > 1){
//                center.y = 1;
//            }
            
            
            distortionFilter.center = center;
        }
            break;
        case 4:
        {
            GPUImageBulgeDistortionFilter *bulgeDistortionFilter = [filters objectAtIndex:0];
            
            CGPoint center = bulgeDistortionFilter.center;
            
            center.x += tPoint.x / getScreenSize().width;
            center.y += tPoint.y / getScreenSize().height;
            
//            if (center.x < 0) {
//                center.x = 0;
//            }else if(center.x > 1){
//                center.x = 1;
//            }
//            
//            if (center.y < 0) {
//                center.y = 0;
//            }else if(center.y > 1){
//                center.y = 1;
//            }
            
            bulgeDistortionFilter.center = center;
        }
            break;
        case 5:
        {
            GPUImageStretchDistortionFilter *stretchDistortionFilter = [filters objectAtIndex:0];
            
            CGPoint center = stretchDistortionFilter.center;
            
            center.x += tPoint.x / getScreenSize().width;
            center.y += tPoint.y / getScreenSize().height;
            
//            if (center.x < 0) {
//                center.x = 0;
//            }else if(center.x > 1){
//                center.x = 1;
//            }
//            
//            if (center.y < 0) {
//                center.y = 0;
//            }else if(center.y > 1){
//                center.y = 1;
//            }
            
            stretchDistortionFilter.center = center;
        }
            break;
        case 6:
        {
            GPUImageSwirlFilter *swirlFilter = [filters objectAtIndex:0];
            
            CGPoint center = swirlFilter.center;
            
            center.x += tPoint.x / getScreenSize().width;
            center.y += tPoint.y / getScreenSize().height;
            
//            if (center.x < 0) {
//                center.x = 0;
//            }else if(center.x > 1){
//                center.x = 1;
//            }
//            
//            if (center.y < 0) {
//                center.y = 0;
//            }else if(center.y > 1){
//                center.y = 1;
//            }
            
            swirlFilter.center = center;
        }
            break;
        case 7:
        {
            GPUImagePolarPixellateFilter *polarPixellateFilter = [filters objectAtIndex:0];
            
            CGPoint center = polarPixellateFilter.center;
            
            center.x += tPoint.x / getScreenSize().width;
            center.y += tPoint.y / getScreenSize().height;
            
//            if (center.x < 0) {
//                center.x = 0;
//            }else if(center.x > 1){
//                center.x = 1;
//            }
//            
//            if (center.y < 0) {
//                center.y = 0;
//            }else if(center.y > 1){
//                center.y = 1;
//            }
            
            polarPixellateFilter.center = center;
        }
            break;
        case 8:
        case 9:
        {
            GPUImageSphereRefractionFilter *sphereRefractionFilter = [filters objectAtIndex:0];
            
            CGPoint center = sphereRefractionFilter.center;
            
            center.x += tPoint.x / getScreenSize().width;
            center.y += tPoint.y / getScreenSize().height;
            
//            if (center.x < 0) {
//                center.x = 0;
//            }else if(center.x > 1){
//                center.x = 1;
//            }
//            
//            if (center.y < 0) {
//                center.y = 0;
//            }else if(center.y > 1){
//                center.y = 1;
//            }
            
            sphereRefractionFilter.center = center;
        }
            break;
        case 10:
        {
            
        }
            break;
        case 11:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}
- (IBAction)pinchAction:(UIPinchGestureRecognizer *)sender {
    
    NSArray *paths = [collectionView indexPathsForSelectedItems];
    
    if (paths.count < 1) {
        
        return ;
    }
    
    NSIndexPath *path = [paths objectAtIndex:0];
    
    NSArray *filters = stillCamera.targets;
    
    if (filters.count < 1) {
        
        return ;
    }
    
    CGFloat scale = sender.scale;
    
    sender.scale = 1;
    
    
    switch (path.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
//        case 2:
//        {
//            
//        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            GPUImagePinchDistortionFilter *distortionFilter = [filters objectAtIndex:0];
            CGFloat radius = distortionFilter.radius;
            if (scale < 1) {
                
                radius -= 0.01;
            }else{
                
                radius += 0.01;
            }
            
            if (radius < 0.1) {
                radius = 0.1;
            }else if(radius > 2){
                radius = 2;
            }
            
            distortionFilter.radius = radius;
            NSLog(@"%g",radius);
        }
            break;
        case 4:
        {
            GPUImageBulgeDistortionFilter *bulgeDistortionFilter = [filters objectAtIndex:0];
            CGFloat radius = bulgeDistortionFilter.radius;
            if (scale < 1) {
                
                radius -= 0.005;
            }else{
                
                radius += 0.005;
            }
            
            if (radius < 0.1) {
                radius = 0.1;
            }else if(radius > 1){
                radius = 1;
            }
            
            bulgeDistortionFilter.radius = radius;
            NSLog(@"%g",radius);
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            GPUImageSwirlFilter *swirlFilter = [filters objectAtIndex:0];
            CGFloat radius = swirlFilter.radius;
            if (scale < 1) {
                
                radius -= 0.005;
            }else{
                
                radius += 0.005;
            }
            
            if (radius < 0.1) {
                radius = 0.1;
            }else if(radius > 1){
                radius = 1;
            }
            
            swirlFilter.radius = radius;
            NSLog(@"%g",radius);
        }
            break;
        case 7:
        {
            GPUImagePolarPixellateFilter *polarPixellateFilter = [filters objectAtIndex:0];
            CGSize pixelSize = polarPixellateFilter.pixelSize;
            CGFloat width = pixelSize.width;
            if (scale < 1) {
                
                width -= 0.005;
            }else{
                
                width += 0.005;
            }
            
            if (width < 0.001) {
                width = 0.001;
            }else if(width > 1){
                width = 1;
            }
            
            pixelSize.width = width;
            pixelSize.height = width;
            
            polarPixellateFilter.pixelSize = pixelSize;
            
            NSLog(@"%@",NSStringFromCGSize(pixelSize));
        }
            break;
        case 8:
        case 9:
        {
            GPUImageSphereRefractionFilter *sphereRefractionFilter = [filters objectAtIndex:0];
            CGFloat radius = sphereRefractionFilter.radius;
            if (scale < 1) {
                
                radius -= 0.005;
            }else{
                
                radius += 0.005;
            }
            
            if (radius < 0.1) {
                radius = 0.1;
            }else if(radius > 1){
                radius = 1;
            }
            
            sphereRefractionFilter.radius = radius;
            NSLog(@"%g",radius);
        }
            break;
        case 10:
        {
            
        }
//            break;
        case 11:
        {
            GPUImagePixellateFilter *pixellateFilter = [filters objectAtIndex:0];
            CGFloat fractionalWidthOfAPixel = pixellateFilter.fractionalWidthOfAPixel;
            if (scale < 1) {
                
                fractionalWidthOfAPixel -= 0.001;
            }else{
                
                fractionalWidthOfAPixel += 0.001;
            }
            
            if (fractionalWidthOfAPixel < 0.001) {
                fractionalWidthOfAPixel = 0.001;
            }else if(fractionalWidthOfAPixel > 0.1){
                fractionalWidthOfAPixel = 0.1;
            }
            
            pixellateFilter.fractionalWidthOfAPixel = fractionalWidthOfAPixel;
            NSLog(@"%g",fractionalWidthOfAPixel);
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - touch
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    startPoint = [touch locationInView:self.view];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:self.view];
    
    if (CGPointEqualToPoint(lastPoint, startPoint))
    {
        
        [collectionView beginFadeAnimation];
        
        collectionView.hidden = !collectionView.hidden;
        
    }
    
    
    startPoint = CGPointZero;
}

#pragma mark - Action
- (IBAction)changeFlash:(id)sender
{
    AVCaptureDevice *device = [stillCamera inputCamera];
    
    UIButton *button = (UIButton *)sender;
    
    if (device.flashMode == AVCaptureFlashModeAuto) {
        [self changeFlashMode:AVCaptureFlashModeOn];
        
        [button setTitle:@"开" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"rotateBtn"] forState:UIControlStateNormal];
    }else if(device.flashMode == AVCaptureFlashModeOn){
        [self changeFlashMode:AVCaptureFlashModeOff];
        
        [button setTitle:@"关" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"rotateBtnOff"] forState:UIControlStateNormal];
    }else{
        [self changeFlashMode:AVCaptureFlashModeAuto];
        
        [button setTitle:@"自动" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"rotateBtn"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)changeTorchAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    AVCaptureDevice *device = [stillCamera inputCamera];
    
    if (device.torchMode == AVCaptureTorchModeAuto) {
        [self changeTorchMode:AVCaptureTorchModeOn];
        
        [button setTitle:@"开" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"torchBtnOn"] forState:UIControlStateNormal];
    }else if(device.torchMode == AVCaptureTorchModeOn){
        [self changeTorchMode:AVCaptureTorchModeOff];
        
        [button setTitle:@"关" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"torchBtnOff"] forState:UIControlStateNormal];
    }else{
        [self changeTorchMode:AVCaptureTorchModeAuto];
        
        [button setTitle:@"自动" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"torchBtnOn"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)backToPhotoAlumAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)changeCameraDevice:(id)sender{
    [stillCamera rotateCamera];
}

- (IBAction) selectedImage:(id)sender
{
    
    if (thumbView.image) {
        
        NewController *newCtr = [[NewController alloc] init];
        
        newCtr.image = thumbView.image;
        
        [self.navigationController pushViewController:newCtr animated:YES];
    }
}
- (IBAction)changeValue:(id)sender {
    
    UIPanGestureRecognizer *pan1 = sender;
    
    CGPoint tPoint = [pan1 translationInView:self.view];
    NSLog(@"%g",progressView.progress);
    if (abs(tPoint.x) > abs(tPoint.y)) {
        
        [progressView setProgress:progressView.progress + tPoint.x / 320 animated:NO];
    }
    NSLog(@"%g",progressView.progress);
    
    [pan1 setTranslation:CGPointZero inView:self.view];
    
    
}

- (void) changeFilterView:(CGFloat) value
{
    
}

- (IBAction)takePhoto:(id)sender;
{
    UIButton *photoCaptureButton = sender;
    
    [photoCaptureButton setEnabled:NO];
    
    
    if (!library) {
        library = [[ALAssetsLibrary alloc] init];
    }
    
    [stillCamera capturePhotoAsPNGUIImageProcessedUpToFilter:filter withCompletionHandler:^(UIImage *processedPNG, NSError *error) {
        
//        UIImageWriteToSavedPhotosAlbum(processedPNG, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        
        [library saveImage:processedPNG toAlbum:@"PhotoEdit" completion:^(NSURL *assetURL, NSError *error) {
            if (_cammrablock) {
                _cammrablock(processedPNG);
            }
            
            thumbView.image = processedPNG;
        } failure:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存图片失败,请确定已允许本软件访问相册。查看路径“设置 -> 隐私 -> 照片”" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }];
    }];
    
    
    [photoCaptureButton setEnabled:YES];
}
/*
- (void) image:(UIImage *)image didFinishSavingWithError:(NSError *) error contextInfo:(void *) contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存图片失败,请确定已允许本软件访问相册。查看路径“设置 -> 隐私 -> 照片”" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }else{
        
        if (_cammrablock) {
            _cammrablock(image);
        }
        
        thumbView.image = image;
    }
}
 */

#pragma mark - 灯光 开、关

- (void) changeTorchMode:(AVCaptureTorchMode) torchMode
{
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *device = [stillCamera inputCamera];
    
    if ([device hasTorch]) {
        
        [device lockForConfiguration:nil];
        [device setTorchMode:torchMode];
        [device unlockForConfiguration];
    }
    
}
#pragma mark - 闪光灯 开、关

- (void) changeFlashMode:(AVCaptureFlashMode) flashMode
{
    
    AVCaptureDevice *device = [stillCamera inputCamera];
    if ([device hasFlash]) {
        
        [device lockForConfiguration:nil];
        [device setFlashMode:flashMode];
        [device unlockForConfiguration];
    }
}

#pragma mark - dataSource/delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return filterAr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *) collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CammraCell *cell = [collectionView1 dequeueReusableCellWithReuseIdentifier:CellIden forIndexPath:indexPath];
    
    cell.imageView.backgroundColor = [UIColor whiteColor];
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 8;
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    GPUImageOutput<GPUImageInput> *aFilter;
    
    
    switch (indexPath.row) {
        case 0:
        {
            aFilter = [[GPUImageFilter alloc] init];
        }
            break;
        case 1:
        {
            
            aFilter = [[GPUImageEmbossFilter alloc] init];
            
        }
            break;
//        case 2:
//        {
//            aFilter = [[GPUImageColorPackingFilter alloc] init];
//        }
//            break;
        case 2:
        {
            aFilter = [[GPUImageSketchFilter alloc] init];
        }
            break;
        case 3:
        {
            aFilter = [[GPUImagePinchDistortionFilter alloc] init];
        }
            break;
        case 4:
        {
            aFilter = [[GPUImageBulgeDistortionFilter alloc] init];
        }
            break;
        case 5:
        {
            aFilter = [[GPUImageStretchDistortionFilter alloc] init];
        }
            break;
        case 6:
        {
            aFilter = [[GPUImageSwirlFilter alloc] init];
        }
            break;
        case 7:
        {
            aFilter = [[GPUImagePolarPixellateFilter alloc] init];
        }
            break;
        case 8:
        {
            aFilter = [[GPUImageGlassSphereFilter alloc] init];
        }
            break;
        case 9:
        {
            aFilter = [[GPUImageSphereRefractionFilter alloc] init];
        }
            break;
        case 10:
        {
            aFilter = [[GPUImagePolkaDotFilter alloc] init];
        }
            break;
        case 11:
        {
            aFilter = [[GPUImagePixellateFilter alloc] init];
        }
            break;
            
        default:
            break;
    }
    
    if (aFilter) {
        cell.imageView.image = [aFilter imageByFilteringImage:[UIImage imageNamed:@"thumb"]];
    }
    
    
    
    
    
    return cell;
}



- (void) collectionView:(UICollectionView *)collectionView1 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    switch (indexPath.row) {
        case 0:
        {
            filter = [[GPUImageFilter alloc] init];
        }
            break;
        case 1:
        {
            
            filter = [[GPUImageEmbossFilter alloc] init];
            
        }
            break;
        case 2:
        {
            filter = [[GPUImageColorPackingFilter alloc] init];
        }
            break;
        case 3:
        {
            filter = [[GPUImageSketchFilter alloc] init];
        }
            break;
        case 4:
        {
            filter = [[GPUImagePinchDistortionFilter alloc] init];
        }
            break;
        case 5:
        {
            filter = [[GPUImageBulgeDistortionFilter alloc] init];
        }
            break;
        case 6:
        {
            filter = [[GPUImageStretchDistortionFilter alloc] init];
        }
            break;
        case 7:
        {
            filter = [[GPUImageSwirlFilter alloc] init];
        }
            break;
        case 8:
        {
            filter = [[GPUImagePolarPixellateFilter alloc] init];
        }
            break;
        case 9:
        {
            filter = [[GPUImageGlassSphereFilter alloc] init];
        }
            break;
        case 10:
        {
            filter = [[GPUImageSphereRefractionFilter alloc] init];
        }
            break;
        case 11:
        {
            filter = [[GPUImagePolkaDotFilter alloc] init];
        }
            break;
        case 12:
        {
            filter = [[GPUImagePixellateFilter alloc] init];
        }
            break;
            
        default:
            break;
    }
    */
    filter = [filterAr objectAtIndex:indexPath.row];
    
    if (filter) {
        [self addFilter:filter];
    }
    
    [collectionView beginFadeAnimation];
    collectionView.hidden = YES;
}

- (void) addFilter:(GPUImageOutput<GPUImageInput> *) theFilter
{
    
    [stillCamera removeAllTargets];
    [stillCamera addTarget:theFilter];
    
    
    GPUImageView *filterView = (GPUImageView *)self.view;
    
    [filter removeAllTargets];
    [theFilter addTarget:filterView];
    
}
@end
