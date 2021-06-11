//
//  PsImageController.m
//  刻画
//
//  Created by Kiven Wang on 14-3-31.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "PsImageController.h"
#import "GPUImage.h"
#import "CammraCell.h"


#define CellIden @"cammraCell"

@interface PsImageController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    IBOutlet UICollectionView *collectionView;
    
    
    
    NSArray *filterAr;//存储滤镜
    NSArray *filterAr2;
    GPUImageFilter *filter;//当前滤镜
    
    
    CGPoint startPoint;//开始点
    
    
    ShareOrSaveImage *sos;
    
    GPUImageView *gpuView;
    GPUImagePicture *picture;
}

@end

@implementation PsImageController

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
    gpuView = (GPUImageView *) self.view;
    
    GPUImagePinchDistortionFilter *pinchDistortionFilter = [[GPUImagePinchDistortionFilter alloc] init];
    pinchDistortionFilter.radius = 0.3;
    pinchDistortionFilter.scale = 0.15;
    //, [[GPUImageColorPackingFilter alloc] init]
    filterAr = @[[[GPUImageFilter alloc] init], [[GPUImageEmbossFilter alloc] init], [[GPUImageSketchFilter alloc] init], pinchDistortionFilter, [[GPUImageBulgeDistortionFilter alloc] init], [[GPUImageStretchDistortionFilter alloc] init], [[GPUImageSwirlFilter alloc] init], [[GPUImagePolarPixellateFilter alloc] init], [[GPUImageGlassSphereFilter alloc] init], [[GPUImageSphereRefractionFilter alloc] init], [[GPUImagePolkaDotFilter alloc] init], [[GPUImagePixellateFilter alloc] init]];
    
    NSMutableArray *mAr = [NSMutableArray arrayWithArray:filterAr];
    //颜色调整
//    [mAr addObject:[[GPUImageBrightnessFilter alloc] init]];
//    [mAr addObject:[[GPUImageExposureFilter alloc] init]];
//    [mAr addObject:[[GPUImageContrastFilter alloc] init]];
//    [mAr addObject:[[GPUImageSaturationFilter alloc] init]];
//    [mAr addObject:[[GPUImageGammaFilter alloc] init]];
//    [mAr addObject:[[GPUImageColorInvertFilter alloc] init]];
//    [mAr addObject:[[GPUImageSepiaFilter alloc] init]];
//    [mAr addObject:[[GPUImageLevelsFilter alloc] init]];
//    [mAr addObject:[[GPUImageGrayscaleFilter alloc] init]];
//    [mAr addObject:[[GPUImageHistogramGenerator alloc] init]];
//    [mAr addObject:[[GPUImageRGBFilter alloc] init]];
//    [mAr addObject:[[GPUImageToneCurveFilter alloc] init]];
//    [mAr addObject:[[GPUImageMonochromeFilter alloc] init]];
//    [mAr addObject:[[GPUImageOpacityFilter alloc] init]];
//    [mAr addObject:[[GPUImageHighlightShadowFilter alloc] init]];
//    [mAr addObject:[[GPUImageFalseColorFilter alloc] init]];
//    [mAr addObject:[[GPUImageHueFilter alloc] init]];
//    [mAr addObject:[[GPUImageChromaKeyFilter alloc] init]];
//    [mAr addObject:[[GPUImageWhiteBalanceFilter alloc] init]];
//    [mAr addObject:[[GPUImageAverageLuminanceThresholdFilter alloc] init]];
    
    
    //    [mAr addObject:[[GPUImageHistogramFilter alloc] init]];
    //    [mAr addObject:[[GPUImageAverageColor alloc] init]];
    //    [mAr addObject:[[GPUImageSolidColorGenerator alloc] init]];
    //    [mAr addObject:[[GPUImageLuminosity alloc] init]];
    //    [mAr addObject:[[GPUImageLookupFilter alloc] init]];
    //    [mAr addObject:[[GPUImageAmatorkaFilter alloc] init]];
    //    [mAr addObject:[[GPUImageMissEtikateFilter alloc] init]];
    //    [mAr addObject:[[GPUImageSoftEleganceFilter alloc] init]];
    
    //图想处理
