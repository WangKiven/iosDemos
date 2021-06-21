//
//  ViewController.m
//  刻画
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import "ViewController.h"
#import "NewController.h"
#import "SettingController.h"
#import "CammraController.h"
#import "ViewCtrFooter.h"
#import "PsImageController.h"
#import "刻画-Swift.h"
#import "EditImageController.h"
#import "IntroViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>


#define cellIdentifier @"cellIdentifier"
#define FooterIdentifier @"footerIdentifier"

@interface ViewController ()
{
    UIImage *selectedImage;
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;



@property (nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) IBOutlet UIView *overlayView;

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    if (getDeviceVersion() >= 7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    
    [self.navigationController setNavigationBarHidden:YES];

    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"ViewCtrFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterIdentifier];
    
    _collectionView.allowsSelection = YES;
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger firstCtr = [defaults integerForKey:FirstCtr];
    
    
    //引导界面
    CGFloat curVersion = getAppVersion();
    CGFloat oldVersion = [defaults floatForKey:Version];
    
    if (curVersion > oldVersion) {
        IntroViewController *intro = [[IntroViewController alloc] init];
        
        [self.navigationController pushViewController:intro animated:NO];
    }else if (firstCtr == 0) {
//        [self toCameraAction:nil];
    }
    
}


- (void) viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    //调整界面风格
    
    self.view.backgroundColor = [BackgroundData bgColor];
    
    //访问相册
    if (self.assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    
    if (self.photos == nil) {
        _photos = [[NSMutableArray alloc] init];
    } else {
        [self.photos removeAllObjects];
    }
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error){
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"用户拒绝访问相册，请在设置中确认.";
                break;
            default:
                errorMessage = @"无法打开相册！";
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    };
    
    
    NSInteger photoNumber = 27;//读取相片数量
    if (isIPad()) {
        photoNumber = 95;
    }
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
        if ([group numberOfAssets] > 0)
        {
            
            
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *astop) {
                
                if (result) {
                    [self.photos addObject:result];
                }
                
                
                if (self.photos.count > photoNumber) {
                    *astop = YES;
                }
            }];
        }
        if (self.photos.count > photoNumber) {
            *stop = YES;
        }
        
        [_collectionView reloadData];
    };
//    ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos
    NSUInteger groupTypes = ALAssetsGroupSavedPhotos;
    [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
    
    
}

#pragma mark - 显示tatus bar ios7.0
- (BOOL)prefersStatusBarHidden {
    
    return NO;
}

#pragma mark - Action
- (IBAction)toCameraAction:(id)sender {
    
//    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    CammraController *cammra = [[CammraController alloc] init];
    
    cammra.cammrablock = ^(UIImage *image){
        
        
    };
    
    [self.navigationController pushViewController:cammra animated:YES];
    
}


- (IBAction)toNewAction:(id)sender {
    
    NewController *newCtr = [[NewController alloc] init];
    
    [self.navigationController pushViewController:newCtr animated:YES];
    
    
}

- (IBAction)toHistoryAction:(id)sender {
    
    
}

- (IBAction)toSettingAction:(id)sender {
    
    SettingController *setting = [[SettingController alloc] init];
    
    [self.navigationController pushViewController:setting animated:YES];
}


#pragma mark -
- (IBAction)takePhotoAction:(id)sender {
    [self.imagePickerController takePicture];
}


- (IBAction)backToPhotoAlumAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)changeCameraDevice:(id)sender{
    if (self.imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }else{
        self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
}

- (IBAction)changeFlashMode:(id)sender{
    
    UIButton *button = sender;
    
    if (self.imagePickerController.cameraFlashMode == UIImagePickerControllerCameraFlashModeAuto) {
        self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        
        [button setTitle:@"On" forState:UIControlStateNormal];
    }else if(self.imagePickerController.cameraFlashMode == UIImagePickerControllerCameraFlashModeOn){
        self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        
        [button setTitle:@"Off" forState:UIControlStateNormal];
    }else if(self.imagePickerController.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff){
        self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        
        [button setTitle:@"Auto" forState:UIControlStateNormal];
    }
}


#pragma mark - 相册、相机. toCameraAction使用自定义相机，未用此处的相机
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        
        imagePickerController.showsCameraControls = NO;
        
        
        
        self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
        imagePickerController.cameraOverlayView = self.overlayView;
        
        imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        
        if (isIPhone()) {
            
            CGFloat scale = CGRectGetHeight(self.overlayView.frame) / (320 * 4.0 / 3);
            
            CGAffineTransform transform = CGAffineTransformScale(imagePickerController.cameraViewTransform, scale, scale);
            
            imagePickerController.cameraViewTransform = CGAffineTransformTranslate(transform, 0, abs(50));
        }
        
        
//        self.overlayView = nil;
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    
    selectedImage = image;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"编辑模式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"标准" otherButtonTitles:@"蒙版", @"剪切", nil];
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - table DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%d",_photos.count);
    return _photos.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor yellowColor];
    
    UIImageView *imageView;
    UIView *view = [cell viewWithTag:111];
    if (view) {
        imageView = (UIImageView *)view;
    }else{
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        
        [cell addSubview:imageView];
    }
    
    ALAsset *asset = self.photos[indexPath.row];
    CGImageRef thumbnailImageRef = [asset thumbnail];
    imageView.image = [UIImage imageWithCGImage:thumbnailImageRef];
    
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ViewCtrFooter *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterIdentifier forIndexPath:indexPath];
        
        view.footerBlock = ^(){
            
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        };
        
        return view;
    }
    
    return nil;
}

#pragma mark - table Delegate

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ALAsset *asset = self.photos[indexPath.row];
    ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
    
    UIImage *fullScreenImage = [UIImage imageWithCGImage:[assetRepresentation fullScreenImage]
                                                   scale:[assetRepresentation scale]
                                             orientation:UIImageOrientationUp];
    
    selectedImage = fullScreenImage;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"编辑模式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"标准" otherButtonTitles:@"蒙版", @"剪切", nil];
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    NSLog(@"viewController：%@",NSStringFromCGSize(fullScreenImage.size));
    
}

#pragma mark - UIActionSheetDelegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            
            NewController *newCtr = [[NewController alloc] init];
            
            newCtr.image = selectedImage;
            
            [self.navigationController pushViewController:newCtr animated:YES];
            
        }
            break;
        case 1:
        {
            /*PsImageController *psCtr = [[PsImageController alloc] init];
            
            psCtr.isStandard = NO;
            
            psCtr.image = selectedImage;
            
            [self.navigationController pushViewController:psCtr animated:YES];*/
            
            
            
            CIFilterController *cifCtr = [[CIFilterController alloc] init];
            cifCtr.isStandard = NO;
            cifCtr.image = selectedImage;
            [self.navigationController pushViewController:cifCtr animated:YES];
        }
            break;
        case 2:
        {
            EditImageController *editCtr = [[EditImageController alloc] init];
            
            editCtr.isStandard = NO;
            
            editCtr.image = selectedImage;
            
            [self.navigationController pushViewController:editCtr animated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
}
@end
