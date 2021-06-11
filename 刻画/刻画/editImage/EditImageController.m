//
//  EditImageController.m
//  刻画
//
//  Created by Kiven Wang on 14-3-24.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "EditImageController.h"
#import "GPUImage.h"
#import "VariableThumbView.h"

#define CellIden @"VariableThumbView"

@interface EditImageController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    IBOutlet UICollectionView *collectionView;
    
    
    
    NSArray *filterAr;//存储滤镜
    
    
    CGPoint startPoint;//开始点
}

@end

@implementation EditImageController

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
    
    self.imageView.image = self.image;
    
    
    filterAr = @[[[GPUImageFilter alloc] init], [[GPUImageEmbossFilter alloc] init], [[GPUImageColorPackingFilter alloc] init], [[GPUImageSketchFilter alloc] init], [[GPUImagePinchDistortionFilter alloc] init], [[GPUImageBulgeDistortionFilter alloc] init], [[GPUImageStretchDistortionFilter alloc] init], [[GPUImageSwirlFilter alloc] init], [[GPUImagePolarPixellateFilter alloc] init], [[GPUImageGlassSphereFilter alloc] init], [[GPUImageSphereRefractionFilter alloc] init], [[GPUImagePolkaDotFilter alloc] init], [[GPUImagePixellateFilter alloc] init]];
    
    
    
    
//    [collectionView registerClass:[VariableThumbView class] forCellWithReuseIdentifier:CellIden];
    
    [collectionView registerNib:[UINib nibWithNibName:@"VariableThumbView" bundle:nil] forCellWithReuseIdentifier:CellIden];
    
    collectionView.allowsSelection = YES;
    
    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //调整界面风格
    
    self.view.backgroundColor = [BackgroundData bgColor];
}
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
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
//        [collectionView beginFadeAnimation];
//        
//        collectionView.hidden = !collectionView.hidden;
    }
    
    startPoint = CGPointZero;
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    startPoint = CGPointZero;
}

#pragma mark - Action
- (IBAction)toExitAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)rotateImageAction:(id)sender {
    
    UIImage *image = self.image;
    
    self.image = [image imageRotation:UIImageOrientationRight];
    
    [self.imageView beginFadeAnimation];
    self.imageView.image = self.image;
}
- (IBAction)clipImageAction:(id)sender {
    
    UIImage *image = [self.imageView skipImage];
    
    
    CGFloat with;
    CGFloat height;
    
    CGSize selfSize = getScreenSize();
    
    with = selfSize.width * self.variableView.visiScale;
    height = selfSize.height * self.variableView.visiScale;
    
    CGPoint center = self.variableView.visiCenter;
    
    CGRect rect;
    
    
    //支持retina高分的关键
//    if(UIGraphicsBeginImageContextWithOptions != NULL)
//    {
//        rect = CGRectMake(center.x * 2 - with, center.y * 2 - height, with * 2, height * 2);
//    } else {
//        rect = CGRectMake(center.x - with / 2, center.y - height / 2, with, height);
//    }
    if ([UIDevice currentResolution] == UIDevice_iPhoneStandardRes || [UIDevice currentResolution] == UIDevice_iPadStandardRes) {
        rect = CGRectMake(center.x - with / 2, center.y - height / 2, with, height);
    }else{
        rect = CGRectMake(center.x * 2 - with, center.y * 2 - height, with * 2, height * 2);
    }
    
    
    NSLog(@"%@",NSStringFromCGRect(rect));
    
    
    image = [image CliperWithRect:rect];
    
    if (_delegate && [_delegate respondsToSelector:@selector(editImageFinshWith:)]) {
       [_delegate editImageFinshWith:image];
    }
    
    if (!_isStandard) {
        ToShareOrSaveImage(image, self.view);
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)pinchGestureAction:(id)sender {
    
    UIPinchGestureRecognizer *pinch = sender;
    
    self.variableView.visiScale = pinch.scale;
    
    pinch.scale = 1;
}
- (IBAction)panGestureAction:(id)sender {
    
    UIPanGestureRecognizer *pan = sender;
    
    CGPoint point = [pan translationInView:self.variableView];
    
    CGPoint vPoint = self.variableView.visiCenter;
    
    vPoint.x += point.x;
    vPoint.y += point.y;
    
    self.variableView.visiCenter = vPoint;
    
    [pan setTranslation:CGPointZero inView:self.variableView];
}

#pragma mark - dataSource/delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *) collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VariableThumbView *cell = [collectionView1 dequeueReusableCellWithReuseIdentifier:CellIden forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 8;
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView1 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    collectionView.hidden = YES;
}



@end