//    [mAr addObject:[[GPUImageTransformFilter alloc] init]];
//    [mAr addObject:[[GPUImageCropFilter alloc] init]];
//    [mAr addObject:[[GPUImageSharpenFilter alloc] init]];
//    [mAr addObject:[[GPUImageGaussianBlurFilter alloc] init]];
//    [mAr addObject:[[GPUImageBoxBlurFilter alloc] init]];
//    [mAr addObject:[[GPUImageFalseColorFilter alloc] init]];
//    [mAr addObject:[[GPUImageMedianFilter alloc] init]];
//    [mAr addObject:[[GPUImageRGBErosionFilter alloc] init]];
//    [mAr addObject:[[GPUImageDilationFilter alloc] init]];
//    [mAr addObject:[[GPUImageRGBDilationFilter alloc] init]];
//    [mAr addObject:[[GPUImageOpeningFilter alloc] init]];
//    [mAr addObject:[[GPUImageRGBOpeningFilter alloc] init]];
//    [mAr addObject:[[GPUImageClosingFilter alloc] init]];
//    [mAr addObject:[[GPUImageRGBClosingFilter alloc] init]];
//    [mAr addObject:[[GPUImageLanczosResamplingFilter alloc] init]];
//    [mAr addObject:[[GPUImageNonMaximumSuppressionFilter alloc] init]];
//    [mAr addObject:[[GPUImageThresholdedNonMaximumSuppressionFilter alloc] init]];
//    [mAr addObject:[[GPUImageSobelEdgeDetectionFilter alloc] init]];
//    [mAr addObject:[[GPUImageCannyEdgeDetectionFilter alloc] init]];
//    [mAr addObject:[[GPUImageThresholdEdgeDetectionFilter alloc] init]];
//    [mAr addObject:[[GPUImagePrewittEdgeDetectionFilter alloc] init]];
//    [mAr addObject:[[GPUImageXYDerivativeFilter alloc] init]];
//    [mAr addObject:[[GPUImageHarrisCornerDetectionFilter alloc] init]];
//    [mAr addObject:[[GPUImageNobleCornerDetectionFilter alloc] init]];
//    [mAr addObject:[[GPUImageShiTomasiFeatureDetectionFilter alloc] init]];
//    [mAr addObject:[[GPUImageMotionDetector alloc] init]];
//    [mAr addObject:[[GPUImageHoughTransformLineDetector alloc] init]];
//    [mAr addObject:[[GPUImageLocalBinaryPatternFilter alloc] init]];
//    [mAr addObject:[[GPUImageLowPassFilter alloc] init]];
//    [mAr addObject:[[GPUImageHighPassFilter alloc] init]];
    
    
    //    [mAr addObject:[[GPUImageUnsharpMaskFilter alloc] init]];
    //    [mAr addObject:[[GPUImageGaussianSelectiveBlurFilter alloc] init]];
    //    [mAr addObject:[[GPUImageTiltShiftFilter alloc] init]];
    //    [mAr addObject:[[GPUImageBilateralFilter alloc] init]];
    //    [mAr addObject:[[GPUImageErosionFilter alloc] init]];
    //    [mAr addObject:[[GPUImageParallelCoordinateLineTransformFilter alloc] init]];
    //    [mAr addObject:[[GPUImageCrosshairGenerator alloc] init]];
    //    [mAr addObject:[[GPUImageLineGenerator alloc] init]];
    
    
    //视觉效果
    
    
    
    //混合模式
    
    
    filterAr = [NSArray arrayWithArray:mAr];
    filter = [filterAr objectAtIndex:0];
    
    picture = [[GPUImagePicture alloc] initWithImage:self.image];
    
    [picture addTarget:filter];
    [filter addTarget:gpuView];
    [picture processImage];
    
    filterAr2 = [NSArray arrayWithArray:filterAr];
    
    
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIden];
    
    [collectionView registerNib:[UINib nibWithNibName:@"CammraCell" bundle:nil] forCellWithReuseIdentifier:CellIden];
    
    collectionView.allowsSelection = YES;
    
    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //调整界面风格[UIColor colorWithRed:0.57 green:0.78 blue:0.53 alpha:1]
    UIColor *color= [BackgroundData bgColor];
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    [gpuView setBackgroundColorRed:components[0] green:components[1] blue:components[2] alpha:components[3]];
}
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
#pragma mark - Action
- (IBAction)toExitAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)okAction:(id)sender
{
    UIImage *image = [filter imageByFilteringImage:self.image];
    
//    UIImage *image =
    
    if (_delegate && [_delegate respondsToSelector:@selector(psImageFinshWith:)]) {
        [_delegate psImageFinshWith:image];
    }
    
    if (!_isStandard) {
        ToShareOrSaveImage(image, self.view);
        

    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark - 手势

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self.view];
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint frontPoint = [touch previousLocationInView:self.view];
    
    if (CGPointEqualToPoint(startPoint, frontPoint)) {
        [collectionView beginFadeAnimation];
        
        collectionView.hidden = !collectionView.hidden;
    }
    
    startPoint = CGPointZero;
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    startPoint = CGPointZero;
}
#pragma mark - 手势
- (IBAction)pinchAction:(UIPinchGestureRecognizer *)sender {
    NSArray *paths = [collectionView indexPathsForSelectedItems];
    
    if (paths.count < 1) {
        
        return ;
    }
    
    NSIndexPath *path = [paths objectAtIndex:0];
    
    
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
            GPUImagePinchDistortionFilter *distortionFilter = [filterAr objectAtIndex:path.row];
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
            
            [picture processImage];
        }
            break;
        case 4:
        {
            GPUImageBulgeDistortionFilter *bulgeDistortionFilter = [filterAr objectAtIndex:path.row];
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
            
            
            [picture processImage];
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            GPUImageSwirlFilter *swirlFilter = [filterAr objectAtIndex:path.row];
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
            
            [picture processImage];
        }
            break;
        case 7:
        {
            GPUImagePolarPixellateFilter *polarPixellateFilter = [filterAr objectAtIndex:path.row];
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
            
            [picture processImage];
        }
            break;
        case 8:
        case 9:
        {
            GPUImageSphereRefractionFilter *sphereRefractionFilter = [filterAr objectAtIndex:path.row];
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
            
            [picture processImage];
        }
            break;
        case 10:
        {
            
        }
            //            break;
        case 11:
        {
            GPUImagePixellateFilter *pixellateFilter = [filterAr objectAtIndex:path.row];
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
            
            [picture processImage];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)panAction:(UIPanGestureRecognizer *)sender {
    NSArray *paths = [collectionView indexPathsForSelectedItems];
    
    if (paths.count < 1) {
        
        return ;
    }
    
    NSIndexPath *path = [paths objectAtIndex:0];
    
    
    
    CGPoint tPoint = [sender translationInView:self.view];
    
    [sender setTranslation:CGPointZero inView:self.view];
    
    
    
    
    switch (path.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            GPUImageEmbossFilter *embossFilter = [filterAr objectAtIndex:path.row];
            
            CGFloat intensity = embossFilter.intensity;
            
            if (tPoint.x < 0) {
                
                intensity -= 0.01;
            }else{
                
                intensity += 0.01;
            }
            if (intensity < 0) {
                intensity = 0;
            }else if(intensity > 1){
                intensity = 1;
            }
            NSLog(@"%g",intensity);
            embossFilter.intensity = intensity;
            [picture processImage];
        }
            break;
//        case 2:
//        {
//            
//        }
            break;
        case 2:
        {
            GPUImageSketchFilter *sketchFilter = [filterAr objectAtIndex:path.row];
            
            CGFloat edgeStrength = sketchFilter.edgeStrength;
            
            if (tPoint.x < 0) {
                
                edgeStrength -= 0.01;
            }else{
                
                edgeStrength += 0.01;
            }
            if (edgeStrength < 0.05) {
                edgeStrength = 0.05;
            }else if(edgeStrength > 1){
                edgeStrength = 1;
            }
            NSLog(@"%g",edgeStrength);
            
            sketchFilter.edgeStrength = edgeStrength;
            [picture processImage];
        }
            break;
        case 3:
        {
            GPUImagePinchDistortionFilter *distortionFilter = [filterAr objectAtIndex:path.row];
            
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
            
            
            [picture processImage];
        }
            break;
        case 4:
        {
            GPUImageBulgeDistortionFilter *bulgeDistortionFilter = [filterAr objectAtIndex:path.row];
            
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
            
            
            [picture processImage];
        }
            break;
        case 5:
        {
            GPUImageStretchDistortionFilter *stretchDistortionFilter = [filterAr objectAtIndex:path.row];
            
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
            
            
            [picture processImage];
        }
            break;
        case 6:
        {
            GPUImageSwirlFilter *swirlFilter = [filterAr objectAtIndex:path.row];
            
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
            
            
            [picture processImage];
        }
            break;
        case 7:
        {
            GPUImagePolarPixellateFilter *polarPixellateFilter = [filterAr objectAtIndex:path.row];
            
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
            
            
            [picture processImage];
        }
            break;
        case 8:
        case 9:
        {
            GPUImageSphereRefractionFilter *sphereRefractionFilter = [filterAr objectAtIndex:path.row];
            
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
            
            
            [picture processImage];
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
            break;
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
    
    [picture removeAllTargets];
    [filter removeAllTargets];
    
    filter = [filterAr objectAtIndex:indexPath.row];
    
    [picture addTarget:filter];
    [filter addTarget:gpuView];
    
    [picture processImage];
    
    [collectionView beginFadeAnimation];
    
    collectionView.hidden = !collectionView.hidden;
}

@end
