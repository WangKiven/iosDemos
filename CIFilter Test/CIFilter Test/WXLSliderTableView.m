//
//  WXLSliderTableView.m
//  CIFilter Test
//
//  Created by Kiven Wang on 14-4-22.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "WXLSliderTableView.h"
#import "WXLSliderTableViewCell.h"

@implementation WXLSliderTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self installData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self installData];
    }
    return self;
}

- (void) installData
{
    self.delegate = self;
    self.dataSource = self;
    
    self.dataDic = [NSMutableDictionary dictionary];
}

- (void) addData:(NSString *) attributeName MinValue:(CGFloat) minValue MaxValue:(CGFloat) maxValue CurValue:(CGFloat) curValue
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%g",minValue],MIN_VALUE, [NSString stringWithFormat:@"%g",maxValue],MAX_VALUE, [NSString stringWithFormat:@"%g",curValue],CUR_VALUE, nil];
    
    [self.dataDic setObject:dic forKey:attributeName];
    
    self.hidden = NO;
}
- (void) clearData
{
    [self.dataDic removeAllObjects];
    
    self.hidden = YES;
}
#define mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"cell";
    
    WXLSliderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (!cell) {
        NSArray *ar = [[NSBundle mainBundle] loadNibNamed:@"WXLSliderTableViewCell" owner:self options:nil];
        cell = [ar objectAtIndex:0];
        
        cell.cellBlock = ^(WXLSliderTableViewCell *cell1,CGFloat changedValue){
            if (self.sliderDelegate && [self.sliderDelegate respondsToSelector:@selector(tableView:attribute:changedValue:)]) {
                NSIndexPath *path = [tableView indexPathForCell:cell1];
                
                NSArray *allkeys = [self.dataDic allKeys];
                
                NSString *attributeName = [allkeys objectAtIndex:path.row];
                
                [self.sliderDelegate tableView:self attribute:attributeName changedValue:changedValue];
            }
        };
    }
    
    NSArray *allkeys = [self.dataDic allKeys];
    
    NSString *attributeName = [allkeys objectAtIndex:indexPath.row];
    
    cell.label_attriName.text = attributeName;
    
    NSDictionary *dic = [self.dataDic objectForKey:attributeName];
    
    cell.label_minValue.text = [dic objectForKey:MIN_VALUE];
    cell.label_curValue.text = [dic objectForKey:CUR_VALUE];
    cell.label_maxValue.text = [dic objectForKey:MAX_VALUE];
    
    [cell loadSilderValue];
    
    return cell;
}

@end
