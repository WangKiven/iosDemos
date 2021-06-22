//
//  CammraCell.h
//  刻画
//
//  Created by Kiven Wang on 14-3-24.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CammraCell : UICollectionViewCell
{
    IBOutlet UIImageView *selectedView;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end
