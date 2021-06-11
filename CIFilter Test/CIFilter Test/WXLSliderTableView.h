//
//  WXLSliderTableView.h
//  CIFilter Test
//
//  Created by Kiven Wang on 14-4-22.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ATTRIBUTE_NAME  @"attribute_name"
#define MIN_VALUE @"min_value"
#define MAX_VALUE @"max_value"
#define CUR_VALUE @"cur_value"



@class WXLSliderTableView;

@protocol WXLSliderTableViewDelegate <NSObject>

- (void) tableView:(WXLSliderTableView *) tableView attribute:(NSString *) attributeName changedValue:(CGFloat) changedValue;

@end

@interface WXLSliderTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) IBOutlet id<WXLSliderTableViewDelegate> sliderDelegate;

@property (strong, nonatomic) NSMutableDictionary *dataDic;


- (void) addData:(NSString *) attributeName MinValue:(CGFloat) minValue MaxValue:(CGFloat) maxValue CurValue:(CGFloat) curValue;
- (void) clearData;

@end
