//
//  EditImageController.h
//  刻画
//
//  Created by Kiven Wang on 14-3-24.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableView.h"

@protocol EditImageControllerDelegate <NSObject>

- (void) editImageFinshWith:(UIImage *) image;

@end

@interface EditImageController : UIViewController

@property (nonatomic) BOOL isStandard;

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) id<EditImageControllerDelegate> delegate;


@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet  VariableView *variableView;

@end
