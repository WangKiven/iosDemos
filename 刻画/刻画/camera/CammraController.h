//
//  CammraController.h
//  刻画
//
//  Created by Kiven Wang on 14-3-21.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"



typedef void(^CammraBlock)(UIImage *image);

@interface CammraController : UIViewController
{
    
    GPUImageStillCamera *stillCamera;
    
    GPUImageOutput<GPUImageInput> *filter;//记录在用的filter
    NSArray *filterAr;//提供的所有filter
    
    IBOutlet UIImageView *thumbView;
    
    IBOutlet UICollectionView *collectionView;
    
    IBOutlet UIImageView *coverView;//界面出现时显示的图片
    
}

@property (nonatomic, strong) CammraBlock cammrablock;


@end
