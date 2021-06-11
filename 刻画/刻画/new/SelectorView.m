//
//  SelectorView.m
//  刻画
//
//  Created by apple on 13-12-18.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import "SelectorView.h"
#import "SelectorCell.h"

@implementation SelectorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    
    return self;
}

- (void) initData
{
    _bgImages = [NSMutableDictionary dictionary];
    NSArray *colors = @[[UIColor blackColor], [UIColor whiteColor], [UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor cyanColor], [UIColor blueColor], [UIColor purpleColor]];
    [_bgImages setObject:colors forKey:@"colors"];
    
    
    _nibs = [NSMutableDictionary dictionary];
    _paths = [NSMutableArray array];
    
    _currArray = [NSArray array];
}

- (void) setHidden:(BOOL)hidden
{
    CGRect frame = self.frame;
    CGFloat supHeight = self.superview.frame.size.height;
    frame.origin.y = supHeight - 44 - frame.size.height;
    
    self.frame = frame;
    //-----渐变显示、隐藏-----
    [self beginFadeAnimation];
    
    [super setHidden:hidden];
}

- (void) setSelectorType:(SelectorType)selectorType
{
    _selectorType = selectorType;
    
    switch (_selectorType) {
        case SelectorTypeImage:
        {
            
            _currArray = [_bgImages objectForKey:@"colors"];
            
            if (_segCtr.numberOfSegments == 2) {
                [_segCtr insertSegmentWithTitle:@"" atIndex:2 animated:NO];
            }
            
            [_segCtr setTitle:@"单色" forSegmentAtIndex:0];
            [_segCtr setTitle:@"相册" forSegmentAtIndex:1];
            [_segCtr setTitle:@"相机" forSegmentAtIndex:2];
            
            _segCtr.selectedSegmentIndex = 0;
            
            _selectorSubType = BackGroundTypeColor;
        }
            break;
        case SelectorTypeNib:
        {
            if (_segCtr.numberOfSegments == 2) {
                [_segCtr insertSegmentWithTitle:@"" atIndex:2 animated:NO];
            }
            
            [_segCtr setTitle:@"几何" forSegmentAtIndex:0];
            [_segCtr setTitle:@"花朵" forSegmentAtIndex:1];
            [_segCtr setTitle:@"动物" forSegmentAtIndex:2];
            
            _segCtr.selectedSegmentIndex = 0;
        }
            break;
        case SelectorTypePath:
        {
            if (_segCtr.numberOfSegments == 3) {
                [_segCtr removeSegmentAtIndex:2 animated:NO];
            }
            
            [_segCtr setTitle:@"几何" forSegmentAtIndex:0];
            [_segCtr setTitle:@"万花筒" forSegmentAtIndex:1];
            
            _segCtr.selectedSegmentIndex = 0;
        }
            break;
            
        default:
            break;
    }
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SelectorCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _currArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    NSURL *url;
    if (_selectorType == SelectorTypeImage) {
        
        [cell.imageView setImage:getImage([_currArray objectAtIndex:indexPath.row], CGSizeMake(50, 50))];
        
        return cell;
        
    }else if(_selectorType == SelectorTypeNib){
        url = [NSURL URLWithString:@"http://a.hiphotos.baidu.com/image/h%3D1050%3Bcrop%3D0%2C0%2C1680%2C1050/sign=f61a21890d2442a7b10ef9a5e4739628/f11f3a292df5e0fef16e920b5e6034a85edf7241.jpg"];
    }else if(_selectorType == SelectorTypePath){
        url = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/w%3D1680%3Bcrop%3D0%2C0%2C1680%2C1050/sign=9cf7e7d5cc1b9d168ac79e67cbee8fec/a8ec8a13632762d01d32d1b5a2ec08fa513dc6a8.jpg"];
    }else{
        url = [NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/h%3D1050%3Bcrop%3D0%2C0%2C1680%2C1050/sign=e8ef43ec2d2eb938f36d7ef2e052be56/09fa513d269759ee816520c6b0fb43166d22df82.jpg"];
    }
//    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] options:SDWebImageLowPriority];
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] options:SDWebImageLowPriority];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_selectorType) {
        case SelectorTypeNone:
        {
            
        }
            break;
        case SelectorTypeImage:
        {
            if (_selectorSubType == BackGroundTypeColor) {
                [_delegate selectorView:self didSelectedBackgroundImage:nil orColor:[_currArray objectAtIndex:indexPath.row] withBackGroundType:BackGroundTypeColor];
            }
        }
            break;
        case SelectorTypePath:
        {
            [_delegate selectorView:self didSelectedPath:SelectorPathLine];
        }
            break;
        case SelectorTypeNib:
        {
            [_delegate selectorView:self didSelectedNib:SelectorNibPoint withImage:nil];
        }
            break;
            
        default:
            break;
    }
    
    [self setHidden:YES];
}

- (IBAction)changeValueAction:(id)sender {
    
    
    
    switch (_selectorType) {
        case SelectorTypeImage:
        {
            
            if (_segCtr.selectedSegmentIndex == 0) {
                
            }else{
                UIImagePickerControllerSourceType imagetype;
                if (_segCtr.selectedSegmentIndex == 1)
                    imagetype = UIImagePickerControllerSourceTypePhotoLibrary;
                else
                    imagetype = UIImagePickerControllerSourceTypeCamera;
                
                if (![UIImagePickerController isSourceTypeAvailable:imagetype]) {
                    NSLog(@"imagetype = NO");
                    return ;
                }
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = imagetype;
//                picker.allowsEditing = NO;
//                picker.cameraOverlayView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//                picker.showsCameraControls=NO;
//                picker.toolbarHidden=YES ;
                
//                picker.wantsFullScreenLayout=YES;
//                picker.cameraOverlayView=[self getController].view;
//                picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagetype];
//                picker.mediaTypes = @[(NSString *)kUTTypeImage];
//                picker.showsCameraControls = NO;
                picker.delegate = self;
                
                
                [[self getController] presentViewController:picker animated:YES completion:^{
                    
                }];
                
                _segCtr.selectedSegmentIndex = 0;
            }
            
        }
            break;
        case SelectorTypeNib:
        {
            switch (_segCtr.selectedSegmentIndex) {
                case 0:
                {
                    
                }
                    break;
                    
                case 1:
                {
                    
                }
                    break;
                    
                case 2:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case SelectorTypePath:
        {
            switch (_segCtr.selectedSegmentIndex) {
                case 0:
                {
                    
                }
                    break;
                    
                case 1:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SelectorCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    
    [_collectionView reloadData];
    
    
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectorView: didSelectedBackgroundImage: orColor: withBackGroundType:)]) {
        [_delegate selectorView:self didSelectedBackgroundImage:image orColor:nil withBackGroundType:BackGroundTypeImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    [self setHidden:YES];
}

#pragma mark - UINavigationControllerDelegate

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

@end
