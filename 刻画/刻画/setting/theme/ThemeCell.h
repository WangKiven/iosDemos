//
//  ThemeCell.h
//  刻画
//
//  Created by Kiven Wang on 14-3-18.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Iden @"iden"

@interface ThemeCell : UICollectionViewCell
{
    IBOutlet UIImageView *selectedView;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
