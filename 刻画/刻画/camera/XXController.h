//
//  XXController.h
//  刻画
//
//  Created by Kiven Wang on 14-3-26.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@interface XXController : UIViewController
{
    
    GPUImageStillCamera *stillCamera;
    
    GPUImageOutput<GPUImageInput> *filter;
}
@end
