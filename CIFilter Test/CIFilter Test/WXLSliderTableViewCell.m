//
//  WXLSliderTableViewCell.m
//  CIFilter Test
//
//  Created by Kiven Wang on 14-4-22.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "WXLSliderTableViewCell.h"

@implementation WXLSliderTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changeValueAction:(UISlider *)sender {
    
    CGFloat minValue = _label_minValue.text.floatValue;
    CGFloat maxValue = _label_maxValue.text.floatValue;
    CGFloat curValue = minValue + (maxValue - minValue) * sender.value;
    
    _label_curValue.text = [NSString stringWithFormat:@"%g",curValue];
    
    if (self.cellBlock) {
        self.cellBlock(self,curValue);
    }
}


- (void) loadSilderValue
{
    CGFloat minValue = _label_minValue.text.floatValue;
    CGFloat maxValue = _label_maxValue.text.floatValue;
    
    CGFloat curValue = _label_curValue.text.floatValue;
    
    slider_curValue.value = (curValue - minValue) / (maxValue - minValue);
}
@end
