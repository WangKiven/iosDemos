//
//  ShareOrSaveImage.m
//  刻画
//
//  Created by Kiven Wang on 14-4-1.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "ShareOrSaveImage.h"
#import <Photos/Photos.h>


void ToShareOrSaveImage(UIImage *image, UIView *view)
{
    [ShareOrSaveImage toShareOrSaveImage:image Type:SOSTypeShareOrSave View:view];
}

void ToShareOrSaveImage2(UIImage *image, SOSType sosType, UIView *view)
{
    [ShareOrSaveImage toShareOrSaveImage:image Type:sosType View:view];
}

@interface ShareOrSaveImage ()<UIActionSheetDelegate>
{
    
}
@end
@implementation ShareOrSaveImage

+ (id) singleSOS
{
    static ShareOrSaveImage *sos;
    if (!sos) {
        sos = [[ShareOrSaveImage alloc] init];
    }
    return sos;
}

+ (void) toShareOrSaveImage:(UIImage *) image Type:(SOSType) sosType View:(UIView *) view
{
    ShareOrSaveImage *sos = [ShareOrSaveImage singleSOS];
    
    sos.image = image;
    
    sos.sosType = sosType;
    
    sos.view = view;
    
    [sos start];
    
    
}

- (void) start
{
    switch (_sosType) {
        case SOSTypeShareOrSave:
        {
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享或保存" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles:@"分享", nil];
            
            [actionSheet showInView:getWindow()];
        }
            break;
        case SOSTypeShare:
        {
            [self shareImage];
        }
            break;
        case SOSTypeSave:
        {
            [self saveImage];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - UIActionSheetDelegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            [self saveImage];
        }
            break;
        case 1:
        {
            [self shareImage];
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
#pragma mark - 保存图片到相册    获取画后的图片
- (void) saveImage
{
    
//    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 200, 200)];
//    vi.backgroundColor = [UIColor redColor];
//    
//    [getWindow() addSubview:vi];
//    [getWindow() bringSubviewToFront:vi];
    /*[library saveImage:self.image toAlbum:@"PhotoEdit" completion:^(NSURL *assetURL, NSError *error) {
        [UIMessageBox showMessageBoxInView:self.view withText:@"保存图片成功"];
        
        [UIMessageBox hideMessageBoxInView:self.view];
//        [self showMessage:@"保存图片成功"];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存图片失败,请确定已允许本软件访问相册。查看路径“设置 -> 隐私 -> 照片”" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];*/
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 请求通过一个图片创建一个资源。
            PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self.image];
             // 请求编辑这个相簿。
            PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:NULL]];
             // 得到一个新的资源的占位对象并添加它到相簿编辑请求中。
            PHObjectPlaceholder *assetPlaceholder = [createAssetRequest placeholderForCreatedAsset];
            [albumChangeRequest addAssets:@[ assetPlaceholder ]];
         } completionHandler:^(BOOL success, NSError *error) {
            NSLog(@"操作结束，%@", (success ? @"保存图片成功。" : error));
             
        }];
    
//    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
/*
- (void) image:(UIImage *)image didFinishSavingWithError:(NSError *) error contextInfo:(void *) contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存图片失败,请确定已允许本软件访问相册。查看路径“设置 -> 隐私 -> 照片”" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }else{
        
        [UIMessageBox showMessageBoxInView:getWindow() withText:@"保存图片成功"];
        
        [UIMessageBox hideMessageBoxInView:getWindow()];
    }
    
    
}
*/
- (void) shareImage
{
    /*FrontiaShare *share = [Frontia getShare];
    
    [share registerQQAppId:QQID enableSSO:NO];
    [share registerWeixinAppId:WEIXINID];
    [share registerSinaweiboAppId:SINAWEIBO];
    
    
    
    //授权取消回调函数
    FrontiaShareCancelCallback onCancel = ^(){
        NSLog(@"OnCancel: share is cancelled");
        [UIMessageBox showMessageBoxInView:getWindow() withText:@"分享已取消"];
        
        [UIMessageBox hideMessageBoxInView:getWindow()];
    };
    
    //授权失败回调函数
    FrontiaShareFailureCallback onFailure = ^(int errorCode, NSString *errorMessage){
        NSLog(@"OnFailure: %d  %@", errorCode, errorMessage);
        [UIMessageBox showMessageBoxInView:getWindow() withText:@"分享失败"];
        
        [UIMessageBox hideMessageBoxInView:getWindow()];
    };
    
    //授权成功回调函数
    FrontiaMultiShareResultCallback onResult = ^(NSDictionary *respones){
        NSLog(@"OnResult: %@", [respones description]);
        [UIMessageBox showMessageBoxInView:getWindow() withText:@"分享成功"];
        
        [UIMessageBox hideMessageBoxInView:getWindow()];
    };
    
    FrontiaShareContent *content=[[FrontiaShareContent alloc] init];
    content.isShareImageToApp = YES;
    //    content.url = @"http://www.suinapp.com";
    //    content.title = @"PhotoEdit图片分享";
    //    content.description = @"我出新图了，大家快乐围观啊！";
    content.imageObj = self.image;
    
    
    NSArray *platforms = @[FRONTIA_SOCIAL_SHARE_PLATFORM_QQFRIEND, FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION];
    
    [share showShareMenuWithShareContent:content displayPlatforms:platforms supportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait isStatusBarHidden:NO targetViewForPad:nil cancelListener:onCancel failureListener:onFailure resultListener:onResult];
     */
    
}

@end
