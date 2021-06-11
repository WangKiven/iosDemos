//
//  WXLSliderTableViewCell.h
//  CIFilter Test
//
//  Created by Kiven Wang on 14-4-22.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXLSliderTableViewCell;
typedef void(^WXLSliderCellBlock)(WXLSliderTableViewCell *cell,CGFloat changedValue);

@interface WXLSliderTableViewCell : UITableViewCell
{
    
    IBOutlet UISlider *slider_curValue;
}

@property (strong, nonatomic) WXLSliderCellBlock cellBlock;


@property (strong, nonatomic) IBOutlet UILabel *label_attriName;

@property (strong, nonatomic) IBOutlet UILabel *label_minValue;

@property (strong, nonatomic) IBOutlet UILabel *label_curValue;

@property (strong, nonatomic) IBOutlet UILabel *label_maxValue;

- (IBAction)changeValueAction:(UISlider *)sender;

- (void) loadSilderValue;


@end
