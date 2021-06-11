//
//  AddFilterToLayerController.h
//  CIFilter Test
//
//  Created by Kiven Wang on 14-7-23.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterView : UIView

@end

@interface FilterLayer : CALayer

@end


@interface AddFilterToLayerController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
