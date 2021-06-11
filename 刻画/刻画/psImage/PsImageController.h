//
//  PsImageController.h
//  刻画
//
//  Created by Kiven Wang on 14-3-31.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PsImageDelegate <NSObject>

- (void) psImageFinshWith:(UIImage *) image;

@end

@interface PsImageController : UIViewController

@property (nonatomic) BOOL isStandard;

@property (strong, nonatomic) UIImage *image;

@property (assign, nonatomic) id<PsImageDelegate> delegate;

@end
