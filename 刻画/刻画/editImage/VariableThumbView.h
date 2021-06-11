//
//  VariableThumbView.h
//  刻画
//
//  Created by Kiven Wang on 14-3-31.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ThumbTypeScreen,
    ThumbTypeBox,
    ThumbTypeImage,
    ThumbTypeFree
} ThumbType;

@interface VariableThumbView : UICollectionViewCell
{
    IBOutlet UIImageView *selectedView;
}

@property (nonatomic) ThumbType thumbType;

@end
