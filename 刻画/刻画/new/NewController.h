//
//  NewController.h
//  刻画
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectorView.h"
#import "DrawPadView.h"


@interface NewController : UIViewController



@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet DrawPadView *drawPadView;
@property (strong, nonatomic) UIImage *image;





- (IBAction)toExitAction:(id)sender;

- (IBAction)toRemoveAction:(id)sender;

- (IBAction)toBackAction:(id)sender;

- (IBAction)toProntAction:(id)sender;

- (IBAction)toSaveOrShareAction:(id)sender;

@end
